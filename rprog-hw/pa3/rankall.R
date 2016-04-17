rankall <- function(outcome, num = "best") {
  ## Read outcome data
  df.outcome = read.csv("outcome-of-care-measures.csv", colClasses = "character")
  outcomes = c("heart attack", "heart failure", "pneumonia")
  
  ## Check that state and outcome are valid
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
  
  ## For each state, find the hospital of the given rank
  df.outcome = subset(df.outcome, df.outcome[[outcome.col]] != "Not Available")
  df.outcome[[outcome.col]] <- as.numeric(df.outcome[[outcome.col]])
  df.outcome = df.outcome[order(df.outcome[[outcome.col]], df.outcome$Hospital.Name, decreasing = FALSE),]
  
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  outcome.list = split(df.outcome, df.outcome$State)
  resp = sapply(outcome.list, function(df) {
    if (num == "best") num = 1
    if (num == "worst") num = nrow(df)
    df$Hospital.Name[num]
  })
  
  data.frame(hospital=resp, state=names(resp))

}