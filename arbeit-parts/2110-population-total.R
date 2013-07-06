ppsum <- ddply(p[p$area == 'WORLD', c('year', 'population')], .(year), colwise(sum))
