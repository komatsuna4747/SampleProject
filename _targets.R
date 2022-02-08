library(targets)

create_plot <- function(data) {
  ggplot(data) +
    geom_histogram(aes(x = Ozone)) +
    theme_gray(24)
}

targets::tar_option_set(
  packages = c("magrittr", "ggplot2")
)

list(
  targets::tar_target(
    raw_data_file,
    "data/raw_data.csv",
    format = "file"
  ),
  targets::tar_target(
    raw_data,
    readr::read_csv(raw_data_file)
  ),
  targets::tar_target(
    data,
    raw_data %>%
      dplyr::filter(!is.na(Ozone))
  ),
  targets::tar_target(
    hist,
    create_plot(data)
  )
)
