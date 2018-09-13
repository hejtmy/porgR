library(googlesheets)
library(dplyr)
library(reshape2)
library(ggplot2)

FORRER_KEY <- ""

sheet <- gs_key(FORRER_KEY)
df <- gs_read(sheet, ws=1)
questions<- melt(df[,2:13])
feedback <- melt(df[,14:15])
summary_sums <- questions %>% group_by(variable) %>% summarize(count=sum(value))

ggplot(summary_sums, aes(variable, count, fill=variable)) + geom_histogram(stat="identity") +
  geom_hline(yintercept=nrow(df)) + geom_hline(yintercept=nrow(df)/2) + guides(fill=F)

ggplot(feedback, aes(value, fill=variable)) + geom_density(alpha=0.5) + 
  geom_vline(xintercept = 2.5)

# Significantly descriptive
t.test(df$descriptive, mu=2.5)

# Not significantly useful
t.test(df$useful, mu=2.5)