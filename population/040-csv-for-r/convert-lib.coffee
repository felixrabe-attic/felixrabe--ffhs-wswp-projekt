#!/usr/bin/env coffee

Q = require 'q'
csv = require 'csv'
fs = require 'fs'
csvStringifier = require 'csv/lib/stringifier'
_ = require 'lodash'

fields = require './convert-fields.coffee'

module.exports = lib =
  readAll: (files) ->
    files.reduce (promise, file) ->
      promise.then (soFar) ->
        d = Q.defer()
        lib.read(file)
        .then (newStuff) ->
          soFar.push newStuff
          d.resolve soFar
        d.promise
    , Q.resolve([])

  read: (fileName) ->
    console.log "Reading #{fileName}..."
    d = Q.defer()
    # setTimeout ->
    #   console.log "#{fileName} !"
    #   d.resolve ["#{fileName} !", 'a', 'b', 'c']
    # , 800
    result = []
    csv()
    .from(fileName, columns: fields.input)
    .on 'record', (row, index) ->
      return if index == 0
      result.push row
    .on 'end', ->
      d.resolve result
    d.promise

  transpose: (input) ->
    output = []
    for row in input
      for age in fields.partAge
        {area, year} = row
        pop = row[age]
        population = parseFloat(pop)
        if _.isNaN(population) and age == '80+'
          population = 0
          for a in ['80-84', '85-89', '90-94', '95-99', '100+']
            population += parseFloat row[a]
          population = population.toFixed 3
        population = if _.isNaN(population) then pop else population
        outputRow = {
          area
          year
          age
          population
        }
        output.push outputRow
    Q output

  checkup: (o) ->
    same = (o) -> [o.area, o.year, o.age]
    for i in [0...o['both'].length]
      both = o['both'][i]
      female = o['female'][i]
      male = o['male'][i]
      unless _.isEqual(same(both), same(female)) and _.isEqual(same(both), same(male))
        throw new Error 'Structure differs'
      if Math.abs(male.population + female.population - both.population) > 0.002
        throw new Error "Difference too big at #{i}"
    Q o

  toStreamable: (o) ->
    streamable = []
    for sex in ['female', 'male']
      streamable = streamable.concat o[sex].map (row) ->
        row['sex'] = sex
        row
    Q streamable

  write: (streamable, fileName) ->
    _csv = csv()
    _csv.to.options columns: fields.output
    csvLine = (line) -> _csv.stringifier.stringify(line) + "\n"

    wStream = fs.createWriteStream fileName
    wStream.write csvLine fields.output

    i = 0
    cont = ->  # http://stackoverflow.com/a/14595105/1034080
      while i < streamable.length
        unless wStream.write csvLine(streamable[i++])
          wStream.once 'drain', cont
          return
      wStream.end()

    cont()
    undefined


test = ->


test() if require.main == module
