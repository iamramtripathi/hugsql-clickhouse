-- fns.sql
-- Test Functions

-- :name create-test-database
-- :command :execute
-- :result :raw
-- :doc Create a test database
CREATE DATABASE IF NOT EXISTS test

-- :name create-colors-table
-- :command :execute
-- :result :raw
-- :doc Create a test table of colors
CREATE TABLE IF NOT EXISTS test.colors
(
  `id` UInt8,
  `name` String,
  `rgb` Array(UInt8),
  `intensity` Enum8('high' = 0, 'low' = 1),
  `synonyms` Array(String),
  `cmyk` Array(Array(Float64))
)
ENGINE = MergeTree
PARTITION BY (`id`)
ORDER BY (`id`)
PRIMARY KEY (`id`)
SETTINGS index_granularity=8192

-- :name insert-color :!
-- :command :execute
-- :result :raw
-- :doc Insert a color into the colors table
INSERT INTO test.colors (:i*:ks)
VALUES (:v*:vs)

-- :name delete-color-by-id
-- :command :execute
-- :result :raw
-- :doc Delete a color by the given `id`
ALTER TABLE test.colors DELETE WHERE id = :id

-- :name add-column
-- :command :execute
-- :result :raw
-- :doc Add a column
ALTER TABLE :tbl ADD COLUMN :col :typ

-- :name select-color-by-id :? :1
-- :command :query
-- :doc Select a color by id
SELECT * FROM test.colors WHERE id = :id LIMIT 1

-- :name select-all-colors :? :*
-- :command :query
-- :doc Select all colors
SELECT * FROM test.colors

-- :name drop-test-database
-- :command :execute
-- :result :raw
-- :doc Drop the test database
DROP DATABASE IF EXISTS test
