## R Programming - PA 3

source("pa3/rprog-scripts-submitscript3.R")


outcome <- read.csv("pa3/outcome-of-care-measures.csv", colClasses = "character")
head(outcome)
ncol(outcome)

outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[, 11])

