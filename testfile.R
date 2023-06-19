print("hello world")

x<-1:4
y<-2:3
x+y

data1 <- read.csv("hw1_data.csv")

data1[(nrow(data1)-1):nrow(data1),]

data1[47,]$Ozone

sum(is.na(data1$Ozone))

mean(data1$Ozone, na.rm = TRUE)

sub1 <- data1[data1$Ozone>31 & data1$Temp>90, ]
mean(data1$Solar.R, na.rm = TRUE)
mean(data1[which(data1$Ozone >31 & data1$Temp > 90),]$Solar.R)

sub2 <- data1[data1$Month==6,]
mean(data1$Temp, na.rm=TRUE)

max(data1[which(data1$Month==5),]$Ozone, na.rm=TRUE)

