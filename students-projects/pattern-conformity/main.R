library(openxlsx)
library(purrr)
library(dplyr)
library(reshape2)
library(ggplot2)
data_path <- "students-projects/pattern-conformity/data.xlsx"
# needs to clear anything beyodnd 4th column
ls <- map(1:4, function(x) read.xlsx(data_path, sheet=x))

df <- cbind(ls[[1]], ls[[2]][,-1])
correct <- df$Correct
df$trial <- c(1:36)
df_long <- melt(df, id.vars = c("trial", "Correct"))
df_long$Correct <- df_long$Correct == df_long$value
df_long <- df_long %>% rename(id=variable)

questionnaire <- rbind(ls[[3]], ls[[4]])
colnames(questionnaire) <- c("id", "skupina", "noticed.pattern", "didnt.know.some.answers", "guess.pattern", "change.to.pattern")

df <- df_long %>% left_join(questionnaire, by="id")

## adds consecutive values
df$consecutive <- sequence(rle(as.character(df$value))$lengths)
df$consecutive[df$consecutive > 3] <- NA
df$test <- TRUE
df$test <- df$trial > 23


df_total_triads <- df %>% group_by(id, test) %>% summarize(n_patterns = sum(consecutive == 3, na.rm=T))
df <- df %>% left_join(df_total_triads, by=c('id', 'test'))

df_first <- df %>% group_by(id, test) %>% slice(1) # selects only the first one  to properly calculate t-tests

df_output <- df %>% select(id, skupina, noticed.pattern, didnt.know.some.answers, guess.pattern, change.to.pattern, n_patterns, test) %>% distinct()
write.csv(df_output, "output.csv", sep=",", row.names = F)
