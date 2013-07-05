# fs = require 'fs'
# csv = require 'csv'

# outputFields = [
#   'area', 'year'
#   '0-4', '5-9', '10-14', '15-19', '20-24', '25-29'
#   '30-34', '35-39', '40-44', '45-49', '50-54', '55-59'
#   '60-64', '65-69', '70-74', '75-79', '80+',
#   'total'
# ]

# for sex in ['both', 'female', 'male']
#   do (sex) ->
#     inputFile = path.resolve __dirname, "../030-trimmed-csv/population-#{sex}.csv"
#     outputFile = path.resolve __dirname, "./population-#{sex}.csv"

#     inputStream = csv()
#     .from(inputFile, columns: inputFields)
#     .transform (row, index) ->
#       if index == 0
#         inputStream.write outputFields
#         return undefined
#       sum = 0
#       for field in ageFields
#         try
#           row[field] = row[field].replace /\s/g, ''
#         catch e
#           console.log "#{index} #{field}"
#           throw e
#         sum += parseFloat(row[field]) || 0
#       row.total = sum.toFixed 3
#       row # if row.area in ['India', 'Switzerland', 'United States of America', 'WORLD']
#     .to(outputFile, columns: outputFields)
