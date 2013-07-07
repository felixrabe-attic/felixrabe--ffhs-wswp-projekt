# name,rank,count,prop100k,cum_prop100k,pctwhite,pctblack,pctapi,pctaian,pct2prace,pcthispanic

ntab_display <- transform(subset(usnames, select = c(name, rank, count)), count = f(count))
names(ntab_display) <- c('Name', 'Rang', 'Anzahl')
names_top_table <- xtable(head(ntab_display), caption='Top 10 US-Namen im Jahr 2000.', label='names_top_table')
