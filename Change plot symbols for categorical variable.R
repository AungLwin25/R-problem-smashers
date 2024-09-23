# Demonstrating how to customize plot()
 # transforming scattered symbols for categorical data

# Background: plot() can be customized easily if both variables are numeric
 # becoming a challenge
 # -> when we want to plot the categorical variable's values

# Load data
source("df_CountyN.R")
 # Put "US State by number of counties.csv" in your local directory.
 # -> Amend the destination address in the source .R file.

# Extract variable labels
library(labelled)
lab1 <- var_label(CountyN$State)
lab2 <- var_label(CountyN$Freq)
 # We would like to show the complete labels instead of variable names.

var_label(CountyN)
# $State
# [1] "US State"

# $Freq
# [1] "Number of Counties"

# Default plot behavior with categorical data
plot(CountyN[[1]], CountyN[[2]],
     xlab = lab1,
     ylab = lab2,
     las = 2,  # Rotate x-axis labels for better readability of 51 states
     cex.axis = 0.7)  # Adjust the size of axis labels

# The above plot results in "scattered bars" because 'State' is categorical.
# Let's try changing the plot type to 'p' (points) to see
   -> if it we can make a difference

plot(CountyN[[1]], CountyN[[2]],
     xlab = lab1,
     ylab = lab2,
     las = 2,
     cex.axis = 0.7,
     pch = 19,  # Use solid circles as points
     type = "p")  # Set plot type to points

# As we see the output, the default behavior persists,
   # -> we still get scattered bars.
# This is because plot() handles categorical data differently.

# Let's correct this and achieve the desired scattered points
# Create an empty plot with axes and labels, but no x-axis ticks or labels initially
plot(1, type="n",  # '1' is a dummy value to initialize the plot area
     xlab = lab1,
     ylab = lab2,
     xlim = c(1, length(CountyN$State)),  # Set x-axis limits based on the number of states
     ylim = c(0, max(CountyN$Freq)),  # Set y-axis limits based on the maximum frequency
     xaxt = "n")  # Suppress automatic x-axis ticks and labels

# Add circular points at the desired coordinates using symbols()
symbols(1:length(CountyN$State), CountyN$Freq,
        circles = rep(0.2, nrow(CountyN)),  # Set the size of the circles
        inches = FALSE,  # Use data units for circle size, not inches
        bg = "blue", fg = NULL, add = TRUE)  # Blue filled circles with no border

# Add state names as x-axis labels at their correct positions
axis(1, at = 1:length(CountyN$State),
     labels = CountyN$State,
     las = 2,  # Rotate labels vertically
     cex.axis = 0.7)  # Adjust label size
# We are done!

# Notes:
  # "1" in symbols(1: ...) is just a dummy vector
  # -> to initiate an empty plot.
  # "1" in axis(1,...) refers to x-axis.
