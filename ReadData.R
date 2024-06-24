# Load tidyverse
library(tidyverse)

# Define Path
path_to_files <- "./v2"

# Get a list of all files in the directory
zip_files <- list.files(path = path_to_files, pattern = "\\.zip$",
                    full.names = TRUE)

# Function to read CSVs from a zip file
read_csvs_from_zip <- function(zip_file) {
  # Create temporary directory
  temp_dir <- tempfile()
  dir.create(temp_dir)
  
  # Extract CSVs
  unzip(zip_file, exdir = temp_dir)
  
  # Read CSVs into a list
  csv_files <- list.files(temp_dir, pattern = "\\.csv$", full.names = TRUE, recursive=TRUE)
  csv_data <- read_csv(csv_files[[1]], skip = 6)
  
  # Clean up
  unlink(temp_dir, recursive = TRUE)
  
  return(csv_data)
}

# Read CSVs from all zip files
all_csv_data <- lapply(zip_files, read_csvs_from_zip)

# Dataframe all csv data
data <- map_df(all_csv_data, ~.x)

# Clean memory
rm(all_csv_data)
rm(path_to_files)
rm(read_csvs_from_zip)
rm(zip_files)
