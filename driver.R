## Driver Code
## this renders the files
setwd("~/mz/sentimentreport")
library(rmarkdown)
options("warning.length"=8000)
source("~/mz/databricks.setup.R")
runBackFillQ <- FALSE
runCron <- TRUE

knitr::opts_chunk$set(cache.extra = list(
  sessionInfo(),format(Sys.Date(), '%Y-%m-%d')
  ))

tryCatch({
    render(input="sentiment.Rmd"
          ,output_dir="/home/sguha/public_html/tmp/"
          ,intermediates_dir="/tmp/"
          ,knit_root_dir='/tmp/'
          ,envir =.GlobalEnv)
},error=function(e){
    a <- as.character(e)
    z <- paste(capture.output(traceback()),collapse="\n")
    f <- sprintf("%s\n\n%s",a,z)
    slacks$log(f,channel="@sguha")
})


