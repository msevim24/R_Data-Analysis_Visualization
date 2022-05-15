##solution descriptive stats
# 1st gear
table(mtcars$am)

# 2. 1/4 mile time
mean(mtcars$qsec, na.rm = TRUE)
sd(mtcars$qsec)

# 3. consumption
length(mtcars$mpg[mtcars$mpg <= 15]) / nrow(mtcars)

##solution t-test
gapminder_1952<-gapminder[gapminder$year=="1952",]
gapminder_2007<-gapminder[gapminder$year=="2007",]
gapminder_both<-rbind(gapminder_1952, gapminder_2007)

test<-t.test(lifeExp ~ year, data = gapminder_both)
test
##solution correlation
options(scipen = 999)
cor.test(gapminder_cs$lifeExp, gapminder_cs$pop)
reg1 <- lm(lifeExp ~ gdpPercap + pop + continent, data = gapminder_cs)
summary(reg1)
