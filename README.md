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

## Usage

Define a class in your app that inherits from `Stairwell::Query`. We're going to assume you are in a rails app, but this will work in any ruby app, ActiveRecord is not a dependency here.
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
    ;
  SQL
end

# if you pass in the following named binds:

binds = {
  name: "First",
  age: 99,
  active: true,
  gpa: 4.2
  date_joined: "2008-08-28",
  created_at: "2008-08-28 23:41:18",
}

# and call the following:

UsersSql.sql(binds)

# You will receive the following result:

"SELECT * FROM users WHERE name = 'First' age = 99 active = TRUE date_joined = '2008-08-28' created_at = '2008-08-28 23:41:18' gpa = 4.2;"
```

Binds passed in are validated against the validate_type, so if you have a validate_type you must include that value in your binds hash.
They types of the binds are validated too.
The names binds in your sql are also validated.
Strings are quoted. Dates are quoted. Datetime is quoted.

Tested in both Mysql and Postgres.

## Known issues

* nil/NULL values are not currently supported. Just use `IS NULL` or `IS NOT NULL` in your query for the time being.
* Date/Datetime are not validated for their format, it is expected that you will pass the correct format.
* Datetime in postgres is not currently working for equality, only for `>` or `<` or `>=` or `<=`
* Column/table quoting is not currently available.
* `IN` statements with arrays support is forthcoming.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tobyond/stairwell.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
