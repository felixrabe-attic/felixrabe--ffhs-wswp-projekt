pp <- p[p$area == 'WORLD', c('year', 'age', 'sex', 'population')]

smaller_guide <- guide_legend(keywidth = 0.8, keyheight = 0.8)

plt <- ggplot(pp, aes(year, color = age))
plt <- plt + geom_line(aes(y = population, linetype = sex))
plt <- plt + scale_color_discrete(limits = ages)
plt <- plt + scale_y_continuous(label = f)
plt <- plt + labs(x = 'Jahr', y = 'Bevölkerung in der Gruppe', linetype = 'Geschlecht', color = 'Altersgruppe')
plt <- plt + guides(linetype = smaller_guide, color = smaller_guide)
plt <- plt + scale_linetype_discrete(labels = c('weiblich', 'männlich'))
plt -> population_by_age_plot
