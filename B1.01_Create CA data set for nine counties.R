# Creating CA counties' data set for nine regions
library(readxl)
library(tidyverse)

# Read the data from Excel
data <- read_excel("CACountyRegion_dta.xlsx")

# Reshape the data
df <-  data %>%
  mutate(Counties = strsplit(as.character(Counties), ", ")) %>%
  unnest(Counties)

# Optionally, write the data to a new CSV file
write_csv(df, "Counties and Regions.csv")
