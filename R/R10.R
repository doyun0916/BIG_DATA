# R10.R #
# 
# 결측치(Missing Value)
# 
# - 누락된 값, 비어있는 값 --> NA
# - 함수 적용불가, 분석결과 왜곡
# - 1) 제거 [행] , 2) 대체 [평균값,중앙값,최소값]
# 
# - 제거 후 분석 실시 

df <- data.frame(gender = c("M", "F", NA, "M", "F"),
                 score = c(5, 4, 3, 4, NA))
df


# datatype 확인
is.character(10)
is.data.frame(df)

# 결측치 확인
is.na(df)         # 결측치 확인
table(is.na(df))  # 결측치 빈도 출력

table(is.na(df$gender))
table(is.na(df$score))

mean(df$score)
sum(df$score)

# 결측치 제거 : score
df %>% filter(is.na(score))
df %>% filter(!is.na(score))

df_nomiss <- df %>% filter(!is.na(score))
df_nomiss
mean(df_nomiss$score)
sum(df_nomiss$score)

# 결측치 제거 : score, gender
df_nomiss <- df %>% filter(!is.na(score) & !is.na(gender))
df_nomiss

# 모든 변수에 결측치 없는 데이터 추출
df_nomiss2 <- na.omit(df)  
df_nomiss2    

mean(df$score, na.rm = T)  # 결측치 제외하고 평균 산출
sum(df$score, na.rm = T)   # 결측치 제외하고 합계 산출

exam <- read.csv("Data/csv_exam.csv")    

exam

table(is.na(exam))

# 3, 8, 15행의 math에 NA 할당
exam[c(3, 8, 15), "math"] <- NA            
exam
table(is.na(exam))

mean(exam$math,na.rm=T) # --> 55

# NA 면 55점 입력, 그렇지 않으면 실제 점수 입력
# exam$math <- ifelse(조건,true,false)

exam$math <- ifelse(is.na(exam$math),55,exam$math)

table(is.na(exam))

exam

# 평균 구하기

# 평균 산출
exam %>% summarise(mean_math = mean(math))   
# 결측치 제외하고 평균 산출
exam %>% summarise(mean_math = mean(math, na.rm = T))  

# 다른 함수들에 적용

exam %>% summarise(mean_math = mean(math, na.rm = T),      # 평균 산출
                   sum_math = sum(math, na.rm = T),        # 합계 산출
                   median_math = median(math, na.rm = T))  # 중앙값 산출

# # 결측치 대체
# - 결측치 많을 경우 모두 제외하면 데이터 손실 큼
# - 대안: 다른 값 채워넣기
# 
# #### 결측치 대체법(Imputation)
# - 대표값(평균, 최빈값 등)으로 일괄 대체
# - 통계분석 기법 적용, 예측값 추정해서 대체
# 
# # 평균값으로 결측치 대체하기

# #### 이상치(Outlier) - 정상범주에서 크게 벗어난 값
# - 이상치 포함시 분석 결과 왜곡
# - 결측 처리 후 제외하고 분석
# 
# 이상치 종류      |예                |해결 방법
# -----------------|------------------|---------
# 존재할 수 없는 값|성별 변수에 3     |결측 처리
# 극단적인 값      |몸무게 변수에 200 |정상범위 기준 정해서 결측 처리
# 
# # 이상치 제거하기 
# # 존재할 수 없는 값
# # 논리적으로 존재할 수 없으므로 
# # 바로 결측 처리 후 분석시 제외

# 이상치 포함된 데이터 생성 - gender 3, score 6

outlier <- data.frame(gender = c(1, 2, 1, 3, 2, 1),
                      score = c(5, 4, 3, 4, 2, 6))
outlier

table(is.na(outlier))

outlier %>% 
  group_by(gender) %>% 
  summarise(mean_score = mean(score))

# 이상치 확인하기
table(outlier)

table(outlier$gender)
table(outlier$score)

# gender가 3이면 NA 할당
outlier$gender <- ifelse(outlier$gender == 3, NA, outlier$gender)
outlier

# score가 1~5 아니면 NA 할당
outlier$score <- ifelse(outlier$score > 5, NA, outlier$score)
outlier

outlier %>% 
  group_by(gender) %>% 
  summarise(mean_score = mean(score))

# 결측치 제외하고 분석

outlier %>%
  filter(!is.na(gender) & !is.na(score)) %>%
  group_by(gender) %>%
  summarise(mean_score = mean(score))








