# name,rank,count,prop100k,cum_prop100k,pctwhite,pctblack,pctapi,pctaian,pct2prace,pcthispanic

ntab <- subset(usnames, select = c(rank, name, count))
ntab_head <- head(ntab, n = 10)
ntab_display <- transform(ntab_head, count = f(count))
names(ntab_display) <- c('Rang', 'Name', 'Anzahl')
names_top_table <- xtable(ntab_display, caption='Top 10 US-Namen im Jahr 2000.', label='names_top_table', align='lrlr')

np <- ggplot(ntab_head, aes(name, count))
np <- np + geom_bar()
# np <- np + scale_x_discrete(label = function(x) { paste(c(substr(x, 0, 2), '...'), collapse='') })
np <- np + scale_x_discrete(label = function(x) { typeof(x) })
np <- np + labs(x = 'Nachname', y = 'Anzahl')
np -> names_top_plot
