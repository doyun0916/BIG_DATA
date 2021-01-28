# R08.R #

exam <- read.csv("Data/csv_exam.csv")
head(exam)
head(exam,3)

tail(exam)
tail(exam,4)

View(exam)
dim(exam)
str(exam)

mean(exam$math)
median(exam$math)
min(exam$math)
max(exam$math)
var(exam$math)

# summary : 요약통계량 
summary(exam)
summary(exam$math)

summary(exam["math"])
summary(exam[c("math","science")])

install.packages("ggplot2")
library(ggplot2)

x <- c('a','b','c','a')
qplot(x)


View(ggplot2::mpg)
class(ggplot2::mpg)

mpg <- as.data.frame(ggplot2::mpg)
class(mpg)

head(mpg)
tail(mpg)
dim(mpg)
str(mpg)
summary(mpg)

install.packages("dplyr")
library(dplyr)
########################################################

df_raw <- data.frame(var1 = c(1, 2, 1),
                     var2 = c(2, 3, 2))
df_raw

df_new <- df_raw # 복사본 생성

df_new <- rename(df_new, v2 = var2)
df_new <- rename(df_new, v1 = var1)
df_new


df <- data.frame(var1 = c(4, 3, 8),
                 var2 = c(2, 6, 1))

df$var1 + df$var2

df$var_sum <- df$var1 + df$var2

df$var_mean <- (df$var1 + df$var2)/2

df$var2[1] <- 4

df
##########################################

# 조건문 (if else) , 조건함수

z1 <- 7
if(z1 > 5) { print('크다')} else {print('작다')}

z1 <- 3
if(z1 > 5) { print('크다')} else {print('작다')}

{ if(z1 > 5) { print('크다')} 
  else {print('작다')} }

if01 <- function(y) { if(y > 5) { print('크다')} 
                      else {print('작다')} }

if01(8)
if01(2)

# if02 <- 함수(x) {홀수, 짝수 }
if02 <- function(x) {
  if((x%%2)==1) {return("홀수")}
  else {return("짝수")}
}

if02(55)
if02(20)

if02(scan())

# 숫자를 입력받아서
# 4 로 나눈 나머지가 
# 0 -> 가위
# 1 -> 바위
# 2 -> 보
# 3 -> 잘못

# if ~ else if ,,,,  ~ else 문
# if03 함수로 제작 

if03 <- function(x){
  if((x%%4)==0) {return("가위")}
  else if((x%%4)==1) {return("바위")}
  else if((x%%4)==2) {return("보")}
  else  {return("잘못")}
}

if03(10)
if03(8)
if03(11)

z2 <- 9
ifelse(z2%%2==0,"짝수","홀수")

# 반복문 활용

# for 문
# for (변수 in 회수){ 처리 }

x<-3
for (i in 1:x) { print(i)}

for (i in 1:5) {print(i*i)}

f1 <- function(x){
  for(i in 1:10)
  {print(x*i)}
}
f1(7)

f2 <- function(x,y){
  for(i in 1:x) {
    for(j in 1:y)
    { cat(paste(as.character(i*j)," "))}
    cat(" \n")
  }
}
f2(10,10)
f2(7,6)

# while 문
i <- 0
while(i<5) { print(i) 
             i<- i+1 }

mpg$cty
mpg$hwy

mpg$total <- (mpg$cty + mpg$hwy)/2

mpg$total

summary(mpg$total)
hist(mpg$total)

ifelse(mpg$total>=20,"pass",'fail')
mpg$test <- ifelse(mpg$total>=20,"pass",'fail')

View(mpg)

table(mpg$test)
qplot(mpg$test)

# total을 기준으로 A, B, C 등급 부여 -> grade
mpg$grade <- ifelse(mpg$total >= 30, "A",
                    ifelse(mpg$total >= 20, "B", "C"))

head(mpg, 20)  # 데이터 확인
table(mpg$grade)

# A, B, C, D 등급 부여 -> grade2
mpg$grade2 <- ifelse(mpg$total >= 30, "A",
                     ifelse(mpg$total >= 25, "B",
                            ifelse(mpg$total >= 20, "C", "D")))

