criterion.pattern <-
function(x,y,k=100){
N <- nrow(x)
v <- ncol(x)
V <- 1/ncol(x)
pat.comp <- x - apply(x,1,mean)
Xp <- apply(x,1,mean)
dv <- "y ~ 1"
pred <- colnames(x)
basic <- paste(pred,collapse="+",sep="")
form <- as.formula(paste(dv,"+",basic,sep=""))
regweg<- coef(lm(formula=form,data=as.data.frame(cbind(x,y))))
b <- regweg[-1]
bstar <- b - mean(b)
xc <- k*bstar
Covpc <- V*(as.matrix(pat.comp)%*%as.matrix(xc))
ypred <- fitted(lm(y ~ 1 + Covpc + Xp))
R2.f <- cor(ypred,y)^2
R2.pat <- cor(y,as.vector(Covpc))^2 ## pattern effect
R2.lvl <- cor(y,Xp)^2 ## level effect
r2 <- rbind(R2.f,R2.pat,R2.lvl)
colnames(r2) <- "R2"
rownames(r2) <- c("Full Model","Pattern","Level")
r2 <- round(r2,digits=6)

full.df <- c(v,N-v-1)
F.R2.full <- (R2.f*full.df[2])/((1-R2.f)*full.df[1])
p.value.F.R2.full <- pf(F.R2.full,full.df[1],full.df[2],lower.tail=FALSE)

pat.df <- c(v-1,N-v-1)
F.R2.pat <- ((R2.f - R2.lvl)*pat.df[2])/((1-R2.f)*pat.df[1])
p.value.F.R2.pat <- pf(F.R2.pat,pat.df[1],pat.df[2],lower.tail = FALSE)

lvl.df<-c(1,N-v-1)
F.R2.lvl <- ((R2.f - R2.pat)*lvl.df[2])/((1-R2.f))
p.value.F.R2.lvl <- pf(F.R2.lvl,lvl.df[1],lvl.df[2],lower.tail=FALSE)

F.R2.pat.only <- ((R2.pat)*pat.df[2])/((1-R2.pat)*pat.df[1])
p.value.F.R2.pat.only <- pf(F.R2.pat.only,pat.df[1],pat.df[2],lower.tail = FALSE)

F.R2.lvl.only <- ((R2.lvl)*lvl.df[2])/((1-R2.lvl)*lvl.df[1])
p.value.F.R2.lvl.only <- pf(F.R2.lvl.only,lvl.df[1],lvl.df[2],lower.tail = FALSE)

F.table <- c(F.R2.full,F.R2.pat.only,F.R2.lvl.only,F.R2.pat,F.R2.lvl)
F.table <-as.data.frame(F.table)
colnames(F.table) <- "F.statistic"
F.table$df <- rbind(full.df,pat.df,lvl.df,pat.df,lvl.df)
F.table$pvalue <- rbind(p.value.F.R2.full,p.value.F.R2.pat.only,p.value.F.R2.lvl.only,p.value.F.R2.pat,p.value.F.R2.lvl)
rownames(F.table) <- c("R2full = 0 ","R2pat = 0","R2lvl = 0","R2full = R2lvl","R2full = R2pat")
F.table <- round(F.table,digits=6)

output <- list(lvl.comp=Xp,pat.comp=pat.comp,b=regweg,bstar=bstar, xc=xc, k=k, Covpc=Covpc, Ypred=ypred,r2=r2,F.table=F.table)

class(output) <- "critpat"
return(output)
}
