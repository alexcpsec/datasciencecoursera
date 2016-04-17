best <- function(state, outcome) {
  ## Read outcome data
  df.outcome = read.csv("outcome-of-care-measures.csv", colClasses = "character")
  outcomes = c("heart attack", "heart failure", "pneumonia")
  
  ## Check that state and outcome are valid
  if (!(state %in% df.outcome$State)) {
    stop("invalid state")
  }
  if (!(outcome %in% outcomes)) {
    stop("invalid outcome")
  }
  
  if (outcome == "heart attack") {
    outcome.col = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
  } else if (outcome == "heart failure") {
    outcome.col = "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
  } else {
    outcome.col = "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
  }
  
  ## Return hospital name in that state with lowest 30-day death rate
  df.outcome = subset(df.outcome, df.outcome$State == state)
  df.outcome = subset(df.outcome, df.outcome[[outcome.col]] != "Not Available")
  df.outcome[[outcome.col]] <- as.numeric(df.outcome[[outcome.col]])
  df.outcome = df.outcome[order(df.outcome[[outcome.col]], decreasing = FALSE),]
  
  df.outcome$Hospital.Name[[1]]
}