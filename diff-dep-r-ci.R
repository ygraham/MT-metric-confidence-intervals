args <- commandArgs(T)
lp <- args[1]

# Code to compute confidence intervals for correlations with human assessment 
# achieved by automatic MT metrics by Zou (2007) (see also Baguley (2012))

rho.rxy.rxz <- function(rxy, rxz, ryz) {
  num <- (ryz-1/2*rxy*rxz)*(1-rxy^2-rxz^2-ryz^2)+ryz^3
  den <- (1 - rxy^2) * (1 - rxz^2)
  num/den
}

r.dol.ci <- function(r12, r13, r23, n, conf.level = 0.95) {
    L1 <- rz.ci(r12, n, conf.level = conf.level)[1]
    U1 <- rz.ci(r12, n, conf.level = conf.level)[2]
    L2 <- rz.ci(r13, n, conf.level = conf.level)[1]
    U2 <- rz.ci(r13, n, conf.level = conf.level)[2]
    rho.r12.r13 <- rho.rxy.rxz(r12, r13, r23)
    lower <- r12-r13-((r12-L1)^2+(U2-r13)^2-2*rho.r12.r13*(r12-L1)*(U2- r13))^0.5
    upper <- r12-r13+((U1-r12)^2+(r13-L2)^2-2*rho.r12.r13*(U1-r12)*(r13-L2))^0.5
    c(lower, upper)
} 

rz.ci <- function(r, N, conf.level = 0.95) {
    zr.se <- 1/(N - 3)^0.5
    moe <- qnorm(1 - (1 - conf.level)/2) * zr.se
    zu <- atanh(r) + moe
    zl <- atanh(r) - moe
    tanh(c(zl, zu))
}

# order by correlations
f <- paste("wmt15-data/wmt-r.",lp,".csv",sep="")
a <- read.table( f, header=T)
met.ord <- a[ order( -a$R), ]$METRIC

f <- paste("wmt15-data/hum-sys.",lp,".scores.csv",sep="")
metrics <- read.table( f, header=T)

sink(paste("wmt15-data/diff-dep/r-ci.",lp,".csv",sep=""))

cat(paste(" "))

for ( m2 in met.ord){
	cat(paste(" ",m2))
}
cat(paste("\n"))

for( m1 in met.ord ){
    
  met1 <- metrics[ which( metrics$METRIC==m1), ]
  scrs1 <- met1[ order(met1$SYSTEM), ]$SCORE
  
  cat(paste( m1))

  for( m2 in met.ord ){

    met2 <- metrics[ which( metrics$METRIC==m2), ]
    scrs2 <- met2[ order(met2$SYSTEM), ]$SCORE

    m1.h <- abs(cor( met1$SCORE, met1$HUMAN ) )
    m2.h <- abs(cor( met2$SCORE, met2$HUMAN ) )
    m1.m2 <- abs(cor( scrs1, scrs2 ) )
    
    samp.size <- length(met1$SCORE)

    if( m2.h<m1.h){
      lo = r.dol.ci(m1.h,m2.h,m1.m2,samp.size)[1]
      hi = r.dol.ci(m1.h,m2.h,m1.m2,samp.size)[2]
      cat(paste( " [", round(lo,3),",",round(hi,3),"]" ))
    }else{
     cat(paste(" -")) 
    }

  }
  cat(paste("\n"))

}

sink()

