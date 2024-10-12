# Data Frame: CountyN

# Load data
library(readr)
read_csv("US State by number of counties.csv") -> CountyN

# Conversion to Factor
CountyN$State<- as.factor(CountyN$State)
 # plot() require both variables as numeric

# Label variables
library(labelled)
CountyN <- CountyN %>%
  set_variable_labels(State = "US State",
                      Freq = "Number of Counties")





