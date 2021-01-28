# R06.R #

### DataFrame ###

stu_names <- c("Tom","Alice","Jane")
kor_points <- c(78,95,84)
eng_points <- c(87,77,81)

students <- data.frame(name=stu_names,
                       kor=kor_points,
                       eng=eng_points)

class(students)
class(students$name)
class(students$kor)
class(students$eng)

students

students[1]
students["name"]
students$name

students$name[1]
students$name[c(1,3)]

### factor ###
# 등급 : A, B, C
f01 <- c('A','B','C','B','A')
f01[4] <- 'Z'
f01

f02 <- factor(c('A','B','C','B','A'))
f02
f02[4] <- 'Z';
f02[4] <- 'C';
f02
#################################

students
# 3번 학생의 이름 --> John

students$name[3] <- 'John'
students

data.frame()

students01 <- data.frame(name=stu_names,
                       kor=kor_points,
                       eng=eng_points,
                       stringsAsFactors = TRUE)
students01
students01$name[3] <- 'John'
students01

students01$name
students01$name[3] <- 'Jane'
students01
#######################################################

students02 <- data.frame(name=stu_names,
                         kor=kor_points,
                         eng=eng_points,
                         stringsAsFactors = FALSE)
students02

v01 <- c(1:9)
v01[v01>3]
v01[v01%%2==0]

# students02 : 국어점수가 80 초과 학생만 출력
students02[students02$kor>80]
students02$name[students$kor>80]
#students02[c("name","kor")][students$kor>80]
subset(students02,kor>80)

# students02 : 영어점수가 80 미만 학생만 출력
subset(students02,eng<80)

# students02 : 국어>80 그리고 영어<80 인 학생만 출력
subset(students02,(kor>80)&(eng<80) )

# students02 : 국어>85 또는 영어<85 인 학생만 출력
subset(students02,(kor>85)|(eng<85) )

# kor 95
subset(students,kor==95)
# name tom
subset(students,name=="Tom")

#####################################################

stu01 <- data.frame(name="Elsa",
                    kor=77,
                    eng=88)
students02 <- rbind(students02,stu01)
students02

mat_points <- c(67,99,79,83)

students02 <- cbind(students02,mat=mat_points)

subset(students02,name=="Elsa")

students02$mat[4] <- 100

students02$mat[students02$name=="Elsa"] <- 50

students02

students02 <- cbind(students02,mat_points)

students02$mat_points <- NULL

students02

ncol(students02)
nrow(students02)
names(students02)
rownames(students02)
colnames(students02)
row.names(students02)
