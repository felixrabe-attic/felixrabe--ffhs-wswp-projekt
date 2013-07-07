p_2000 <- sum(p[p$area == "WORLD" & p$year == 2000, c("population")])

p_2010 <- sum(p[p$area == "WORLD" & p$year == 2010, c("population")])

p_2000_to_2010_yearly_growth <- ((p_2010 / p_2000) ^ (1/10) - 1) * 100
