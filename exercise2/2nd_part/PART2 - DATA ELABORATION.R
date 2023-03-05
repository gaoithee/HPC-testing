
###########################################
# OBLAS SP CLOSE
###########################################

OBLAS.SP.CLOSE <- read.table("~/Scrivania/HPC/2ND PART/OBLAS-SP-CLOSE.dat", quote="\"", comment.char="")
OBLAS.SP.CLOSE <- OBLAS.SP.CLOSE[-c(3,5)]
N_CORES <- rep(1:64, each=10)
PRECISION <- rep("SP", each=64)
POLICY <- rep("CLOSE", each=64)
OBLAS.SP.CLOSE <- cbind(OBLAS.SP.CLOSE, N_CORES, PRECISION, POLICY)
colnames(OBLAS.SP.CLOSE) <- c("SIZE", "TIME", "GFLOPS", "N_CORES", "PRECISION", "POLICY")
OBLAS.SP.CLOSE

OBLAS.SP.CLOSE$N_CORES <- as.factor(OBLAS.SP.CLOSE$N_CORES)

library(plyr)

OBLAS.SP.CLOSE <- ddply(OBLAS.SP.CLOSE, .(N_CORES, PRECISION, POLICY), summarize, TIME = mean(TIME), GFLOPS = mean(GFLOPS))

# SPEEDUP PART
temp_TIME <- OBLAS.SP.CLOSE$TIME
temp_N_CORES <- as.numeric(OBLAS.SP.CLOSE$N_CORES)
SPEEDUP <- c()
EFFICIENCY <- c()

for(i in 1:64){
  SPEEDUP[i] <- temp_TIME[1]/temp_TIME[i]
  EFFICIENCY[i] <- SPEEDUP[i]/temp_N_CORES[i]
}

OBLAS.SP.CLOSE <- cbind(OBLAS.SP.CLOSE, SPEEDUP, EFFICIENCY)

###########################################
# OBLAS SP SPREAD
###########################################

OBLAS.SP.SPREAD <- read.table("~/Scrivania/HPC/2ND PART/OBLAS-SP-SPREAD.dat", quote="\"", comment.char="")
OBLAS.SP.SPREAD <- OBLAS.SP.SPREAD[-c(3,5)]
N_CORES <- rep(1:64, each=10)
PRECISION <- rep("SP", each=64)
POLICY <- rep("SPREAD", each=64)
OBLAS.SP.SPREAD <- cbind(OBLAS.SP.SPREAD, N_CORES, PRECISION, POLICY)
colnames(OBLAS.SP.SPREAD) <- c("SIZE", "TIME", "GFLOPS", "N_CORES", "PRECISION", "POLICY")
OBLAS.SP.SPREAD

OBLAS.SP.SPREAD$N_CORES <- as.factor(OBLAS.SP.SPREAD$N_CORES)

OBLAS.SP.SPREAD <- ddply(OBLAS.SP.SPREAD, .(N_CORES, PRECISION, POLICY), summarize, TIME = mean(TIME), GFLOPS = mean(GFLOPS))


# SPEEDUP PART
temp_TIME <- OBLAS.SP.SPREAD$TIME
temp_N_CORES <- as.numeric(OBLAS.SP.SPREAD$N_CORES)
SPEEDUP <- c()
EFFICIENCY <- c()

for(i in 1:64){
  SPEEDUP[i] <- temp_TIME[1]/temp_TIME[i]
  EFFICIENCY[i] <- SPEEDUP[i]/temp_N_CORES[i]
}

OBLAS.SP.SPREAD <- cbind(OBLAS.SP.SPREAD, SPEEDUP, EFFICIENCY)

###########################################
# OBLAS DP CLOSE
###########################################

OBLAS.DP.CLOSE <- read.table("~/Scrivania/HPC/2ND PART/OBLAS-DP-CLOSE.dat", quote="\"", comment.char="")
OBLAS.DP.CLOSE <- OBLAS.DP.CLOSE[-c(3,5)]
N_CORES <- rep(1:64, each=10)
PRECISION <- rep("DP", each=64)
POLICY <- rep("CLOSE", each=64)
OBLAS.DP.CLOSE <- cbind(OBLAS.DP.CLOSE, N_CORES, PRECISION, POLICY)
colnames(OBLAS.DP.CLOSE) <- c("SIZE", "TIME", "GFLOPS", "N_CORES", "PRECISION", "POLICY")
OBLAS.DP.CLOSE

OBLAS.DP.CLOSE$N_CORES <- as.factor(OBLAS.DP.CLOSE$N_CORES)

OBLAS.DP.CLOSE <- ddply(OBLAS.DP.CLOSE, .(N_CORES, PRECISION, POLICY), summarize, TIME = mean(TIME), GFLOPS = mean(GFLOPS))

