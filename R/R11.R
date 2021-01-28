# R11.R R

### 기본 그래프 패키지: graphics ### 

# 막대그래프 / 히스토그램 / 원형그래프 / 수염상자그림 
#   boxplot  /    hist    /     pie    /  boxplot

# 선호하는 계절 조사 

favorite <- c('WINTER', 'SUMMER', 'SPRING', 'SUMMER', 'SUMMER',
              'FALL', 'FALL', 'SUMMER', 'SPRING', 'SPRING')
favorite
ds01 <-table(favorite)
barplot(ds01, 
        main = "favorite season",
        col='blue')

# colors()
# rgb(255,255,255)

barplot(ds01, 
        main = "favorite season",
        col=c('red','yellow','green','blue') )

barplot(ds01, 
        main = "favorite season",
        col= rainbow(4) )        

barplot(ds01, 
        main = "favorite season",
        col= rainbow(4),
        xlab = '계절',
        ylab = '빈도수')  

barplot(ds01, 
        main = "favorite season",
        col= rainbow(4),
        xlab = '계절',
        ylab = '빈도수',
        horiz= TRUE)  

barplot(ds01, 
        main = "favorite season",
        col= rainbow(4),
        xlab = '계절',
        ylab = '빈도수',
        names = c('FA','SP','SU','WI')) 

barplot(ds01, 
        main = "favorite season",
        col= rainbow(4),
        xlab = '계절',
        ylab = '빈도수',
        las=2)  
