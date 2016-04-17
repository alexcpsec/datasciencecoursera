
complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  dir.path = file.path(getwd(), directory)
  if (!file.exists(dir.path)) return(NA)
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  if (any(id < 1)) return(NA)
  if (any(id > 332)) return(NA)
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  df.cc = data.frame(id = integer(), nobs = integer())
  for (i in id) {
    filename = file.path(dir.path, sprintf("%03d.csv", i))
    csv.data = read.csv(filename, header=T)
    dt.temp = data.frame(id = i, nobs = sum(complete.cases(csv.data)))
    df.cc = rbind(df.cc, dt.temp)
  }
  return(df.cc)
}