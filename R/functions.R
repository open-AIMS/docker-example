read_my_data <- function (filename, ...) {
  read.csv(filename, header = TRUE, stringsAsFactors = FALSE, ...)
}

make_my_plot <- function (data) {
  ggplot(data) +
    geom_point(aes(x = x, y = y))
}
