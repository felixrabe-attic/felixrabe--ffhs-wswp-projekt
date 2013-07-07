population_total <- ddply(p[p$area == 'WORLD', c('year', 'population')], .(year), colwise(sum))

population_total_plot <- ggplot(population_total, aes(year, population)) + geom_line() + scale_y_continuous(label = f, lim = c(0, 8000000000)) + labs(y = 'Weltbevölkerung', x = 'Jahr')

population_total_table <- population_total[population_total$year >= 1970 & population_total$year < 2010,]

population_total_table$population <- f(population_total_table$population)

names(population_total_table)[1] <- 'Jahr'
names(population_total_table)[2] <- 'Bevölkerung'

population_total_xtable <- xtable(population_total_table, caption='Tabelle der ausgewerteten Beobachtungen, 1970 - 2009', label='population_total_table')
