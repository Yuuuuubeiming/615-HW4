
library(data.table)
file_root <- "https://www.ndbc.noaa.gov/view_text_file.php?filename=44013h"
tail <- ".txt.gz&dir=data/historical/stdmet/"
all_years_data <- list()
for (year in 1985:2023) {
  path <- paste0(file_root, year, tail)
  print(paste("Downloading and reading data for year:", year))
  try({
    header <- scan(path, what = 'character', nlines = 1, quiet = TRUE)
    buoy <- fread(path, header = FALSE, skip = 2)
    colnames(buoy) <- header
    buoy[, Year := year]
    all_years_data[[as.character(year)]] <- buoy
  }, silent = TRUE)
}
combined_data <- rbindlist(all_years_data, use.names = TRUE, fill = TRUE)
head(combined_data)

