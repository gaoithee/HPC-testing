library(ggplot2)
data <- read.delim2("DATA-HPC.dat")
data
summary(data)
is.numeric(data$GFLOPS)

# sp, al variare della dimensione della matrice, per OpenBLAS e MKL
subset1 <- data[c(1:19),]
subset2 <- data[c(39:57),]

plot(subset1$DIM, subset1$GFLOPS, type="o", col="blue", pch="o", ylab="y", lty=1, ylim = c(0, 3000))
points(subset2$DIM, subset2$GFLOPS, col="red", pch="*")
lines(subset2$DIM, subset2$GFLOPS, col="red")

#with ggplot2
subset01 <- data[c(1:19, 39:57),]
plot01 <- ggplot(subset01, aes(x=DIM,y=GFLOPS, color=LIBRARY)) + geom_line() + geom_point()
plot01 + ggtitle("Comparison OpenBLAS and MKL on EPYC + Single Precision + SPREAD allocation policy") +
  xlab("Matrix Size") + ylab("GFLOPS") + scale_y_continuous(breaks=seq(0,3000,200)) + scale_x_continuous(breaks=seq(0,20000,1000))


# dp, al variare della dimensione della matrice, per OpenBLAS e MKL
subset3 <- data[c(20:38),]
subset4 <- data[c(58:76),]

plot(subset3$DIM, subset3$GFLOPS, type="o", col="blue", pch="o", ylab="y", lty=1)
points(subset4$DIM, subset4$GFLOPS, col="red", pch="*")
lines(subset4$DIM, subset4$GFLOPS, col="red")

#with ggplot2
subset02 <- data[c(20:38, 58:76),]
plot02 <- ggplot(subset02, aes(x=DIM,y=GFLOPS, color=LIBRARY)) + geom_line() + geom_point()
plot02 + ggtitle("Comparison OpenBLAS and MKL on EPYC + Double Precision + SPREAD allocation policy") +
  xlab("Matrix Size") + ylab("GFLOPS") + scale_y_continuous(breaks=seq(0,3000,200)) + scale_x_continuous(breaks=seq(0,20000,1000))



# sp, al variare della dimensione della matrice, per OpenBLAS e MKL - POLICY CLOSE
subset5 <- data[c(77:95),]
subset6 <- data[c(115:133),]

plot(subset5$DIM, subset5$GFLOPS, type="o", col="blue", pch="o", ylab="y", lty=1)
points(subset6$DIM, subset6$GFLOPS, col="red", pch="*")
lines(subset6$DIM, subset6$GFLOPS, col="red")

#with ggplot2
subset03 <- data[c(77:95, 115:133),]
plot03 <- ggplot(subset03, aes(x=DIM,y=GFLOPS, color=LIBRARY)) + geom_line() + geom_point()
plot03 + ggtitle("Comparison OpenBLAS and MKL on EPYC + Single Precision + CLOSE allocation policy") +
  xlab("Matrix Size") + ylab("GFLOPS") + scale_y_continuous(breaks=seq(0,3000,200)) + scale_x_continuous(breaks=seq(0,20000,1000))



# dp, al variare della dimensione della matrice, per OpenBLAS e MKL - POLICY CLOSE
subset7 <- data[c(96:114),]
subset8 <- data[c(134:152),]

plot(subset7$DIM, subset7$GFLOPS, type="o", col="blue", pch="o", ylab="y", lty=1)
points(subset8$DIM, subset8$GFLOPS, col="red", pch="*")
lines(subset8$DIM, subset8$GFLOPS, col="red")

#with ggplot2
subset04 <- data[c(96:114, 134:152),]
plot04 <- ggplot(subset04, aes(x=DIM,y=GFLOPS, color=LIBRARY)) + geom_line() + geom_point()
plot04 + ggtitle("Comparison OpenBLAS and MKL on EPYC + Double Precision + CLOSE allocation policy") +
  xlab("Matrix Size") + ylab("GFLOPS") + scale_y_continuous(breaks=seq(0,3000,200)) + scale_x_continuous(breaks=seq(0,20000,1000))




# GGPLOT2 COMPARISONS

# OpenBLAS on EPYC: SP+SPREAD vs SP+CLOSE vs DP+SPREAD vs DP+CLOSE
subset05 <- data[c(1:38, 77:114),]

plot05 <- ggplot(subset05, aes(x=DIM,y=GFLOPS, color=SYNTH)) + geom_line() + geom_point()
plot05 + ggtitle("OpenBLAS comparisons: different precisions and allocation policies") +
  xlab("Matrix Size") + ylab("GFLOPS") + scale_y_continuous(breaks=seq(0,3000,200)) + scale_x_continuous(breaks=seq(0,20000,1000))




# MKL on EPYC: SP+SPREAD vs SP+CLOSE vs DP+SPREAD vs DP+CLOSE
subset06 <- data[c(39:76, 115:152),]

plot06 <- ggplot(subset06, aes(x=DIM,y=GFLOPS, color=SYNTH)) + geom_line() + geom_point()
plot06 + ggtitle("MKL comparisons: different precisions and allocation policies") +
  xlab("Matrix Size") + ylab("GFLOPS") + scale_y_continuous(breaks=seq(0,3000,200)) + scale_x_continuous(breaks=seq(0,20000,1000))










