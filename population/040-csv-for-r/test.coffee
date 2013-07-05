#!/usr/bin/env coffee

Q = require 'q'

conv = (x, del) ->
  # d = Q.defer()
  # setTimeout ->
  #   d.resolve x + x
  # , del
  # d.promise
  Q 3*x

Q()
.then ->
  console.log 'A'
  Q.all(conv(a, b) for [a, b] in [[13, 500], [14, 200], [15, 100]])
.then (abc) ->
  console.dir abc




# csv = require 'csv'


# out = csv()
# .to('/tmp/test.csv')

# for x in [0...10000]
#   out.write ['x , is', x]

# out.end()
















# // node samples/string.js
# var csv = require('csv');
# csv()
# .from( '#Welcome\n"1","2","3","4"\n"a","b","c","d"' )
# .to( function(data){
#   console.log data
# } );
# // [ 'a', 'b', 'c', 'd' ] [ 1, 2, 3, 4 ]



# c = csv()
# .to process.stdout, columns: [ 'A', 'B', 'C', 'D' ]

# c.write ['a', 'b', 'c,x', 'd']
# c.write [1, 2, 3, 4]
# c.write C: 77, B: 66, A: 55, D: 88

# console.log()



# counter = 0

# out = csv()
# .to (data) ->
#   # counter++
#   # console.log "out #{counter}" if counter % 1000 == 0
#   console.log JSON.stringify data
# .on 'end', (count) ->
#   console.log "Number of lines: #{count} or #{counter}"

# for x in [0...10]
#   # console.log "in #{x}" if x % 1000 == 0
#   out.write ['something,nasty', 'is happens,here']
# out.end()



# o = csv()
# .to (data) ->
#   console.log JSON.stringify data

# o.write ['holla', 'there , you']
# o.end()
