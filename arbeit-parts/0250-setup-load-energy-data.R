e <- read.csv('../energy/040-csv-for-r/energy.csv',
  colClasses = c('factor', 'numeric', 'numeric'), na.strings = c('n/a'))


# Recode countries:
# Does not work: e$area[e$area == 'country old'] <- 'country new'  # R in Action, p.77
# Solution: http://stackoverflow.com/a/13045045/1034080

areas = levels(e$area)

levels(e$area)[which(areas == 'China Hong Kong SAR')] <- 'China, Hong Kong SAR'
levels(e$area)[which(areas == 'Iran')]                <- 'Iran (Islamic Republic of)'
levels(e$area)[which(areas == 'Republic of Ireland')] <- 'Ireland'
levels(e$area)[which(areas == 'South Korea')]         <- 'Republic of Korea'
levels(e$area)[which(areas == 'Total Africa')]        <- 'AFRICA'
levels(e$area)[which(areas == 'Total Asia Pacific')]  <- 'ASIA'
levels(e$area)[which(areas == 'Total World')]         <- 'WORLD'
levels(e$area)[which(areas == 'Trinidad & Tobago')]   <- 'Trinidad and Tobago'
levels(e$area)[which(areas == 'US')]                  <- 'United States of America'
levels(e$area)[which(areas == 'Venezuela')]           <- 'Venezuela (Bolivarian Republic of)'
levels(e$area)[which(areas == 'Vietnam')]             <- 'Viet Nam'
