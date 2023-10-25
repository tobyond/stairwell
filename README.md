# Stairwell

Making SQL more accessible while maintaining safety in Rails projects.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'stairwell'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install stairwell

## Why?
Although ActiveRecord serves as an excellent tool for the majority of database queries, certain scenarios call for more customized queries.
This project was initially conceived to help transition a development team and their project from PHP to Ruby. This PHP project had thousands of complex SQL queries, thus the necessity of making SQL a first-class citizen in the ruby project enabled a smoother transition.
So, why not Arel? Arel is a powerful tool, but it's worth noting that it is considered a private API and is likely to remain so for the forseeable future.
Does this approach make queries less composable? Yes, if you are used to chaining your arel queries and AR scopes then you're probably not going to use this. However, it provides an interface that enables you to leverage SQL securely in your Ruby projects without the need to reinvent the wheel.

## Usage

Define a class in your app that inherits from `Stairwell::Query`. We're going to assume you are in a rails app, but this will work in any ruby app, although ActiveRecord is a dependency of this gem.
In rails you could create a directory called `app/queries` for instance.

Define your `validate_type`, which will be the arguments you send in, and their type. For instance, if your query looks like this: `SELECT * FROM users WHERE name = :name`, and name is a `String`, your `validate_type` will look like this `validate_type :name, :string`, and you'll pass in a hash of your binds like this: `{ name: "<name value>" }`

Here's an example:
```ruby
class UsersSql < Stairwell::Query
  validate_type :name, :string
  validate_type :age, :integer
  validate_type :active, :boolean
  validate_type :gpa, :float
  validate_type :date_joined, :sql_date
  validate_type :created_at, :sql_date_time
  validate_type :favorite_numbers, [:integer]

  query <<-SQL
    SELECT
      *
    FROM users
    WHERE name = :name
      AND age = :age
      AND active = :active
      AND gpa = :gpa
      AND date_joined = :date_joined
      AND created_at >= :created_at
      AND favorite_numbers IN (:favorite_numbers)
    ;
  SQL
end

# if you pass in the following named binds:

binds = {
  name: "First",
  age: 99,
  active: true,
  gpa: 4.2,
  date_joined: "2008-08-28",
  created_at: "2008-08-28 23:41:18",
  favorite_numbers: [4, 7, 100]
}

# and call the following:

UsersSql.sql(binds)

# You will receive the following result:

"SELECT * FROM users WHERE name = 'First' AND age = 99 AND active = TRUE AND date_joined = '2008-08-28' AND created_at >= '2008-08-28 23:41:18' AND gpa = 4.2 AND favorite_numbers IN (4, 7, 100) ;"
```

Binds passed in are validated against the validate_type, so if you have a validate_type you must include that value in your binds hash.
They types of the binds are validated too.
The names binds in your sql are also validated.
All types are quoted using ActiveRecord quoting, which will be different depending on your database type (Mysql, postgres etc.)

## Supported Types

| Type         | Values Accepted      | Info                                                                                                 |
|--------------|----------------------|------------------------------------------------------------------------------------------------------|
| :boolean     | TrueClass/FalseClass | Not fully supported since many databases require 'IS TRUE' or 'IS FALSE'                             |
| :column_name | String               | for quoting a column name                                                                            |
| :date_time   | String               | only taking the actual string for now                                                                |
| :date        | String               | only taking the actual string for now                                                                |
| :float       | Float                |                                                                                                      |
| [<type>]     | Array                | will quote any type provided in the array [:integer]                                                 |
| :integer     | Integer              |                                                                                                      |
| :null        | NilClass             | nil/NULL values are not completely supported since many databases require 'IS NULL' or 'IS NOT NULL' |
| :string      | String               |                                                                                                      |
| :table_name  | String               | for quoting a table name                                                                             |

## Known issues

* nil/NULL values are not completely supported, since many databases require `IS NULL`, or `IS NOT NULL`, you can use the null_type here, but it will only accept `nil`, and it will possibly not support what you're trying to do. YMMV.
* Date/Datetime are not validated for their format, it is expected that you will pass the correct format.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tobyond/stairwell.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
