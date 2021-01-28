# R05.R #

### List ###

list01 <- list(name="Tom",
               age=30,
               addr="서울",
                mobile="010-1111-1111")

class(list01)

list01[1]
list01["name"]
list01$name

list01

list01[2]
list01["age"]
list01$age


list01[2] <- 40
list01["age"] <- 50
list01$age <- 35

# 주소 : 대전, 부산 
list01$addr <- c("대전","부산")
list01["addr"]

# edu : DB, SQL, R
list01$edu <- c("DB", "SQL", "R")

list01$mobile <- NULL 
list01$age <- NA


