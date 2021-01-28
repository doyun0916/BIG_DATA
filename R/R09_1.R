# R09.R #

### R&SQL (Oracle[HR], File )

## [SE] C:\app\HPE\product\11.2.0\dbhome_1\jdbc\lib

## [XE] C:\oraclexe\app\oracle\product\11.2.0\server\jdbc\lib

# ojdbc6.jar [Copy] --> /Data/ojdbc6.jar

# RJDBC 패키지 install/On

install.packages("RJDBC")
library(RJDBC)

jdbcDriver <- JDBC(driverClass = "oracle.jdbc.OracleDriver",
                   classPath = "Data/ojdbc6.jar")

conn <- dbConnect(jdbcDriver,
                  "jdbc:oracle:thin:@localhost:1521:orcl",
                  "hr",
                  "hr")
qr01 <- "select * from jobs"
rs01 <- dbGetQuery(conn,qr01)
View(rs01)

# IT부서 소속 직원들의 FirstName,LastName,salary,
#                       departmentName, JobTitle
                       
qr02 <- "select First_Name,Last_Name,salary,department_Name, Job_Title
          from employees e, departments d, jobs j
          where (e.department_id = d.department_id)
           and  (e.job_id = j.job_id)
           and  (d.department_name = 'IT')"
rs02 <- dbGetQuery(conn,qr02)
rs02

# 부서이름별 직원수
qr03 ="select d.department_name, count(e.employee_id)
        from DEPARTMENTS d, employees e
        where ( d.department_id = e.department_id )
        group by d.department_name
        order by count(e.employee_id) desc"
rs03 = dbGetQuery(conn,qr03)
rs03

# 부서이름별 평균 급여
qr04 = "select d.department_name, round(avg(e.salary))
        from DEPARTMENTS d, employees e
        where ( d.department_id = e.department_id )
        group by d.department_name
        order by avg(e.salary) desc"
rs04 = dbGetQuery(conn,qr04)
rs04

####################################################

# 패키지 설치 : googleVis, sqldf 설칭/On

install.packages("googleVis")
install.packages("sqldf")

library(googleVis)
library(sqldf)

googleVis::Fruits
  
Fruits

# Fruits -> [save] -> /Data/Fruits00.csv

write.csv(Fruits,'Data/Fruits00.csv',
          quote = F,
          row.names = F)

Fruits00 <- read.csv('Data/Fruits00.csv')
Fruits00

