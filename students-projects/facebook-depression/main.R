library(ggplot2)
data_path <- "students-projects/facebook-depression/results.csv"
df_data <- read.csv(data_path)

lm_dep_facebook <- glm(Depression_test_score~Facebook, data = df_data)
summary(lm_dep_facebook)
ggplot(df_data, aes(Facebook, Depression_test_score)) + geom_point()

lm_anx_facebook <- glm(Anxiety_test_score~Facebook, data = df_data)
summary(lm_anx_facebook)
ggplot(df_data, aes(Facebook, Anxiety_test_score)) + geom_point()
