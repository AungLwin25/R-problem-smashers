# ArcGIS and R integration

# Import the feature layer's data to R
# The data set is obtained by
 # running ArcGIS Pro
 # Portal => ArcGIS Online => US Counties <Generealized Boundaries 2019)

# Data set of ArcGIS online is of feature class
# Save to local destination as shape file
 # Analysis -> tools -> geoprocessing
 # Convert -> Feature class to shapefile

# Import data to R
library(sf)
shp <- "USA_Counties_Generalized_2019.shp"
Counties19 <- st_read(shp)

# Solve restriction of attributes' names => limited to 10 characters
# Copy the fields table of the source ArcGIS page into Excel
 # Remove redundant pattern "Counties" in variable names
library(readxl)
read_xlsx("VarNames.xlsx", col_names=FALSE) -> vars
data.frame(vars) -> vars2
varnames <- as.character(vars2[,1])
gsub("Counties.*","",varnames) -> varnames2
gsub("L0USA_","", varnames2) -> varnames3
varnames3[1] <- "State"
varnames3[3] <- "County"

# Assign the new column names to the data frame
colnames(Counties19) <- varnames3

# Identify the geometry type
str(Counties19)
 # Classes ‘sf’ and 'data.frame' means spatial data frame in R
 # Check attr(*, "class") -> "MULTIPOLYGON"
 # sfg = simple feature geometry

library(dplyr)
glimpse(Counties19)
# Check FIPS_JoinFIPS_JOINDOUBLE -> "MULTIPOLYGON"

# Extract the attribute data into a data frame
C1 <- Counties19 %>%
  st_drop_geometry()
 #If we don't drop gemoetry, the data will be not normalized.

# Write the attribute data frame to CSV
write.csv(C1, "Counties19.csv", row.names = FALSE)

# Summarize
summary(C1)

# Check duplicates
sum(duplicated(C1$FIPS))
 #0 -> no duplicate

sum(duplicated(C1$County))
 #[1] 1265

# Filter duplicated counties
C1 %>% filter(duplicated(County)) %>%
         select (FIPS,State,County) %>%
         arrange(County, State, FIPS) -> USCountyDup

write.csv(USCountyDup, "US Counties with Duplicated Names.csv")

table(C1$State) -> tb
data.frame(tb) -> df
names(df) <- c("State", "Freq")
write.csv(df, "US State by number of counties.csv",
               row.names = FALSE)

# label variables
library(labelled)
CountyN <- df %>%
  set_variable_labels(State = "US State",
                      Freq = "Number of Counties")

var_label(CountyN)

# Plot number of counties in the states
dev.new()

lab1 <- var_label(CountyN$State)
lab2 <- var_label(CountyN$Frequency)

# Create the plot
plot(CountyN,
     las = 2,  # Rotate x-axis labels
     cex.axis = 0.7,  # Adjust the size of axis labels
     pch = 19,  # Use solid circle for points
     type = "p",
     xlab = lab1,
     ylab = lab2)

# Add circular points using symbols()
symbols(CountyN$State, CountyN$Frequency, circles = rep(0.2, nrow(CountyN)),  # Adjust circle size as needed
        inches = FALSE,  # Use data units for circle size
        bg = "blue", fg = NULL, add = TRUE)  # Customize colors as desired

# Function for plotting the data that has labels
# Load necessary library
library(labelled)

# Define the custom function
plot_labs <- function(df) {
  lab1 <- var_label(df[[1]])
  lab2 <- var_label(df[[2]])

  # Create the plot using the first two columns
  plot(df[[1]], df[[2]],
       xlab = lab1,
       ylab = lab2)
}

plot_labs(CountyN)


















