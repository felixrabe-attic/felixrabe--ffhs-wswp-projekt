#!/usr/bin/env coffee

fs = require 'fs'
path = require 'path'
csv = require 'csv'

shortFields = [
  'area'
  '1965', '1966', '1967', '1968', '1969'
  '1970', '1971', '1972', '1973', '1974'
  '1975', '1976', '1977', '1978', '1979'
  '1980', '1981', '1982', '1983', '1984'
  '1985', '1986', '1987', '1988', '1989'
  '1990', '1991', '1992', '1993', '1994'
  '1995', '1996', '1997', '1998', '1999'
  '2000', '2001', '2002', '2003', '2004'
  '2005', '2006', '2007', '2008', '2009'
  '2010', '2011', '2012', '2011-to-2012'
  'share'
]

outputFields = [
  'area'
  '1965', '1966', '1967', '1968', '1969'
  '1970', '1971', '1972', '1973', '1974'
  '1975', '1976', '1977', '1978', '1979'
  '1980', '1981', '1982', '1983', '1984'
  '1985', '1986', '1987', '1988', '1989'
  '1990', '1991', '1992', '1993', '1994'
  '1995', '1996', '1997', '1998', '1999'
  '2000', '2001', '2002', '2003', '2004'
  '2005', '2006', '2007', '2008', '2009'
  '2010', '2011', '2012'
]

inputFile = path.resolve __dirname, '../030-trimmed-csv/energy.csv'
outputFile = path.resolve __dirname, '../040-csv-for-r/energy.csv'

inputStream = csv()
.from(inputFile, columns: shortFields)
.transform (row, index) ->
  if index == 0
    inputStream.write outputFields
  for n in [1965..2012].map((n) -> n.toString())
    if row[n] == '^' then row[n] = '0.025'
    if row[n] == '-' then row[n] = 'n/a'
  inputStream.write row if row.area != ''
  null
.to(outputFile, columns: outputFields)
