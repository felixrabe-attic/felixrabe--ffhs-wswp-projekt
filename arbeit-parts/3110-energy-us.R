e_us <- e[e$area == 'United States of America',]

p_us <- ddply(p[p$area == 'United States of America', c('year', 'population')], .(year), colwise(sum))

subs <- function(df) {
  subset(df, select = c(year, type, value))
}

pc_us <- rbind(
  subs(transform(e_us, type = 'mtoe', value = consumption)),
  subs(transform(p_us, type = 'pop',  value = population)),
  subs(transform(merge(e_us, p_us), type = 'toepc', value = consumption * 1000000 / population))
)

pp <- ggplot(pc_us, aes(year, value, color = type))
pp <- pp + scale_y_continuous(lim = c(0, 4000))
pp <- pp + labs(x = 'Jahr', y = 'Verbrauch in Mio. t Öläquivalenten')
pp -> pc_us_plot
