#!/usr/bin/env coffee


module.exports = forkJoin = ->
  counter = 0

  joiner = ->

  fork: (fn) ->
    counter++
    process.nextTick ->
      fn -> joiner() if --counter == 0

  join: (fn) ->
    joiner = fn


log = -> console.log arguments...

test = ->
  fojo = forkJoin()

  fojo.fork (done) ->
    log 'first starts'
    setTimeout ->
      log 'first ends'
      done()
    , 2000

  fojo.fork (done) ->
    log 'second starts'
    setTimeout ->
      log 'second ends'
      done()
    , 2500

  fojo.fork (done) ->
    log 'third starts'
    setTimeout ->
      log 'third ends'
      done()
    , 1000

  fojo.join ->
    log 'all done'

test() if require.main == module
