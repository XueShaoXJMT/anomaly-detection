library(TSA)
library(raster)
library(rgdal)
library(bfast)
data=brick("D:/NDVI_layerstack_2000-2014.tif")
#bfast
e<-extent(data,51,100,51,150)
d<-crop(data,e)
values = values(d)
fun<-function(x)
{
  if(anyNA(x)) return(NA)
  else
  {
    ts<-ts(x,freq=23,start=c(2000,4))
    md<-bfast01(ts,formula=response~harmon,bandwidth=0.05)
    ifelse(md$breaks,return(md$breakpoints),return(NA))
  }
}
dim(values)
rslt<-apply(values,1,fun)
rsltt=t(rslt)
breakpoints<-raster(matrix(rsltt,nrow=50,ncol=100,byrow=TRUE))
extent(breakpoints)<-extent(data)
projection(breakpoints)<-projection(data)
bbp<-breakpoints
breakpoints[breakpoints<(-3)]<-NA
plot(d[[302]], col=gray.colors(256))
par(new=TRUE)
plot(breakpoints,col='red')
bbp
breakpoints
#ZSTR
rslt
rslt1<-rslt[297:319]
rslt1
dim(rslt)
rslt1
dim(rslt1)
fun_ou <- function(x)
{  if(anyNA(x)) return(c(1:342)*NA)
  else{    t = ts(x,freq=23,start=c(2000,4))   
  model1 = lm(t~time(t)) 
  res = residuals(model1) 
  res = ts(res,freq=23,start=c(2000,4)) 
  har. = harmonic(res,3)   
  model2 = lm(res~har.)   
  res2 = rstudent(model2)
  res2.c = sort(res2);
  res2.c = res2.c[18:325]
  res2.c.mean = mean(res2.c)
  res2.c.sd = (sum(abs(res2.c))*sqrt(pi/2))/length(res2.c)
  res2 = (res2-res2.c.mean)/res2.c.sd
  anomalies <- (res2<(-3)) 
  anomalies[anomalies == FALSE] <- NA
  return(anomalies)
  }}
rslt2= apply(values,1,fun_ou)
rsltt2=t(rslt2)
breakpoints2<-raster(matrix(rsltt2,nrow=50,ncol=100,byrow=TRUE))
extent(breakpoints2)<-extent(d)
projection(breakpoints2)<-projection(d)
plot(d[[302]], col=gray.colors(256))
par(new=TRUE)
plot(breakpoints2,col='red')
breakpoints2
#ZSTR异常开始时间
zstrpoints<-function(x){return(which(x)[1])}
zstrp2013<-apply(rslt,1,zstrpoints)
breakpointsz<-raster(matrix(zstrp2013,nrow=50,ncol=100,byrow=TRUE))