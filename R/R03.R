# R03.R #
# Matrix #

c(1,2,3,4)

m01 <- matrix(c(1,2,3,4))
m01

m02 <- matrix(c(1,2,3,4), nrow =2)
m02

m03 <- matrix(c(1,2,3,4), nrow = 2, byrow = T)
m03

seq(1,9)

m04 <- matrix(c(1:9), nrow=3, ncol = 3, byrow=T)
m04

m04 <- matrix(c(1:10), nrow=3, byrow=T)
m04

m04 <- matrix(seq(1,9),3,3,T)
m04

v05 <- seq(1,9)
m05 <- matrix(data = v05*10, nrow=3, byrow=T)
m05

m05[1,3]
m05[2,1]
m05[3,2]

m05[2:3, 2:3]
m05[2:3, 1:2]

m05[,2]
m05[,1:2]

m05[-2,-2]
