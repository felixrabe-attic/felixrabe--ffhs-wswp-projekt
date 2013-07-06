p <- read.csv('../population/040-csv-for-r/population.csv',
  colClasses = c('factor', 'integer', 'factor', 'factor', 'numeric'))

p <- data.frame(area = p$area, year = p$year, age = p$age, sex = p$sex, population = p$population * 1000)

ages <- c('0-4', '5-9', '10-14', '15-19', '20-24', '25-29', '30-34', '35-39', '40-44', '45-49', '50-54', '55-59', '60-64', '65-69', '70-74', '75-79', '80+')
