## R02.R vector ###########

# R에서는 첫번째 방이 1임 0 아님!
v1 <- c(10, 20, 30, 40)
print(v1)
cat(v1, class(v1))

v4 <- c(1,2,3,4,5,6,7,8,9)
v4[3]
v4[3:7]
v4[1:5]
v4[5:9]

# python과는 음수 인덱싱 동작이 다름, 여기선 제외한다는 뜻
v4[-5]
v4[-1:-3]       # (1,2,3) 을 제외하는 것.

# 에러 안남.
v4[1:12]

v5 <- c(10,20,30,40,50)
v5
# 원소를 string으로 바꿔버리면, 모든 다른 원소도 string으로 됨!
v5[3] <- "300"
v5

# 원소는 무제한으로 됨...
v6 <- c(10,20,30,40,50)
v6[9] <- 90
v6
v6 <- append(v6, 60, after=5)               # after 뒤에 추가하라는 뜻.
v6 <- append(v6, c(70,70), after=6)
v6
v6 <- append(v6, 1, after=0)
v6
v6 <- append(v6, 10, after=3)
v6

v7 <- c(10,20,30)
v8 <- c(1,2,3)
v9 <- c(1,2)
v10 <- c(10,20,30,40)

v7+1
v7*2
v7-5
v7/10
100/v7
# 에러 안남! Inf로 나옴
v11 <- c(10, 0, 20, 30)
100/v11

v7 + v8
v7 + v9       # 안됨
v10 + v9      #  배수로써 서로를 맞출수 있으면 연산 가능!

union(v7,v8)
union(v7,v9)

stu_names <- c("Tom", "Alice", "Jane")
kor_points <- c(78,96,84)

names(kor_points) <- stu_names
kor_points
kor_points[2]
kor_points["Alice"]
length(kor_points)

#벡터에선 콜론
c(1:5)
c(5:1)
c(-5:5)

# 시퀸스는 콤마
seq(1,5)
seq(5,1)
seq(-5,5)

seq(1,10,by=2)
seq(from=1, to=10, by=2)

rep(1:3, 2)
rep(1:3, each=2)

v11 <- c(1:9)

3 %in% v11
13 %in% v11

# v11에서 3,5,8을 제외시키세요
v11 <- v11[-c(3,5,8)]              # 여러개 할때는 묶는다.
v11

v12 <- c(1:9)
v12[v12>3]
