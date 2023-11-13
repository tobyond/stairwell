 SELECT
	*
FROM
	myothertable
WHERE
	column_a = :foo
	AND column_b IN(:moo)
	AND column_c IN(:goo);
