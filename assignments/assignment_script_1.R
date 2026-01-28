# assignment_script_1.R
# sumira naroola
source("setup.R")

# bouy m01
m01 <- gom_buoys() |> dplyr::filter(id == "M01")

# brickman data
x <- brickman_database() |>
  dplyr::filter(scenario == "RCP45",
                year == 2055,
                interval == "mon") |>
  read_brickman()

# extract wide form vals
sst <- extract_brickman(x, m01, form = "wide")

# order months
sst$month <- factor(
  sst$month,
  levels = c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")
)

# plot
ggplot2::ggplot(sst, ggplot2::aes(x = month, y = SST)) +
  ggplot2::geom_point() +
  ggplot2::labs(
    title = "RCP4.5 2055 SST at buoy M01",
    x = "Month",
    y = "SST (C)"
  )
