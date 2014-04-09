## Quiz1.Rmd

Load the dataset

```r
dataset = read.csv("hw1_data.csv", header = T)
```

Question 11

```r
names(dataset)
```

```
## [1] "Ozone"   "Solar.R" "Wind"    "Temp"    "Month"   "Day"
```

Question 12

```r
dataset[1:2, ]
```

```
##   Ozone Solar.R Wind Temp Month Day
## 1    41     190  7.4   67     5   1
## 2    36     118  8.0   72     5   2
```

Question 13

```r
nrow(dataset)
```

```
## [1] 153
```

Question 14

```r
dataset[(nrow(dataset) - 1):nrow(dataset), ]
```

```
##     Ozone Solar.R Wind Temp Month Day
## 152    18     131  8.0   76     9  29
## 153    20     223 11.5   68     9  30
```

Question 15

```r
dataset[47, "Ozone"]
```

```
## [1] 21
```

Question 16

```r
sum(is.na(dataset[, "Ozone"]))
```

```
## [1] 37
```

Question 17

```r
mean(dataset[, "Ozone"], na.rm = T)
```

```
## [1] 42.13
```

Question 18

```r
mean(dataset[(dataset$Ozone > 31 & dataset$Temp > 90), ]$Solar.R, na.rm = T)
```

```
## [1] 212.8
```

Question 19

```r
mean(dataset[dataset$Month == 6, ]$Temp, na.rm = T)
```

```
## [1] 79.1
```

Question 20

```r
max(dataset[dataset$Month == 5, ]$Ozone, na.rm = T)
```

```
## [1] 115
```

