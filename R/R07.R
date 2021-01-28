# R07.R #

english <- c(90, 80, 60, 70)  # 영어 점수 변수 생성
english

math <- c(50, 60, 100, 20)    # 수학 점수 변수 생성
math

# english, math로 데이터 프레임 생성해서 df_midterm에 할당
df_midterm <- data.frame(english, math)
df_midterm

class <- c(1, 1, 2, 2)
class

df_midterm <- data.frame(english, math, class)
df_midterm

mean(df_midterm$english)
max(df_midterm$english)
min(df_midterm$english)

paste(df_midterm$english,collapse = ',')
####################################################

mean(df_midterm$english)  # df_midterm의 english로 평균 산출
mean(df_midterm$math)     # df_midterm의 math로 평균 산술

df_midterm <- data.frame(english = c(90, 80, 60, 70),
                         math = c(50, 60, 100, 20),
                         class = c(1, 1, 2, 2))
df_midterm
####################################################

# install.packages("readxl")
# library(readxl)

getwd()

# 상대경로
read_excel("Data/excel_exam.xlsx")

# 절대경로 
# C:\PySrc\source\rPro\Data

getwd()
read_excel("C:/PySrc/source/rPro/Data/excel_exam.xlsx")

read_excel("Data/excel_exam.xlsx")

df_exam <- read_excel("Data/excel_exam.xlsx")

View(df_exam)

df_exam$english
df_exam$math

mean(df_exam$english)
mean(df_exam$math)
mean(df_exam$science)

df_exam_novar <- read_excel("Data/excel_exam_novar.xlsx",
                            col_names = F)

df_exam_sheet <- read_excel("Data/excel_exam_sheet.xlsx",
                            sheet = 3)

df_exam_sheet
####################################################

df_csv_exam <-  read.csv("Data/csv_exam.csv")
df_csv_exam

df_midterm <- data.frame(english = c(90, 80, 60, 70),
                         math = c(50, 60, 100, 20),
                         class = c(1, 1, 2, 2))
df_midterm

write.csv(df_midterm, file = "Data/df_midterm.csv")

save(df_midterm, file="Data/df_midterm.rda")

rm(df_midterm)

load("Data/df_midterm.rda")







