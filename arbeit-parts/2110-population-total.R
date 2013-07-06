ppsum <- ddply(p[p$area == 'WORLD', c('year', 'population')], .(year), colwise(sum))

ppsum_linear <- data.frame(year = ppsum$year, population = seq(2525778669, 6916183482, length.out = 61))

ppsum <- rbind(data.frame(ppsum, type='raw'), data.frame(ppsum_linear, type='linear'))

# ppsum <- merge(ppsum, ppsum_linear)
