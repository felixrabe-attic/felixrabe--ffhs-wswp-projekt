# pp <- ddply(p[p$area == 'WORLD', c('year', 'age', 'population')], c('year', 'age'), colwise(sum))

pp <- ddply(p[p$area == 'WORLD', c('year', 'age', 'sex', 'population')], .(year, age), summarize, sex = sex, population = population, ratio = population / sum(population))

# ppmale <- pp[pp$sex == 'male',]

# qplot(year, age, data=ppmale, alpha = I(1/2), color = ratio, size = population) + scale_y_discrete(limits = ages) + scale_size_continuous(label = f) + labs(x = 'Jahr', y = 'Altersgruppe', size = 'Bevölkerung', color = 'Anteil männlich') + scale_color_continuous(label = percent)

smaller_guide <- guide_legend(keywidth = 0.8, keyheight = 0.8)

population_by_age_plot <- ggplot(pp, aes(year, color = age)) + geom_line(aes(y = population, linetype = sex)) + scale_color_discrete(limits = ages) + scale_y_continuous(label = f) + labs(x = 'Jahr', y = 'Bevölkerung in der Gruppe', linetype = 'Geschlecht', color = 'Altersgruppe') + guides(linetype = smaller_guide, color = smaller_guide) + scale_linetype_discrete(labels = c('weiblich', 'männlich'))
