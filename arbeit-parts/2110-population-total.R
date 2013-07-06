population_total <- ddply(p[p$area == 'WORLD', c('year', 'population')], .(year), colwise(sum))

population_total_plot <- ggplot(population_total, aes(year, population)) + geom_line() + geom_smooth(method = 'lm') + scale_y_continuous(label = f, lim = c(0, 8000000000)) + labs(y = 'Weltbevölkerung', x = 'Jahr')
