# plot() -> transform scattered shapes

# Load data
source("df_CountyN.R")

# Extract labels (if using the 'labelled' package)
lab1 <- var_label(CountyN$State)
lab2 <- var_label(CountyN$Freq)

# Default behavior for ploting a categorical variable
plot(CountyN[[1]], CountyN[[2]],
     xlab = lab1,
     ylab = lab2,
     las = 2,  # Rotate x-axis labels
     cex.axis = 0.7)  # Adjust the size of axis labels
 # will produce scattered bars as default behavor
 #  <- since x is the categorical variable.

# Demonstrating that default behavior does not change
plot(CountyN[[1]], CountyN[[2]],
     xlab = lab1,
     ylab = lab2,
     las = 2,
     cex.axis = 0.7,
     pch = 19,  # Use solid circle for points
     type = "p")  #  plot type is points

# CORRECTION
# Create an empty plot with axes and labels,
 # but no x-axis ticks or labels
plot(1, type="n", # 1 here is just a dummy value to initatie the empty plot
     xlab=lab1, ylab=lab2,
     xlim=c(1, length(CountyN$State)),
     ylim=c(0, max(CountyN$Freq)),
     xaxt = "n")
 # minimal value: Categorical = 1, Numeric = 0

# Add circular points using symbols()
symbols(CountyN$State, CountyN$Freq,
        circles = rep(0.2, nrow(CountyN)),  # circle size
        inches = FALSE,  # data units for circle size
        bg = "blue", fg = NULL, add = TRUE)
 # This plots blue circles for values

# Add state names as x-axis labels
axis(1, at = 1:length(CountyN$State), # axis 1 is X-axis here.
     labels = CountyN$State,
     las = 2, cex.axis = 0.7)
