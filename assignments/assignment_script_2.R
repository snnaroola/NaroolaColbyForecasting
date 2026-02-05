# assignment/assignment_script_2.R


source("setup.R")

library(dplyr)
library(sf)

# read model input data

model_input = read_model_input(scientificname = "Amblyraja radiata", version = "v2") |>
  mutate(
    month = factor(month, levels = month.abb),
    class = factor(class, levels = c("presence", "background"))
  )

# for each month, sample 1 presence + 1 background 24 total
sampled_pts = model_input |>
  group_by(month, class) |>
  slice_sample(n = 1) |>
  ungroup() |>
  arrange(month, class) |>
  group_by(month) |>
  mutate(point = paste0("p", row_number())) |>
  ungroup()


# load brickman present monthly covs and extract at the sampled points

db = brickman_database() |>
  filter(scenario == "PRESENT", interval == "mon")

covars = read_brickman(db)

x = extract_brickman(covars, sampled_pts, form = "wide")

names(x)
# keep  3 vars.
vars_to_keep = c("depth", "SSS", "month")

final_tbl = x |>
  select(month, class, geom, point, all_of(vars_to_keep))

# print
final_tbl
