## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, dpi= 300, fig.width = 3, fig.height = 3)
options(width=60)
library(tidyverse)


## ------------------------------------------------------------------------
pkgs <- available.packages(repos='http://cran.us.r-project.org')
nrow(pkgs)


## ----eval=FALSE----------------------------------------------------------
##  *italic*
##  **bold**
## 
##  # Header 1
##  ## Header 2
##  ### Header 3
## 
##  - List item 1
##  - List item 2
##     - item 2a
##     - item 2b
## 
##  1. Numbered list item 1
##  2. Numbered list item 2
##     - item 2a
##     - item 2b


## ------------------------------------------------------------------------
schools <- read.csv("../data/iowa-modified.csv")
dim(schools)
head(schools)


## ---- echo=FALSE, warning=FALSE, message=FALSE, fig.width = 10, fig.height = 6----
library(tidyverse)
schools %>% 
  filter(dname %in% c("Ames")) %>%
  ggplot(aes(x = School.Year, y = Perc.Proficient, colour = Topic, shape = Topic)) + 
  geom_point(size = 3) +
  facet_wrap(~Grade, labeller="label_both", ncol=4) +
  theme_bw() +
  theme(legend.position="bottom") +
  ggtitle("Trends of Proficiency Levels in the Ames School District") +
  xlab("School Year") +
  ylab("Percent Proficiency") +
  geom_smooth(method = "lm", se=FALSE)
  


## ---- echo=FALSE, warning=FALSE, message=FALSE, fig.width = 10, fig.height = 6----
schools <- schools %>% mutate(
  classof = School.Year + 12-Grade
)
schools %>%  
  filter(dname %in% c("Ames")) %>%
  ggplot(aes(x = Grade, y = Perc.Proficient, colour = factor(classof))) + 
  geom_point(size = 3) +
  geom_line() +
  facet_wrap(~Topic, labeller="label_both", ncol=4) +
  theme_bw() +
  theme(legend.position="none") +
  scale_x_continuous(breaks = unique(schools$Grade), 
                     labels = unique(schools$Grade)) +
  geom_text(aes(x = Grade + .5, label = classof), 
            data = filter(schools, dname %in% c("Ames"), Grade == 11)) +
  geom_text(aes(x = Grade - .5, label = classof), 
            data = filter(schools, dname %in% c("Ames"), Grade == 3)) +
  ggtitle("Proficiency Levels in the Ames School District by Class") +
  ylab("Percent Proficiency") 


## ---- echo=FALSE, message=FALSE, warning = FALSE, fig.width=10, fig.height = 5----
districts <- read_csv("../data/boundaries-2018.csv.zip")
districts %>% 
  ggplot(aes(x = long, y = lat, group = group)) +
  geom_path() +
  theme_bw() +
  geom_polygon(data = filter(districts, SchoolDist == "AMES"), fill="steelblue") 


## ---- echo=FALSE, warning=FALSE, message=FALSE, fig.width = 10, fig.height = 6----
schools %>% 
  filter(School.Year==2017) %>%
  ggplot(aes(x = Perc.Proficient, fill=Topic, colour = Topic)) +
  geom_density(alpha = 0.5) +
  geom_vline(aes(xintercept = Perc.Proficient, colour = Topic), 
             data = filter(schools, dname %in% c("Ames"), School.Year==2017)) +
  facet_wrap(~Grade, ncol=4, labeller = "label_both") +
  theme_bw() +
  theme(legend.position="bottom") +
  xlab("Percent Proficiency") +
  ggtitle("Densities of Proficiency in Iowa School Districts")


## ------------------------------------------------------------------------
schools %>% 
  filter(School.Year == 2017) %>%
  filter(Perc.Proficient == 0) %>%
  select(dname, Proficient, Total, Grade)


## ---- echo=FALSE, warning=FALSE, message=FALSE, fig.width = 10, fig.height = 6----
schools %>% 
  filter(School.Year==2017, Total > 0) %>%
  ggplot(aes(x = Perc.Proficient, fill=Topic, colour = Topic)) +
  geom_density(alpha = 0.5) +
  geom_vline(aes(xintercept = Perc.Proficient, colour = Topic), 
             data = filter(schools, dname %in% c("Ames"), School.Year==2017)) +
  facet_wrap(~Grade, ncol=4, labeller = "label_both") +
  theme_bw() +
  theme(legend.position="bottom") +
  xlab("Percent Proficiency") +
  ggtitle("Densities of Proficiency in Iowa School Districts")


## ---- echo=FALSE, warning=FALSE, message=FALSE, fig.width = 10, fig.height = 6----
schools %>%
  filter(Grade == 3) %>%
  ggplot(aes(x = factor(School.Year), fill = Topic)) + 
  geom_bar(position="dodge") +
  theme_bw() + 
  xlab("School Year") +
  ggtitle("Number of Grade 3 assessments")


## ------------------------------------------------------------------------
schools %>% 
  filter(School.Year == 2015, Grade == 3, dname == "Ames")


## ------------------------------------------------------------------------
schools <- unique(schools)


## ---- echo=FALSE, warning=FALSE, message=FALSE, fig.width = 10, fig.height = 6----
schools %>%
  filter(Grade == 3) %>%
  ggplot(aes(x = factor(School.Year), fill = Topic)) + 
  geom_bar(position="dodge") +
  theme_bw() + 
  xlab("School Year") +
  ggtitle("Number of Grade 3 assessments")


## ---- echo=FALSE, warning=FALSE, message=FALSE, fig.width = 10, fig.height = 6----
schools %>%
  filter(Topic == "Math") %>%
  ggplot(aes(x = factor(School.Year), weight = Total, fill=factor(Grade))) + 
  geom_bar() +
  facet_wrap(~Grade, labeller="label_both") +
  theme_bw() + 
  xlab("School Year") +
  ggtitle("Number of students in Iowa") +
  scale_fill_brewer("Grade", palette = "Paired")


## ---- echo=FALSE, warning=FALSE, message=FALSE, fig.width = 10, fig.height = 6----
schools %>% 
  filter(dname %in% c("IKM", "IKM-Manning", "Manning")) %>%
  filter(Topic == "Math") %>%
  ggplot(aes(x = factor(School.Year), y = Total)) + 
  geom_point(aes(colour = District.Name, shape = District.Name), size = 3) +
  facet_wrap(~Topic+Grade, labeller="label_both", ncol = 4) +
  theme_bw() +
  theme(legend.position="bottom") +
  xlab("School Year")
  


## ---- eval = FALSE-------------------------------------------------------
## if (!require(curl)) install.packages("curl")
## curl::curl_download(
##   "https://raw.githubusercontent.com/heike/greenlee/master/01-Introduction-to-R/code/2-basics.R",
##   "2-basics.R"
## )
## file.edit("2-basics.R")


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

