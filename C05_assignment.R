
source("setup.R")
db <- brickman_database()
make_path("predictions")

SPECIES1 <- "Amblyraja radiata"
VERSION1 <- "v2"
MODEL1   <- "Amblyraja_Radiata-v2-model_fits"

cfg1 <- read_configuration(scientificname = SPECIES1, version = VERSION1)
model_fits1 <- read_model_fits(filename = MODEL1)

cov_current_1 <- read_brickman(
  db |> dplyr::filter(scenario == "PRESENT", interval == "mon"),
  add = c("depth", "month")
) |> dplyr::select(all_of(cfg1$keep_vars))

cov_2055_rcp45_1 <- read_brickman(
  db |> dplyr::filter(scenario == "RCP45", year == 2055, interval == "mon"),
  add = c("depth", "month")
) |> dplyr::select(all_of(cfg1$keep_vars))

cov_2055_rcp85_1 <- read_brickman(
  db |> dplyr::filter(scenario == "RCP85", year == 2055, interval == "mon"),
  add = c("depth", "month")
) |> dplyr::select(all_of(cfg1$keep_vars))

cov_2075_rcp45_1 <- read_brickman(
  db |> dplyr::filter(scenario == "RCP45", year == 2075, interval == "mon"),
  add = c("depth", "month")
) |> dplyr::select(all_of(cfg1$keep_vars))

cov_2075_rcp85_1 <- read_brickman(
  db |> dplyr::filter(scenario == "RCP85", year == 2075, interval == "mon"),
  add = c("depth", "month")
) |> dplyr::select(all_of(cfg1$keep_vars))

pred_current_1    <- predict_stars(model_fits1, cov_current_1)
pred_2055_rcp45_1 <- predict_stars(model_fits1, cov_2055_rcp45_1)
pred_2055_rcp85_1 <- predict_stars(model_fits1, cov_2055_rcp85_1)
pred_2075_rcp45_1 <- predict_stars(model_fits1, cov_2075_rcp45_1)
pred_2075_rcp85_1 <- predict_stars(model_fits1, cov_2075_rcp85_1)

write_prediction(pred_current_1,    scientificname = SPECIES1, version = VERSION1, year = "CURRENT", scenario = "CURRENT")
write_prediction(pred_2055_rcp45_1, scientificname = SPECIES1, version = VERSION1, year = "2055",   scenario = "RCP45")
write_prediction(pred_2055_rcp85_1, scientificname = SPECIES1, version = VERSION1, year = "2055",   scenario = "RCP85")
write_prediction(pred_2075_rcp45_1, scientificname = SPECIES1, version = VERSION1, year = "2075",   scenario = "RCP45")
write_prediction(pred_2075_rcp85_1, scientificname = SPECIES1, version = VERSION1, year = "2075",   scenario = "RCP85")




SPECIES2 <- "Malacoraja senta"
VERSION2 <- "v1"
MODEL2   <- "Malacoraja_senta-v1-model_fits"

cfg2 <- read_configuration(scientificname = SPECIES2, version = VERSION2)
model_fits2 <- read_model_fit(filename = MODEL2)


cov_current_2 <- read_brickman(
  db |> dplyr::filter(scenario == "PRESENT", interval == "mon"),
  add = c("depth", "month")
) |> dplyr::select(all_of(cfg2$keep_vars))

cov_2055_rcp45_2 <- read_brickman(
  db |> dplyr::filter(scenario == "RCP45", year == 2055, interval == "mon"),
  add = c("depth", "month")
) |> dplyr::select(all_of(cfg2$keep_vars))

cov_2055_rcp85_2 <- read_brickman(
  db |> dplyr::filter(scenario == "RCP85", year == 2055, interval == "mon"),
  add = c("depth", "month")
) |> dplyr::select(all_of(cfg2$keep_vars))

cov_2075_rcp45_2 <- read_brickman(
  db |> dplyr::filter(scenario == "RCP45", year == 2075, interval == "mon"),
  add = c("depth", "month")
) |> dplyr::select(all_of(cfg2$keep_vars))

cov_2075_rcp85_2 <- read_brickman(
  db |> dplyr::filter(scenario == "RCP85", year == 2075, interval == "mon"),
  add = c("depth", "month")
) |> dplyr::select(all_of(cfg2$keep_vars))


pred_current_2    <- predict_stars(model_fits2, cov_current_2)
pred_2055_rcp45_2 <- predict_stars(model_fits2, cov_2055_rcp45_2)
pred_2055_rcp85_2 <- predict_stars(model_fits2, cov_2055_rcp85_2)
pred_2075_rcp45_2 <- predict_stars(model_fits2, cov_2075_rcp45_2)
pred_2075_rcp85_2 <- predict_stars(model_fits2, cov_2075_rcp85_2)

write_prediction(pred_current_2,    scientificname = SPECIES2, version = VERSION2, year = "CURRENT", scenario = "CURRENT")
write_prediction(pred_2055_rcp45_2, scientificname = SPECIES2, version = VERSION2, year = "2055",   scenario = "RCP45")
write_prediction(pred_2055_rcp85_2, scientificname = SPECIES2, version = VERSION2, year = "2055",   scenario = "RCP85")
write_prediction(pred_2075_rcp45_2, scientificname = SPECIES2, version = VERSION2, year = "2075",   scenario = "RCP45")
write_prediction(pred_2075_rcp85_2, scientificname = SPECIES2, version = VERSION2, year = "2075",   scenario = "RCP85")

