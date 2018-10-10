library(ggplot2)
normal <-  c(3,3,4,5,6,7,7)
normal_shifted <- c(5,5,6,7,8,9,9)
extremes <- c(0,0,2,5,8,10,10)
bias_extremes <- c(0,0,4,5,6,7,7)
missing <- c(3,NA,4,5,NA, 7, NA)

types <- c(rep("normal", 7), rep("normal_shifted", 7), rep("extremes", 7), rep("bias_extremes", 7), rep("missing", 7))

values <- c(normal, normal_shifted, extremes, bias_extremes, missing)
mean(values, na.rm = T)

df <- data.frame(value=values, type=types)
ggplot(df, aes(type, value, fill=type)) + stat_summary(fun.y="mean", geom="bar", fun.args = list("na.rm"=T)) + 
  stat_summary(geom = "errorbar", fun.data = mean_se, position = "dodge", width=0.2) + 
  guides(fill=FALSE)
  
sample_data <- function(data, N){
  selected <- c()
  for(i in 0:4){
    selected <- c(selected, sample(1:7, N) + 7*i)
  }
  sampled_data <- data[selected,]
  print(selected)
  print(mean(sampled_data$values, na.rm = T))
  ggplot(sampled_data, aes(type, value, fill=type)) + stat_summary(fun.y="mean", geom="bar") + 
    stat_summary(geom = "errorbar", fun.data = mean_se, position = "dodge", width=0.2) + 
    guides(fill=FALSE)
}

sample_data(df, 5)
