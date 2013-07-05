#!/usr/bin/env coffee

Q = require 'q'
lib = require './convert-lib.coffee'
_ = require 'lodash'

resolve = -> require('path').resolve __dirname, arguments...

sexes = ['both', 'female', 'male']

lib
.readAll(sexes.map (sex) -> resolve "../030-trimmed-csv/population-#{sex}.csv")
.then (allInput) ->
  Q.all(lib.transpose(input) for input in allInput)
.then (transposedInput) ->
  Q _.zipObject sexes, transposedInput
# .then(lib.checkup)
.then(lib.toStreamable)
.then (streamable) ->
  lib.write streamable, resolve './population.csv'

.fail (error) ->
  console.log error.stack
