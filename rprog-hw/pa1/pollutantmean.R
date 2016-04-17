
pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  dir.path = file.path(getwd(), directory)
  if (!file.exists(dir.path)) return(NA)
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  if (!(pollutant %in% c("sulfate", "nitrate"))) return(NA)
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  if (any(id < 1)) return(NA)
  if (any(id > 332)) return(NA)
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  pol.values = numeric(0)
  for (i in id) {
    filename = file.path(dir.path, sprintf("%03d.csv", i)) 
    csv.data = read.csv(filename, header=T)
    pol.values = c(pol.values, csv.data[[pollutant]])
  }
  return(mean(pol.values, na.rm=T))
}