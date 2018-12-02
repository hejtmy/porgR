library(openxlsx)
library(purrr)
library(dplyr)
library(ggplot2)
data_path <- "studnets-projects/age-verbal-memory/data.xlsx"
participatns <- read.xlsx(data_path, sheet=1) 
# needs to clear anything beyodnd 4th column
ls <- map(1:5, function(x) read.xlsx(data_path, sheet=x))

parcitipants <- ls[[1]]
colnames(participatns) <- c('id', 'vek', 'pohlavi')
trials <- ls[2:5]

clean <- function(df){
  df <- df[df$id!=0,]
  return(df)
}
add_trial <- function(df,x){
  df$trial <- x
  return(df)
}
trials <- map(trials, clean)
trials <- map(1:4, function(x) add_trial(trials[[x]], x))
experiment <- data.frame(matrix(ncol=19, nrow=0))
COLUMN_NAMES <- c('id', as.character(1:15), 'celkem', 'navic', 'trial')
colnames(experiment) <- COLUMN_NAMES
for(trial in trials){
  colnames(trial) <- COLUMN_NAMES
  experiment <- rbind(experiment, trial)
}

sum_correct <- function(x){return(sum(is.na(x)))}
sum_errors <- function(x){return(sum(!is.na(x) & !grepl("0", x)))}
sum_missing <- function(x){return(sum(grepl("0", x)))}

experiment$wordlist <- ifelse(experiment$trial %in% c(1,2,4), "A", "B")
experiment <- merge(experiment, participatns, by = "id")
experiment <- experiment %>% mutate(pohlavi = dplyr::recode(pohlavi,`h`="zena", `k`="muz"))
#calculates NA values - correct values
experiment$correct <- experiment %>% select(2:16) %>% mutate(correct = apply(., 1, sum_correct)) %>% .$correct
# calculates missed values
experiment$errors <- experiment %>% select(2:16) %>% mutate(errors = apply(., 1, sum_errors)) %>% .$errors
# calculates errors
experiment$missing <- experiment %>% select(2:16) %>% mutate(missing = apply(., 1, sum_missing)) %>% .$missing


### graphs
means <- experiment %>% group_by(trial, pohlavi) %>% summarise(mean=mean(correct), se=sd(correct)/sqrt(n()))
means
ggplot(means, aes(trial, mean, color=pohlavi)) + geom_line() + geom_errorbar(aes(ymin=mean-2*se, ymax=mean+2*se),width=.1, position=position_dodge(0.1))

means <- experiment %>% group_by(pohlavi) %>% summarise(mean=mean(correct), se=sd(correct)/sqrt(n()))
means
ggplot(means, aes(pohlavi, mean, fill=pohlavi)) + geom_bar(stat='identity')+ geom_errorbar(aes(ymin=mean-2*se, ymax=mean+2*se),width=.1)

### analysis