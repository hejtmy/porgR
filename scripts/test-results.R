library(ggplot2)
results <- read.csv("Data/example-exam.csv")
gplot<- ggplot(results[results$Total > 0,])
gplot + geom_histogram(aes(Total), bins = 30)
gplot + geom_density(aes(Mark)) + geom_vline(xintercept =  mean(results$Mark, na.rm = T))

