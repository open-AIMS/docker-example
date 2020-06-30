library(ggplot2)
source("R/functions.R")

data <- read_my_data("data/data.csv")
dir.create("output")
my_plot <- make_my_plot(data)
ggsave("output/myplot.pdf", my_plot)