# SPEEDUP PART
temp_TIME <- OBLAS.DP.CLOSE$TIME
temp_N_CORES <- as.numeric(OBLAS.DP.CLOSE$N_CORES)
SPEEDUP <- c()
EFFICIENCY <- c()

for(i in 1:64){
  SPEEDUP[i] <- temp_TIME[1]/temp_TIME[i]
  EFFICIENCY[i] <- SPEEDUP[i]/temp_N_CORES[i]
}

OBLAS.DP.CLOSE <- cbind(OBLAS.DP.CLOSE, SPEEDUP, EFFICIENCY)


###########################################
# OBLAS DP SPREAD
###########################################

OBLAS.DP.SPREAD <- read.table("~/Scrivania/HPC/2ND PART/OBLAS-DP-SPREAD.dat", quote="\"", comment.char="")
OBLAS.DP.SPREAD <- OBLAS.DP.SPREAD[-c(3,5)]
N_CORES <- rep(1:64, each=10)
PRECISION <- rep("DP", each=64)
POLICY <- rep("SPREAD", each=64)
OBLAS.DP.SPREAD <- cbind(OBLAS.DP.SPREAD, N_CORES, PRECISION, POLICY)
colnames(OBLAS.DP.SPREAD) <- c("SIZE", "TIME", "GFLOPS", "N_CORES", "PRECISION", "POLICY")
OBLAS.DP.SPREAD

OBLAS.DP.SPREAD$N_CORES <- as.factor(OBLAS.DP.SPREAD$N_CORES)

OBLAS.DP.SPREAD <- ddply(OBLAS.DP.SPREAD, .(N_CORES, PRECISION, POLICY), summarize, TIME = mean(TIME), GFLOPS = mean(GFLOPS))

# SPEEDUP PART
temp_TIME <- OBLAS.DP.SPREAD$TIME
temp_N_CORES <- as.numeric(OBLAS.DP.SPREAD$N_CORES)
SPEEDUP <- c()
EFFICIENCY <- c()

for(i in 1:64){
  SPEEDUP[i] <- temp_TIME[1]/temp_TIME[i]
  EFFICIENCY[i] <- SPEEDUP[i]/temp_N_CORES[i]
}

OBLAS.DP.SPREAD <- cbind(OBLAS.DP.SPREAD, SPEEDUP, EFFICIENCY)

###########################################
# MKL SP CLOSE
###########################################

MKL.SP.CLOSE <- read.table("~/Scrivania/HPC/2ND PART/MKL-SP-CLOSE.dat", quote="\"", comment.char="")
MKL.SP.CLOSE <- MKL.SP.CLOSE[-c(3,5)]
N_CORES <- rep(1:64, each=10)
PRECISION <- rep("SP", each=64)
POLICY <- rep("CLOSE", each=64)
MKL.SP.CLOSE <- cbind(MKL.SP.CLOSE, N_CORES, PRECISION, POLICY)
colnames(MKL.SP.CLOSE) <- c("SIZE", "TIME", "GFLOPS", "N_CORES", "PRECISION", "POLICY")
MKL.SP.CLOSE

MKL.SP.CLOSE$N_CORES <- as.factor(MKL.SP.CLOSE$N_CORES)

MKL.SP.CLOSE <- ddply(MKL.SP.CLOSE, .(N_CORES, PRECISION, POLICY), summarize, TIME = mean(TIME), GFLOPS = mean(GFLOPS))

# SPEEDUP PART
temp_TIME <- MKL.SP.CLOSE$TIME
temp_N_CORES <- as.numeric(MKL.SP.CLOSE$N_CORES)
SPEEDUP <- c()
EFFICIENCY <- c()

for(i in 1:64){
  SPEEDUP[i] <- temp_TIME[1]/temp_TIME[i]
  EFFICIENCY[i] <- SPEEDUP[i]/temp_N_CORES[i]
}

MKL.SP.CLOSE <- cbind(MKL.SP.CLOSE, SPEEDUP, EFFICIENCY)

###########################################
# MKL SP SPREAD
###########################################

MKL.SP.SPREAD <- read.table("~/Scrivania/HPC/2ND PART/MKL-SP-SPREAD.dat", quote="\"", comment.char="")
MKL.SP.SPREAD <- MKL.SP.SPREAD[-c(3,5)]
N_CORES <- rep(1:64, each=10)
PRECISION <- rep("SP", each=64)
POLICY <- rep("SPREAD", each=64)
MKL.SP.SPREAD <- cbind(MKL.SP.SPREAD, N_CORES, PRECISION, POLICY)
colnames(MKL.SP.SPREAD) <- c("SIZE", "TIME", "GFLOPS", "N_CORES", "PRECISION", "POLICY")
MKL.SP.SPREAD

MKL.SP.SPREAD$N_CORES <- as.factor(MKL.SP.SPREAD$N_CORES)

