#!/usr/bin/env coffee

csv = require 'csv'
forkJoin = require './fork-join.coffee'
Stream = require 'stream'
fs = require 'fs'

resolve = -> require('path').resolve __dirname, arguments...

# Field (column) definitions

preFields = [
  'index', 'variant', 'area', 'notes', 'code', 'year'
]

ageFields = [
  '0-4', '5-9', '10-14', '15-19', '20-24', '25-29'
  '30-34', '35-39', '40-44', '45-49', '50-54', '55-59'
  '60-64', '65-69', '70-74', '75-79', '80+', '80-84', '85-89'
  '90-94', '95-99', '100+'
]

inputFields = preFields.concat ageFields

outputFields = ['area', 'year', 'age', 'sex', 'population']

# Output stream

# outcnt = 0

# file = fs.createWriteStream '/tmp/perfect.csv'

# outstr = new Stream()
# outstr.writable = true
# outstr.write = (d) ->
#   tillFull = ->
#     unless file.write d
#       file.once 'drain', tillFull
#       return
#   tillFull()
#   console.log "#{outcnt} #{JSON.stringify d}" if ++outcnt % 20000 == 1
#   true
# outstr.end = ->
#   console.log 'end'

outputStream = csv()
.to(resolve('./population.csv'), columns: outputFields)
# .to outstr, columns: outputFields

outputStream.write outputFields

# Process each input stream

fojo = forkJoin()

# for sex in ['both', 'female', 'male']
# for sex in ['both', 'female']
for sex in ['both']
  do (sex) ->
    fojo.fork (done) ->
      inputStream = csv()
      .from(resolve("../030-trimmed-csv/population-#{sex}.csv"), columns: inputFields)
      # .from(resolve("../030-trimmed-csv/population-#{sex}-2.csv"), columns: inputFields)
      .on 'record', (row, index) ->
        return undefined if index == 0
        # console.log "record #{sex}"
        canContinue = true
        for age in ageFields
          outputRow = {
            area:       row.area
            year:       row.year
            age
            sex
            population: row[age]
          }
          canContinue &&= outputStream.write outputRow
        unless canContinue
          console.log "false at #{index}"
          inputStream.pause()
          outputStream.once 'drain', ->
            console.log "resume"
            inputStream.resume()
          # process.exit 1
      .on 'end', ->
        console.log "end #{sex}"
        done()
  fojo.join ->
    console.log "END ALL"
    outputStream.end()

