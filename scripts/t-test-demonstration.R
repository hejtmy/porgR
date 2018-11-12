library(ggplot2)
library(psych)

movie <- c(43,12,45,25,13,-9,14,-15,20,23,27,40,-30,50,-2)
sitting <- c(-12,40,-30,20,29,38,49,-5,0,29,33,34,29,-6,4)

saw <- c(4,7,4,1,4,1,4,8,5,6,5,6,7,0,1)
didnt <- c(1,0,3,4,2,6,3,8,8,1,2,3,1,2,4)

two <- c(5,4,27,12,0,0,14,16,17,2,3,4,5,14,3)
three <- c(10,12,20,23,10,14,0,0,18,14,12,13,30,10,11)

doStuff(movie,sitting)
doStuff(saw,didnt)
doStuff(two,three)

doStuff <- function(thing, thing2){
  df <- data.frame(value=c(thing, thing2), label=c(rep("data1",length(thing)), rep("data2",length(thing2))))
  print(describe(thing))
  print(describe(thing2))
  print(ggplot(df, aes(value, fill=label)) + 
          stat_function(fun = dnorm, args = list(mean = mean(df$value), sd = sd(df$value))) +        
          geom_histogram(aes(y = ..density..), bins=10) + 
          facet_wrap(~label))
  t.test(thing,thing2)
}


marks1 <- c(5,6,5,4,2,7,6,5,7,4,7,4,5,6,5,4,5,7,5,4,5)
marks2 <- c(6,8,7,8,6,7,6,8,7,5,6,10,8,6,6,5,7,5,6,7,8)
names <- c(rep("Marek",21),rep("Jana",21))
x_name <- "name"
y_name <- "mark"

marks <- data.frame(names,c(marks1,marks2))
names(marks) <- c(x_name,y_name)

describeBy(marks$mark,marks$name)
t.test(marks$mark ~ marks$name)

#other example
marks1 <- c(4, 6, 4, 1, 5, 4, 3, 7, 2)
marks2 <- c(6, 4, 9, 3, 6, 8, 6, 5, 7)
names <- c(rep("Dominika",9),rep("Dan",9))
x_name <- "name"
y_name <- "mark"
marks <- data.frame(names,c(marks1,marks2))
names(marks) <- c(x_name,y_name)
describeBy(marks$mark,marks$name)
t.test(marks$mark ~ marks$name)