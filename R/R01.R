# R01.R #

a1 <- 10
#a1 <- "Tom"
#a1 <- TRUE

# 결측치는 연산 불가.
sum(10, NA, 30, na.rm=FALSE)
sum(10, NA, 30, na.rm=TRUE)

Sys.Date()
Sys.time()
class(Sys.time()) # 유닉스 기반 date type

