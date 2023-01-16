
searchUrl = "https://www.coupang.com/np/search"
query = URLencode(iconv("노트북", "euc-kr","UTF-8"))
url = paste(searchUrl,"?q=",query,sep="")


content = read_html(url,encoding="UTF-8")  

namenodes = html_nodes(content, ".name")
name = html_text(namenodes)

pricenodes = html_nodes(content, ".price-value")

price = html_text(pricenodes)
pointnodes = html_nodes(content, ".rating") # 등급 가져오기.

point = html_text(pointnodes)
page = cbind(name, price)

page = cbind(page, point)

page

#여기까지가 노트북에 대한 쿠팡 자료 긁어오기. 

price

###########################

coupang <- NULL

for(i in 1:10){
  
  url2 <- paste(url, i, sep="") #페이지 수가 바뀜.
  content <- read_html(url)
  
  namenodes <- html_nodes(content, ".name")
  name <- html_text(namenodes)
  
  pricenodes <- html_nodes(content, ".price-value")
  price <- html_text(pricenodes)
  
  pointNodes <- html_nodes(content, ".rating")
  point <- html_text(pointNodes)
  
  page <- cbind(name, price)
  
  page <- cbind(page, point)
  
  coupang <- rbind(coupang, page)
  
} 

#여기까지가 페이지에 대한 노트북 전부 긁어오는거 
# 이제 부터 가격의 자료형을 바꾸는거ㅣ지

coupang

price<-coupang[,2]

price1=gsub(pattern = ",", replacement = "", x = price)
price2 <- as.numeric(price1) # 이때 오류나는데 이유는 쉼표때문.

#####

price3=data.frame(price2)

#a <- price3[price3$price2 >=1000000,]

a <- subset(price3, price2>=2000000)
b <- subset(price3, price2>=1500000 & price2 < 2000000)
c <- subset(price3, price2>=1000000 & price2 < 1500000)
d <- subset(price3, price2>=700000 & price2 < 1000000)
e <- subset(price3, price2>=500000 & price2 < 700000)
f <- subset(price3, price2>=300000 & price2 < 500000)
g  <- subset(price3, price2>=100000 & price2 < 300000)


a1<-nrow(a)
b1<-nrow(b)
c1<-nrow(c)
d1<-nrow(d)
e1<-nrow(e)
f1<-nrow(f)
g1<-nrow(g)

###########
#여기서부터가 차트

install.packages("graphics")
library(graphics)


par(mfrow=c(1,2), mar=c(7,5,4,4))
height=c(g1,f1,e1,d1,c1,b1,a1)
name=c("10만원이상","30만원이상","50만원이상","70만원이상","100만원이상","150만원이상","200만원이상" )


bp= barplot(height, main ="노트북가격분포",names.arg=name, col=rainbow(length(height)), 
            xlab="가격",ylab="노트북개수", ylim=c(0,150))

text(x=bp, y=height, labels=round(height,0), pos=3) #그래프 위에 



barplot(height, main ="노트북가격분포",names.arg=name, col=rainbow(length(height)), 
        xlab="가격",ylab="노트북개수", horiz= TRUE, width=50, xlim=c(0,150)) # 그래프 가로로 만들기


max(price2)
min(price2)



















