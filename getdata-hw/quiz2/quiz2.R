# Getting and Cleaning data - Quiz 2

## Soutions for the Quiz 2 questions:
if (grepl(getwd(), "quiz2$") == FALSE) {
  setwd(paste0(getwd(), "/quiz2"))
}

## Question 1
library(httr)

clientId = Sys.getenv("GITHUB_API_ClientID")
clientSecret = Sys.getenv("GITHUB_API_ClientSecret")

endpoints.github = oauth_endpoints("github")
app.github = oauth_app("github", clientId, clientSecret)
token.github = oauth2.0_token(endpoints.github, app.github)

req <- GET("https://api.github.com/users/jtleek/repos", config(token = token.github))
stop_for_status(req)
resp = content(req)

for (repo in resp) {
  if (repo$name == "datasharing") {
    print(paste0("Question 1: ", repo$created_at))
  }
}

## Question 2
library(sqldf)

acs = read.csv(file="getdata-data-ss06pid.csv", header=TRUE)
sqldf("select pwgtp1 from acs where AGEP < 50")

## Question 3
all.equal(unlist(sqldf("select distinct AGEP from acs"), use.names=F), unique(acs$AGEP))

## Question 4
req4 = GET("http://biostat.jhsph.edu/~jleek/contact.html")
resp4 = content(req4, as="text")
resp.lines = unlist(strsplit(resp4, "\n", fixed=T))
line.nchar = nchar(resp.lines)
line.nchar[c(10,20,30,100)]

## Question 5
resp5 = read.fwf(file="getdata-wksst8110.for", skip=4,
                 widths=c(12, 7,4, 9,4, 9,4, 9,4))
sum(resp5$V4)
