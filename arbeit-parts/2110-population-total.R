pt <- ddply(p[p$area == 'WORLD', c('year', 'population')], .(year), colwise(sum))

pp <- ggplot(pt, aes(year, population))
pp <- pp + geom_line()
pp <- pp + scale_y_continuous(label = f, lim = c(0, 8000000000))
pp <- pp + labs(y = 'Weltbevölkerung', x = 'Jahr')
pp -> population_total_plot


ptab <- pt[pt$year >= 1970 & pt$year < 2010,]
n <- nrow(ptab)

ptab_display <- transform(ptab, population = f(population))
names(ptab_display) <- c('Jahr', 'Bevölkerung')
population_total_xtable <- xtable(ptab_display, caption='Tabelle der Bevölkerungszahlen von 1970 bis 2009, die den Berechnungen zugrunde liegen.', label='population_total_table')


p_mean_year <- 1 / n * sum(ptab$year)
aeq(p_mean_year, mean(ptab$year))
p_mean_year -> population_total_table_mean_year

p_mean_pop <- 1 / n * sum(ptab$population)
aeq(p_mean_pop, mean(ptab$population))
p_mean_pop -> population_total_table_mean_population

p_sd_year <- sqrt(1 / (n - 1) * sum((ptab$year - p_mean_year) ^ 2))
aeq(p_sd_year, sd(ptab$year))
p_sd_year -> population_total_table_sd_year

p_sd_pop <- sqrt(1 / (n - 1) * sum((ptab$population - p_mean_pop) ^ 2))
aeq(p_sd_pop, sd(ptab$population))
p_sd_pop -> population_total_table_sd_population

p_cov <- 1 / (n - 1) * sum((ptab$year - p_mean_year) * (ptab$population - p_mean_pop))
aeq(p_cov, cov(ptab$year, ptab$population))
p_cov -> population_total_table_cov

p_cor <- p_cov / (p_sd_year * p_sd_pop)
aeq(p_cor, cor(ptab$year, ptab$population))
p_cor -> population_total_table_cor


p_reg_b <- p_cov / p_sd_year ^ 2
p_reg_b -> population_total_table_reg_b

p_reg_a <- p_mean_pop - p_reg_b * p_mean_year
p_reg_a -> population_total_table_reg_a


ptab_with_reg <- rbind(
  transform(ptab, type = 'Bevölkerung'),
  transform(ptab, population = p_reg_a + p_reg_b * year, type = 'Regressionsgerade')
)

pp <- ggplot(ptab_with_reg, aes(year, population, color = type))
pp <- pp + geom_line()
pp <- pp + scale_y_continuous(label = f, lim = c(0, 8000000000))
pp <- pp + labs(y = 'Weltbevölkerung', x = 'Jahr', color = 'Typ')
pp -> population_total_table_with_reg_plot
