

## ---- eval = FALSE-------------------------------------------------------
## if (!require(curl)) install.packages("curl")
## curl::curl_download(
##   "https://raw.githubusercontent.com/heike/greenlee/master/basics.R",
##   "basics.R"
## )
## file.edit("basics.R")


## ------------------------------------------------------------------------
# Addition and Subtraction
2 + 5 - 1

# Multiplication
109*23452

# Division
3/7


## ------------------------------------------------------------------------
# Integer division
7 %/% 2

# Modulo operator (Remainder)
7 %% 2

# Powers
1.5^3


## ------------------------------------------------------------------------
x <- 5
y <- 21


## ------------------------------------------------------------------------
log(x)
y^2


## ------------------------------------------------------------------------
y <- c(1, 5, 3, 2)


## ------------------------------------------------------------------------
y / 2


## ---- eval=FALSE---------------------------------------------------------
## help(head)


## ---- eval=FALSE---------------------------------------------------------
## ?head


## ------------------------------------------------------------------------
str(schools)


## ------------------------------------------------------------------------
head(iris, n = 2)


## ------------------------------------------------------------------------
str(iris)


## ---- echo=FALSE, cache=TRUE, message = FALSE, out.height = 450----------
library("dlstats")

dframe <- cran_stats("ggplot2")
ggplot(data = dframe[-nrow(dframe),], aes(x = end, y = downloads/1000)) + 
  geom_point(size = 3) + geom_smooth(se=FALSE) +
  ylab("Number of monthly downloads (in 1000s)") + xlab("Date") +
  ggtitle("Number of monthly downloads of ggplot2") +
  theme_bw()


## ---- out.height = 400---------------------------------------------------
ggplot(data = mtcars, aes(x = wt, y = mpg)) +
  geom_point()


## ---- out.height = 400, message = FALSE----------------------------------
ggplot(data = mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  geom_smooth()


## ---- out.height = 400, message = FALSE----------------------------------
mtcars$name = row.names(mtcars)
ggplot(data = mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  geom_smooth() +
  geom_text(aes(label = name), size = 3)


## ------------------------------------------------------------------------
ggplot(data = mtcars, aes(x = wt, y = mpg, colour = factor(cyl))) +
  geom_point()