Fruits01 <- read.csv.sql(file = 'Data/Fruits00.csv',
                         sql = 'select * from file
                                where Year = 2008')
Fruits01

# 과일별 sales 합계는? --> Fruits02 
Fruits02 <- read.csv.sql(file = 'Data/Fruits00.csv',
                         sql = 'select Fruit,sum(Sales)
                                from file
                                group by Fruit')
Fruits02
##########################################################
library(dplyr)

exam <- read.csv('Data/csv_exam.csv')
exam

# class가 1인 경우만 추출 <-- where class = 1

exam %>% filter(class == 1)

# Ctrl+Shift+M
exam %>% filter(class == 3)

# 1반이 아닌 경우
exam %>% filter(class != 1)

# 수학 점수가 50점을 초과
exam %>% filter(math > 50)

# 영어점수가 80점 이하인 경우
exam %>% filter(english <= 80)

# 1반 이면서 수학 점수가 50점 이상
exam %>% filter((class == 1) & (math >= 50))

# 수학점수가 90점 이상이거나 
# 영어점수가 90점 이상인 경우
exam %>% filter(math >= 90 | english >= 90)

# 1, 3, 5 반에 해당되면 추출
exam %>% filter(class == 1 | class == 3 | class == 5)  

exam %>% filter(class %in% c(1,3,5)) # <- where (class in (1,3,5))

class1 <- exam %>% filter(class == 1)  
class2 <- exam %>% filter(class == 2) 

mean(class1$math)                     
mean(class2$math)         

# 필요한 변수만 추출 <-- select 변수

exam %>% select(class, math, english)

exam %>% select(-math)  # math 제외
exam %>% select(-math, -english)  # math, english 제외


# dplyr 함수 조합
# class가 1인 행만 추출한 다음 english 추출

exam %>% filter(class == 1) %>% select(class,id,english)

exam %>% 
  filter(class %in% c(1,3,5)) %>% 
  select(class,id,math) %>% 
  head(5)

# math 오름차순 정렬
exam %>% arrange(math)  

# 내림차순으로 정렬하기
exam %>% arrange(desc(math))  # math 내림차순 정렬

# 정렬 기준 변수 여러개 지정
exam %>% arrange(class, math)  # class 및 math 오름차순 정렬

exam %>% arrange(class, desc(math))

################################################################

class(exam)

exam %>% 
  mutate(total= math + english + science,
         mean = total/3)

exam %>%
  mutate(total = math + english + science,          # 총합 변수 추가
         mean = (math + english + science)/3) %>%   # 총평균 변수 추가
  head                                              # 일부 추출


# `mutate()`에 `ifelse()` 적용하기
exam %>%
  mutate(test = ifelse(science >= 60, "pass", "fail")) %>%
  head



#### 집단별로 요약하기

exam %>%
  group_by(class) %>%                # class별로 분리
  summarise(mean_math = mean(math))  # math 평균 산출

#### 여러 요약통계량 한 번에 산출하기

exam %>%
  group_by(class) %>%                   # class별로 분리
  summarise(mean_math = mean(math),     # math 평균
            sum_math = sum(math),       # math 합계
            median_math = median(math), # math 중앙값
            n = n())                    # 학생 수

exam

#### 데이터 전처리(Preprocessing) <- dplyr 패키지 ####

# 함수       |기능
# -----------|-------
#   filter()   |행 추출
# select()   |열(변수) 추출
# arrange()  |정렬
# mutate()   |변수 추가
# summarise()|통계치 산출
# group_by() |집단별로 나누기
# left_join()|데이터 합치기(열)
# bind_rows()|데이터 합치기(행)

#### 자주 사용하는 요약통계량 함수

# 함수    |의미
# --------|-----
# mean()  |평균
# sd()    |표준편차
# sum()   |합계
# median()|중앙값
# min()   |최소값
# max()   |최대값
# n()     |빈도

#######################################################
# 각 집단별로 다시 집단 나누기

mpg %>%
  group_by(manufacturer, drv) %>%      # 회사별, 구방방식별 분리
  summarise(mean_cty = mean(cty)) %>%  # cty 평균 산출
  head(10)                             # 일부 출력

# dplyr 조합하기

# 회사별로 "suv" 자동차의 도시 및 고속도로 
# 통합 연비 평균을 구해 내림차순으로 정렬하고, 
# 1~5위까지 출력하기

# 분석 절차 생각해보기
# 
# 절차  |기능                |dplyr 함수
# :----:|--------------------|---------
# 1     |회사별로 분리       |group_by()
# 2     |suv 추출            |filter()
# 3     |통합 연비 변수 생성 |mutate()
# 4     |통합 연비 평균 산출 |summarise()
# 5     |내림차순 정렬       |arrange()
# 6     |1~5위까지 출력      |head()
# 
# dplyr 조합하기

mpg %>%
  group_by(manufacturer) %>%           # 회사별로 분리
  filter(class == "suv") %>%           # suv 추출
  mutate(tot = (cty+hwy)/2) %>%        # 통합 연비 변수 생성
  summarise(mean_tot = mean(tot)) %>%  # 통합 연비 평균 산출
  arrange(desc(mean_tot)) %>%          # 내림차순 정렬
  head(5)                              # 1~5위까지 출력

##############################################

# 중간고사 데이터 생성
test1 <- data.frame(id = c(1, 2, 3, 4, 5),
                    midterm = c(60, 80, 70, 90, 85))

# 기말고사 데이터 생성
test2 <- data.frame(id = c(1, 2, 3, 4, 5),
                    final = c(70, 83, 65, 95, 80))

test1  # test1 출력
test2  # test2 출력

total <- left_join(test1,test2, by='id')
total

# 다른 데이터 활용해 변수 추가하기

# 반별 담임교사 명단 생성

exam <- read.csv('Data/csv_exam.csv')
exam


name <- data.frame(class = c(1, 2, 3, 4, 5),
                   teacher = c("kim", "lee", "park", "choi", "jung"))
name

exam_new <- left_join(exam,name, by='class' )
exam_new

### 세로로 합치기

# 데이터 생성

# 학생 1~5번 시험 데이터 생성
group_a <- data.frame(id = c(1, 2, 3, 4, 5),
                      test = c(60, 80, 70, 90, 85))

# 학생 6~10번 시험 데이터 생성
group_b <- data.frame(id = c(6, 7, 8, 9, 10),
                      test = c(70, 83, 65, 95, 80))



group_a  # group_a 출력
group_b  # group_b 출력

group_all <- bind_rows(group_a,group_b)
group_all

# fl  |연료 종류  |가격(갤런당 USD)
# :--:|:---------:|:---:
#   c   |CNG        |2.35
# d   |diesel     |2.38
# e   |ethanol E85|2.11
# p   |premium    |2.76
# r   |regular    |2.22


fuel <- data.frame(fl = c("c", "d", "e", "p", "r"),
                   price_fl = c(2.35, 2.38, 2.11, 2.76, 2.22),
                   stringsAsFactors = F)
fuel  

#### 정 리 ####

# 조건에 맞는 데이터만 추출하기
exam %>% filter(english >= 80)

# 여러 조건 동시 충족
exam %>% filter(class == 1 & math >= 50)

# 여러 조건 중 하나 이상 충족
exam %>% filter(math >= 90 | english >= 90)
exam %>% filter(class %in% c(1,3,5))


# 2.필요한 변수만 추출하기
exam %>% select(math)
exam %>% select(class, math, english)


# 3.함수 조합하기, 일부만 출력하기
exam %>%
  select(id, math) %>%
  head(10)

# 순서대로 정렬하기
exam %>% arrange(math)         # 오름차순 정렬
exam %>% arrange(desc(math))   # 내림차순 정렬
exam %>% arrange(class, math)  # 여러 변수 기준 오름차순 정렬

# 파생변수 추가하기
exam %>% mutate(total = math + english + science)

# 여러 파생변수 한 번에 추가하기
exam %>%
  mutate(total = math + english + science,
         mean = (math + english + science)/3)

# mutate()에 ifelse() 적용하기
exam %>% mutate(test = ifelse(science >= 60, "pass", "fail"))

# 추가한 변수를 dplyr 코드에 바로 활용하기
exam %>%
  mutate(total = math + english + science) %>%
  arrange(total)

# 집단별로 요약하기
exam %>%
  group_by(class) %>%
  summarise(mean_math = mean(math))

# 각 집단별로 다시 집단 나누기
mpg %>%
  group_by(manufacturer, drv) %>%
  summarise(mean_cty = mean(cty))



# 가로로 합치기
total <- left_join(test1, test2, by = "id")

# 세로로 합치기
group_all <- bind_rows(group_a, group_b)



















