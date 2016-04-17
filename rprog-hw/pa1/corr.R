source("complete.R")

corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  dir.path = file.path(getwd(), directory)
  if (!file.exists(dir.path)) return(NA)
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  if (threshold < 0) return(NA)
  comp.obs = complete(directory)
  ids = comp.obs[comp.obs$nobs > threshold,]$id
  
  ## Return a numeric vector of correlations
  cor.values = numeric(0)
  for (i in ids) {
    filename = file.path(dir.path, sprintf("%03d.csv", i)) 
    csv.data = read.csv(filename, header=T)
    cor.values = c(cor.values, 
                   cor(csv.data$sulfate, csv.data$nitrate, use="pairwise.complete.obs"))
  }
  
  return(cor.values)
}