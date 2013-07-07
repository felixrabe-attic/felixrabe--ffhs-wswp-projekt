population_total <- ddply(p[p$area == 'WORLD', c('year', 'population')], .(year), colwise(sum))

population_total_plot <- ggplot(population_total, aes(year, population)) + geom_line() + scale_y_continuous(label = f, lim = c(0, 8000000000)) + labs(y = 'Weltbevölkerung', x = 'Jahr')

population_total_table <- population_total[population_total$year >= 1970 & population_total$year < 2010,]

population_total_table_display <- transform(population_total_table, population = f(population))

names(population_total_table_display) <- c('Jahr', 'Bevölkerung')

population_total_xtable <- xtable(population_total_table_display, caption='Tabelle der Bevölkerungszahlen von 1970 bis 2009, die den Berechnungen zugrunde liegen.', label='population_total_table')

population_total_table_mean_year <- 1 / nrow(population_total_table) * sum(population_total_table$year)
aeq(population_total_table_mean_year, mean(population_total_table$year))

population_total_table_mean_population <- 1 / nrow(population_total_table) * sum(population_total_table$population)
aeq(population_total_table_mean_population, mean(population_total_table$population))
