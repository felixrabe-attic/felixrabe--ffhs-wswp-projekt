e_us <- e[e$area == 'United States of America',]

p_us <- ddply(p[p$area == 'United States of America', c('year', 'population')], .(year), colwise(sum))

pc_us <- transform(merge(e_us, p_us), per_capita = consumption / population * 1000000)

pp <- ggplot(pc_us, aes(year))
pp <- pp + geom_line(aes(y = consumption))
pp <- pp + geom_line(aes(y = per_capita * 1000))

pp -> pc_us_plot
