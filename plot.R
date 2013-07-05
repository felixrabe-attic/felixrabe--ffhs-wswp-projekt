library(ggplot2)
theme_set(theme_bw())

library(plyr)

f <- function(x, ...) { format(x, ..., big.mark = "'", scientific = FALSE, trim = TRUE) }

setwd("/Users/fr/o/ffhs-wswp-projekt")

p <- read.csv("./population/040-csv-for-r/population.csv",
  colClasses = c("factor", "integer", "factor", "factor", "numeric"))

p <- data.frame(area = p$area, year = p$year, age = p$age, sex = p$sex, population = p$population * 1000)

ages <- c("0-4", "5-9", "10-14", "15-19", "20-24", "25-29", "30-34", "35-39", "40-44", "45-49", "50-54", "55-59", "60-64", "65-69", "70-74", "75-79", "80+")

pp <- ddply(p[p$area == 'WORLD', c('year', 'age', 'sex', 'population')], .(year, age), summarize, sex = sex, population = population, ratio = population / sum(population))

ppmale <- pp[pp$sex == 'male',]

ggplot(head(ppmale)) +
  geom_bar(aes(x = 1, y = ratio), stat = "identity") +
  facet_grid(age ~ year) +
  coord_polar(theta = "y") +
  scale_y_continuous(breaks = NULL) +
  scale_x_continuous(name = element_blank(), breaks = NULL)
