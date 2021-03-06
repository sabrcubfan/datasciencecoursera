source("complete.R")

corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  files_list <- list.files(directory, full.names=TRUE)
  #correlations <- vector()
  correlations <- vector(mode = "numeric", length = 0)
  
  for (i in 1:length(files_list)) {
    file <- read.csv(files_list[i])
    cc <- sum(complete.cases(file))
    if (cc > threshold) {
      file_clean <- file[complete.cases(file), ]
      correlations <- c(correlations, cor(file_clean$sulfate, file_clean$nitrate))
    }
  }
  correlations
}
  

cr <- corr("specdata", 150)
head(cr)
summary(cr)

cr <- corr("specdata", 400)
head(cr)
summary(cr)

cr <- corr("specdata", 5000)
summary(cr)
length(cr)

cr <- corr("specdata")
summary(cr)
length(cr)
