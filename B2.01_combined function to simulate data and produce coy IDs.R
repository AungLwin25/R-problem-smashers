# Combined function to simulate data and produce coy IDs
sim_data <- function(data, ID) {
  # Function to simulate data within 5% range, rounded to integers (same as before)
  sim0.05 <- function(x) {
    if (is.na(x)) {
      return(NA)
    } else {
      lower_bound <- round(x - (x * 0.05), 0)
      upper_bound <- round(x + (x * 0.05), 0)
      return(sample(lower_bound:upper_bound, 1))
    }
  }

  sim1 <- apply(data[, -1], c(1, 2), sim0.05)

  # Generate hidden state names
  N <- nrow(data)
  FakeIDs <- paste0(ID, 1:N)

  # Combine the hidden state names with the simulated data
  sim2 <- cbind(FakeIDs, sim1)
  colnames(sim2) <- colnames(data)
  return(as.data.frame(sim2))
}

# Example usage
s1<- sim_data(Re1, "State")
print(s1)
