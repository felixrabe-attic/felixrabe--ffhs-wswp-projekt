prob_omega <- sum(p[p$area == 'WORLD' & p$year == 2000, c('population')])

prob_a_cap_b <- ntab[ntab$name == 'SMITH', c('count')]

prob_b <- sum(p[p$area == 'United States of America' & p$year == 2000, c('population')])
