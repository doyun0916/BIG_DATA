# R09.R #

#### factor 공부 필요 ####

## R&SQL ##

install.packages("RJDBC")
library(RJDBC)
jdbcDriver <- JDBC(driverClass = "oracle.jdbc.OracleDriver",
                   classPath = "Data/ojdbc6.jar")
conn <- dbConnect(jdbcDriver, 
                  "jdbc:oracle:thin:@localhost:1521:xe",
                  "hr",
                  "hr")

qr01 <- "select * from jobs"
rs01 <- dbGetQuery(conn,qr01)
rs01

qr02 <- "select e.first_name, e.last_name, e.salary, d.department_name, j.job_title
from employees e, departments d, jobs j  
where e.department_id = d.department_id and d.department_name='IT' and e.job_id = j.job_id"
rs02 <- dbGetQuery(conn,qr02)
rs02

qr03 <- "select count(e.employee_id) from employees e, departments d where e.department_id = d.department_id group by d.department_name"
rs03 <- dbGetQuery(conn,qr03)
rs03

qr04 <- "select round(avg(e.salary)) from employees e, departments d where e.department_id = d.department_id group by d.department_name"
rs04 <- dbGetQuery(conn, qr04)
rs04

install.packages("googleVis")
install.packages("sqldf")
library(googleVis)
library(sqldf)

googleVis::Fruits

Fruits

write.csv(Fruits, "Data/Fruits00.csv", quote=F, row.names = F)

Fruits00 <- read.csv('Data/Fruits00.csv')
Fruits00

Fruits01 <- read.csv.sql(file = 'Data/Fruits00.csv',
                         sql = 'select * from file where year = 2008')
Fruits01

Fruits02 <- read.csv.sql(file = 'Data/Fruits00.csv',
                         sql = 'select fruit, sum(sales) from file group by fruit')
Fruits02

####################################################################################
library(dplyr)

exam <- read.csv('Data/csv_exam.csv')
exam

exam %>% filter(class == 1)

# ctrl+shift+M  => where
exam %>% filter(class == 3)

exam %>% filter(class != 1)

exam %>% filter(math > 50)

exam %>% filter((class==1) & (math >= 50))

exam %>% filter(class %in% c(1,3,5))

class1 <- exam %>% filter(class == 1)
class2 <- exam %>% filter(class == 2)

mean(class1$math)
mean(class2$math)

##############################################################################

exam %>% select(class, math, english)
exam %>% select(-class)
exam %>% select(-class,-english)

exam %>%  filter(class == 1) %>%  select(class, id, english)

exam %>%  filter(class %in% c(1,3,5)) %>% select(class, id, math) %>% head(5)

exam %>%  arrange(math)
exam %>%  arrange(desc(math))
exam %>%  arrange(class, math)

###############################################################################
class(exam)

exam %>% mutate(total=math + english + science, mean = total/3) %>% head

exam %>% mutate(test = ifelse(science >= 60, "pass", "fail")) %>% head

exam %>% group_by(class) %>% summarise(mean_math = mean(math), 
                                       sum_math = sum(math),
                                       median_math = median(math),
                                       count = n())

exam

#### 데이터 전처리(Preprocessing) <- dplyr 패키지 ####

# 함수 |기능
# -----------|-------
# filter() |행 추출
# select() |열(변수) 추출
# arrange() |정렬
# mutate() |변수 추가
# summarise()|통계치 산출
# group_by() |집단별로 나누기
# left_join()|데이터 합치기(열)
# bind_rows()|데이터 합치기(행)

#### 자주 사용하는 요약통계량 함수

# 함수 |의미
# --------|-----
# mean() |평균
# sd() |표준편차
# sum() |합계
# median()|중앙값
# min() |최소값
# max() |최대값
# n() |빈도

# 각 집단별로 다시 집단 나누기

mpg %>%
group_by(manufacturer, drv) %>% # 회사별, 구방방식별 분리
summarise(mean_cty = mean(cty)) %>% # cty 평균 산출
head(10) # 일부 출력

# dplyr 조합하기

# 회사별로 "suv" 자동차의 도시 및 고속도로
# 통합 연비 평균을 구해 내림차순으로 정렬하고,
# 1~5위까지 출력하기
# 분석 절차 생각해보기

# 절차 |기능 |dplyr 함수
# :----:|--------------------|---------
# 1 |회사별로 분리 |group_by()
# 2 |suv 추출 |filter()
# 3 |통합 연비 변수 생성 |mutate()
# 4 |통합 연비 평균 산출 |summarise()
# 5 |내림차순 정렬 |arrange()
# 6 |1~5위까지 출력 |head()

# dplyr 조합하기
mpg %>%
group_by(manufacturer) %>% # 회사별로 분리
filter(class == "suv") %>% # suv 추출
mutate(tot = (cty+hwy)/2) %>% # 통합 연비 변수 생성
summarise(mean_tot = mean(tot)) %>% # 통합 연비 평균 산출
arrange(desc(mean_tot)) %>% # 내림차순 정렬
head(5) # 1~5위까지 출력


test1 <- data.frame(id = c(1,2,3,4,5), midterm = c(60, 80, 70, 90, 85))
test2 <- data.frame(id = c(1,2,3,4,5), final = c(70,83,65,95,80))
test1
test2

total <- left_join(test1, test2, by = 'id')
total

exam <- read.csv('Data/csv_exam.csv')
exam

name <- data.frame(class= c(1,2,3,4,5), teacher = c("kim", "lee", "park", "choi", "jung"))
name

exam_new <- left_join(exam, name, by='class')
exam_new

group_all <- bind_rows(group_a, group_b)

df <- data.frame(gender = c("M", "F", NA, "M", "F"),
                 score = c(5,4,3,4,NA))
df

# datatype 확인
is.character(10)
is.data.frame(df)

#결측치 확인
is.na(df)
table(is.na(df))

table(is.na(df$gender))

mean(df$score)
table(is.na(df$score))


