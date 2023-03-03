data <- read.table("~/Scrivania/HPC/2ND PART/HPC-DATA-5.dat", quote="\"", comment.char="")

colnames(data) <- c("N_CORES", "PRECISION", "POLICY", "TIME", "GFLOPS", "SPEEDUP", "EFFICIENCY", "LIBRARY", "SYNTH")
data$LIBRARY <- as.factor(data$LIBRARY)

library(ggplot2)


# sp, al variare della dimensione della matrice, per OpenBLAS e MKL - POLICY: SPREAD

subset01 <- data[c(65:128, 321:384),]
plot01 <- ggplot(subset01, aes(x=N_CORES,y=SPEEDUP, color=LIBRARY)) + geom_line() + geom_point()
plot01 + ggtitle("Speedup comparison OpenBLAS and MKL on EPYC + Single Precision + SPREAD allocation policy") +
  xlab("Number of Cores") + ylab("SPEEDUP") + scale_y_continuous(breaks=seq(0,200,1)) + scale_x_continuous(breaks=seq(0,64,1))



# sp, al variare della dimensione della matrice, per OpenBLAS e MKL - POLICY: CLOSE
subset02 <- data[c(1:64, 257:320),]
plot02 <- ggplot(subset02, aes(x=N_CORES,y=SPEEDUP, color=LIBRARY)) + geom_line() + geom_point()
plot02 + ggtitle("Speedup comparison OpenBLAS and MKL on EPYC + Single Precision + CLOSE allocation policy") +
  xlab("Number of Cores") + ylab("SPEEDUP") + scale_y_continuous(breaks=seq(0,200,1)) + scale_x_continuous(breaks=seq(0,64,1))


# dp, al variare della dimensione della matrice, per OpenBLAS e MKL - POLICY: SPREAD
subset04 <- data[c(193:256, 449:512),]
plot04 <- ggplot(subset04, aes(x=N_CORES,y=SPEEDUP, color=LIBRARY)) + geom_line() + geom_point()
plot04 + ggtitle("Speedup comparison OpenBLAS and MKL on EPYC + Double Precision + SPREAD allocation policy") +
  xlab("Number of Cores") + ylab("SPEEDUP") + scale_y_continuous(breaks=seq(0,200,1)) + scale_x_continuous(breaks=seq(0,64,1))


# dp, al variare della dimensione della matrice, per OpenBLAS e MKL - POLICY: CLOSE
subset05 <- data[c(129:192, 385:448),]
plot05 <- ggplot(subset05, aes(x=N_CORES,y=SPEEDUP, color=LIBRARY)) + geom_line() + geom_point()
plot05 + ggtitle("Speedup comparison OpenBLAS and MKL on EPYC + Double Precision + CLOSE allocation policy") +
  xlab("Number of Cores") + ylab("SPEEDUP") + scale_y_continuous(breaks=seq(0,200,1)) + scale_x_continuous(breaks=seq(0,64,1))




# OpenBLAS on EPYC: SP+SPREAD vs SP+CLOSE vs DP+SPREAD vs DP+CLOSE
subset06 <- data[c(1:256),]

plot06 <- ggplot(subset06, aes(x=N_CORES,y=SPEEDUP, color=SYNTH)) + geom_line() + geom_point()
plot06 + ggtitle("OpenBLAS comparisons: different precisions and allocation policies") +
  xlab("Number of Cores") + ylab("SPEEDUP") + scale_y_continuous(breaks=seq(0,40,1)) + scale_x_continuous(breaks=seq(0,64,1))




# MKL on EPYC: SP+SPREAD vs SP+CLOSE vs DP+SPREAD vs DP+CLOSE
subset07 <- data[c(257:512),]

plot07 <- ggplot(subset07, aes(x=N_CORES,y=SPEEDUP, color=SYNTH)) + geom_line() + geom_point()
plot07 + ggtitle("MKL comparisons: different precisions and allocation policies") +
  xlab("Number of Cores") + ylab("SPEEDUP") + scale_y_continuous(breaks=seq(0,40,1)) + scale_x_continuous(breaks=seq(0,64,1))









