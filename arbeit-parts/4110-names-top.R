# name,rank,count,prop100k,cum_prop100k,pctwhite,pctblack,pctapi,pctaian,pct2prace,pcthispanic

ntab <- subset(usnames, select = c(rank, name, count))
ntab_head <- head(ntab, n = 10)
ntab_display <- transform(ntab_head, count = f(count))
names(ntab_display) <- c('Rang', 'Name', 'Anzahl')
names_top_table <- xtable(ntab_display, caption='Top 10 US-Namen im Jahr 2000.', label='names_top_table', align='lrlr')

# http://www.slideshare.net/jeffreybreen/grouping-summarizing-data-in-r

np <- ggplot(ntab_head, aes(name, count))
np <- np + geom_histogram(aes(width = 1), stat = 'identity', position = 'identity', color = 'black', fill = NA)
np <- np + labs(x = 'Nachname', y = 'Vorkommnisse')
np <- np + theme(axis.text.x = element_text(angle=90, vjust=1))
np <- np + scale_y_continuous(label = f)
np -> names_top_plot

first_letter <- function(x) { substr(x, 0, 1) }

width_to_x <- function(w) { cumsum(c(0, w[-length(w)]) / 2 + w / 2) }

prepare_plot <- function(data) {
  data <- transform(data, name = first_letter(name))
  d2 <- summaryBy(count ~ name, data = data, FUN = function(x) { c(width = length(x), height = sum(x) / length(x)) })
  d3 <- data.frame(d2, x = width_to_x(d2$count.width))

  np <- ggplot(d3, aes(x))
  np <- np + geom_histogram(aes(y = count.height, width = count.width), stat = 'identity', position = 'identity', color = 'black', fill = NA)
  np <- np + labs(x = 'Anfangsbuchstabe des Nachnamens', y = 'Klassendichte')
  np <- np + theme(panel.grid.minor = element_blank())
  np <- np + scale_x_continuous(breaks = d3$x, labels = d3$name)
  np <- np + scale_y_continuous(label = f)
  np
}

prepare_plot(ntab_head) -> names_top_by_letter_plot

prepare_plot(ntab) -> names_by_letter_plot
