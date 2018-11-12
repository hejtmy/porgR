library(ggplot2)
library(plyr)
library(psych)
#reads in hte table
tgtw_table <- read.csv("Data/tongue-twisters.csv")
hist_plot = ggplot(tgtw_table) + geom_histogram(aes(Time))
hist_plot + facet_wrap(~Student)
hist_plot + geom_histogram(aes(Time),bins=30)
hist_plot + geom_histogram(aes(Time),bins=20)
hist_plot + geom_histogram(aes(Time),bins=10)
hist_plot + geom_histogram(aes(Time),bins=5)
hist_plot

hist_plot_non_trial = ggplot(subset(tgtw_table, (Trial==0))) + geom_histogram(aes(Time))
hist_plot_non_trial + geom_histogram(aes(Time),bins=10)

describe(tgtw_table$Time)
describeBy(tgtw_table$Time,tgtw_table$Student)


#TWO SAMPLE T-TEST - TESTING

twosamplettest <- function(table=tgtw_table,tested_students = c("Josefina","Andrea")){
  t_table = subset(tgtw_table, (Student %in% tested_students))
  t=t.test(t_table$Time ~ t_table$Student)
  hist = ggplot(t_table) + geom_histogram(aes(Time, fill=Student),bins=20)+geom_vline(xintercept = t$estimate[1])+geom_vline(xintercept = t$estimate[2])
  print(hist)
  print(t)
}

twosamplettest(tgtw_table, c("Veronika","Andrea"))

#ONE SAMPLE T TEST - TESTING

onesamplettest <- function(table=tgtw_table,tested_value=10,tested_student = "Joesefina"){
  t_table = subset(tgtw_table, (Student %in% c(tested_student)))

  t=t.test(t_table$Time, mu=tested_value)
  hist = ggplot(t_table) + geom_histogram(aes(Time),bins=20)+geom_vline(xintercept = t$estimate[1])+geom_vline(xintercept = tested_value,colour="red")
  print(hist)
  print(t)
}

onesamplettest(tgtw_table,5,"Andrea")