MKL.SP.SPREAD <- ddply(MKL.SP.SPREAD, .(N_CORES, PRECISION, POLICY), summarize, TIME = mean(TIME), GFLOPS = mean(GFLOPS))

# SPEEDUP PART
temp_TIME <- MKL.SP.SPREAD$TIME
temp_N_CORES <- as.numeric(MKL.SP.SPREAD$N_CORES)
SPEEDUP <- c()
EFFICIENCY <- c()

for(i in 1:64){
  SPEEDUP[i] <- temp_TIME[1]/temp_TIME[i]
  EFFICIENCY[i] <- SPEEDUP[i]/temp_N_CORES[i]
}

MKL.SP.SPREAD <- cbind(MKL.SP.SPREAD, SPEEDUP, EFFICIENCY)

###########################################
# MKL DP CLOSE
###########################################

MKL.DP.CLOSE <- read.table("~/Scrivania/HPC/2ND PART/MKL-DP-CLOSE.dat", quote="\"", comment.char="")
MKL.DP.CLOSE <- MKL.DP.CLOSE[-c(3,5)]
N_CORES <- rep(1:64, each=10)
PRECISION <- rep("DP", each=64)
POLICY <- rep("CLOSE", each=64)
MKL.DP.CLOSE <- cbind(MKL.DP.CLOSE, N_CORES, PRECISION, POLICY)
colnames(MKL.DP.CLOSE) <- c("SIZE", "TIME", "GFLOPS", "N_CORES", "PRECISION", "POLICY")
MKL.DP.CLOSE

MKL.DP.CLOSE$N_CORES <- as.factor(MKL.DP.CLOSE$N_CORES)

MKL.DP.CLOSE <- ddply(MKL.DP.CLOSE, .(N_CORES, PRECISION, POLICY), summarize, TIME = mean(TIME), GFLOPS = mean(GFLOPS))

# SPEEDUP PART
temp_TIME <- MKL.DP.CLOSE$TIME
temp_N_CORES <- as.numeric(MKL.DP.CLOSE$N_CORES)
SPEEDUP <- c()
EFFICIENCY <- c()

for(i in 1:64){
  SPEEDUP[i] <- temp_TIME[1]/temp_TIME[i]
  EFFICIENCY[i] <- SPEEDUP[i]/temp_N_CORES[i]
}

MKL.DP.CLOSE <- cbind(MKL.DP.CLOSE, SPEEDUP, EFFICIENCY)

###########################################
# MKL DP SPREAD
###########################################

MKL.DP.SPREAD <- read.table("~/Scrivania/HPC/2ND PART/MKL-DP-SPREAD.dat", quote="\"", comment.char="")
MKL.DP.SPREAD <- MKL.DP.SPREAD[-c(3,5)]
N_CORES <- rep(1:64, each=10)
PRECISION <- rep("DP", each=64)
POLICY <- rep("SPREAD", each=64)
MKL.DP.SPREAD <- cbind(MKL.DP.SPREAD, N_CORES, PRECISION, POLICY)
colnames(MKL.DP.SPREAD) <- c("SIZE", "TIME", "GFLOPS", "N_CORES", "PRECISION", "POLICY")
MKL.DP.SPREAD

MKL.DP.SPREAD$N_CORES <- as.factor(MKL.DP.SPREAD$N_CORES)

MKL.DP.SPREAD <- ddply(MKL.DP.SPREAD, .(N_CORES, PRECISION, POLICY), summarize, TIME = mean(TIME), GFLOPS = mean(GFLOPS))

# SPEEDUP PART
temp_TIME <- MKL.DP.SPREAD$TIME
temp_N_CORES <- as.numeric(MKL.DP.SPREAD$N_CORES)
SPEEDUP <- c()
EFFICIENCY <- c()

for(i in 1:64){
  SPEEDUP[i] <- temp_TIME[1]/temp_TIME[i]
  EFFICIENCY[i] <- SPEEDUP[i]/temp_N_CORES[i]
}

MKL.DP.SPREAD <- cbind(MKL.DP.SPREAD, SPEEDUP, EFFICIENCY)











#########################################
#   ALL IN ONE DATASET
#########################################

OBLAS_DATA <- rbind(OBLAS.SP.CLOSE, OBLAS.SP.SPREAD, OBLAS.DP.CLOSE, OBLAS.DP.SPREAD)
LIBRARY <- rep("OBLAS", each=256)
OBLAS_DATA <- cbind(OBLAS_DATA, LIBRARY)

MKL_DATA <- rbind(MKL.SP.CLOSE, MKL.SP.SPREAD, MKL.DP.CLOSE, MKL.DP.SPREAD)
LIBRARY <- rep("MKL", each=256)
MKL_DATA <- cbind(MKL_DATA, LIBRARY)

HPC_DATA_2 <- rbind(OBLAS_DATA, MKL_DATA)
write.table(HPC_DATA_2, file="HPC-DATA-4.dat", row.names = F, col.names = F)
