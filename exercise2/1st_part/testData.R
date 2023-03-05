
################################################################################
#         EPYC OBLAS SP SPREAD
################################################################################


EPYC.OBLAS.SP.SPREAD <- read.table("~/Scrivania/EPYC-OBLAS-SP-SPREAD.dat", quote="\"", comment.char="")

EPYC.OBLAS.SP.SPREAD <- EPYC.OBLAS.SP.SPREAD[-c(3,5)]
EPYC.OBLAS.SP.SPREAD$V4 <- as.numeric(EPYC.OBLAS.SP.SPREAD$V4, type="double")

dim(EPYC.OBLAS.SP.SPREAD)

  mean(EPYC.OBLAS.SP.SPREAD$V4[1:10])
  mean(EPYC.OBLAS.SP.SPREAD$V4[11:20])
  mean(EPYC.OBLAS.SP.SPREAD$V4[21:30])
  mean(EPYC.OBLAS.SP.SPREAD$V4[31:40])
  mean(EPYC.OBLAS.SP.SPREAD$V4[41:50])
  mean(EPYC.OBLAS.SP.SPREAD$V4[51:60])
  mean(EPYC.OBLAS.SP.SPREAD$V4[61:70])
  mean(EPYC.OBLAS.SP.SPREAD$V4[71:80])
  mean(EPYC.OBLAS.SP.SPREAD$V4[81:90])
  mean(EPYC.OBLAS.SP.SPREAD$V4[91:100])
  mean(EPYC.OBLAS.SP.SPREAD$V4[101:110])
  mean(EPYC.OBLAS.SP.SPREAD$V4[111:120])
  mean(EPYC.OBLAS.SP.SPREAD$V4[121:130])
  mean(EPYC.OBLAS.SP.SPREAD$V4[131:140])
  mean(EPYC.OBLAS.SP.SPREAD$V4[141:150])
  mean(EPYC.OBLAS.SP.SPREAD$V4[151:160])
  mean(EPYC.OBLAS.SP.SPREAD$V4[161:170])
  mean(EPYC.OBLAS.SP.SPREAD$V4[171:180])
  mean(EPYC.OBLAS.SP.SPREAD$V4[181:190])
  
  
  ################################################################################
  #         EPYC OBLAS DP SPREAD
  ################################################################################
  
  
  EPYC.OBLAS.DP.SPREAD <- read.table("~/Scrivania/EPYC-OBLAS-DP-SPREAD.dat", quote="\"", comment.char="")
  
  EPYC.OBLAS.DP.SPREAD <- EPYC.OBLAS.DP.SPREAD[-c(3,5)]
  EPYC.OBLAS.DP.SPREAD$V4 <- as.numeric(EPYC.OBLAS.DP.SPREAD$V4, type="double")
  
  dim(EPYC.OBLAS.DP.SPREAD)
  
  mean(EPYC.OBLAS.DP.SPREAD$V4[1:10])
  mean(EPYC.OBLAS.DP.SPREAD$V4[11:20])
  mean(EPYC.OBLAS.DP.SPREAD$V4[21:30])
  mean(EPYC.OBLAS.DP.SPREAD$V4[31:40])
  mean(EPYC.OBLAS.DP.SPREAD$V4[41:50])
  mean(EPYC.OBLAS.DP.SPREAD$V4[51:60])
  mean(EPYC.OBLAS.DP.SPREAD$V4[61:70])
  mean(EPYC.OBLAS.DP.SPREAD$V4[71:80])
  mean(EPYC.OBLAS.DP.SPREAD$V4[81:90])
  mean(EPYC.OBLAS.DP.SPREAD$V4[91:100])
  mean(EPYC.OBLAS.DP.SPREAD$V4[101:110])
  mean(EPYC.OBLAS.DP.SPREAD$V4[111:120])
  mean(EPYC.OBLAS.DP.SPREAD$V4[121:130])
  mean(EPYC.OBLAS.DP.SPREAD$V4[131:140])
  mean(EPYC.OBLAS.DP.SPREAD$V4[141:150])
  mean(EPYC.OBLAS.DP.SPREAD$V4[151:160])
  mean(EPYC.OBLAS.DP.SPREAD$V4[161:170])
  mean(EPYC.OBLAS.DP.SPREAD$V4[171:180])
  mean(EPYC.OBLAS.DP.SPREAD$V4[181:190])

  
  
  
  ################################################################################
  #         EPYC MKL SP SPREAD
  ################################################################################
  
  
  EPYC.MKL.SP.SPREAD <- read.table("~/Scrivania/EPYC-MKL-SP-SPREAD.dat", quote="\"", comment.char="")
  
  EPYC.MKL.SP.SPREAD <- EPYC.MKL.SP.SPREAD[-c(3,5)]
  EPYC.MKL.SP.SPREAD$V4 <- as.numeric(EPYC.MKL.SP.SPREAD$V4, type="double")
  
  dim(EPYC.MKL.SP.SPREAD)
  
  mean(EPYC.MKL.SP.SPREAD$V4[1:10])
  mean(EPYC.MKL.SP.SPREAD$V4[11:20])
  mean(EPYC.MKL.SP.SPREAD$V4[21:30])
  mean(EPYC.MKL.SP.SPREAD$V4[31:40])
  mean(EPYC.MKL.SP.SPREAD$V4[41:50])
  mean(EPYC.MKL.SP.SPREAD$V4[51:60])
  mean(EPYC.MKL.SP.SPREAD$V4[61:70])
  mean(EPYC.MKL.SP.SPREAD$V4[71:80])
  mean(EPYC.MKL.SP.SPREAD$V4[81:90])
  mean(EPYC.MKL.SP.SPREAD$V4[91:100])
  mean(EPYC.MKL.SP.SPREAD$V4[101:110])
  mean(EPYC.MKL.SP.SPREAD$V4[111:120])
  mean(EPYC.MKL.SP.SPREAD$V4[121:130])
  mean(EPYC.MKL.SP.SPREAD$V4[131:140])
  mean(EPYC.MKL.SP.SPREAD$V4[141:150])
  mean(EPYC.MKL.SP.SPREAD$V4[151:160])
  mean(EPYC.MKL.SP.SPREAD$V4[161:170])
  mean(EPYC.MKL.SP.SPREAD$V4[171:180])
  mean(EPYC.MKL.SP.SPREAD$V4[181:190])
  
  
  ################################################################################
  #         EPYC MKL DP SPREAD
  ################################################################################
  
  
  EPYC.MKL.DP.SPREAD <- read.table("~/Scrivania/HPC/EPYC-MKL-DP-SPREAD.dat", quote="\"", comment.char="")
  
  EPYC.MKL.DP.SPREAD <- EPYC.MKL.DP.SPREAD[-c(3,5)]
  EPYC.MKL.DP.SPREAD$V4 <- as.numeric(EPYC.MKL.DP.SPREAD$V4, type="double")
  
  dim(EPYC.MKL.DP.SPREAD)
  
  means <-c() 
  
 means <- c(means, mean(EPYC.MKL.DP.SPREAD$V4[1:10]),
              mean(EPYC.MKL.DP.SPREAD$V4[11:20]),
  mean(EPYC.MKL.DP.SPREAD$V4[21:30]),
  mean(EPYC.MKL.DP.SPREAD$V4[31:40]),
  mean(EPYC.MKL.DP.SPREAD$V4[41:50]),
  mean(EPYC.MKL.DP.SPREAD$V4[51:60]),
  mean(EPYC.MKL.DP.SPREAD$V4[61:70]),
  mean(EPYC.MKL.DP.SPREAD$V4[71:80]),
  mean(EPYC.MKL.DP.SPREAD$V4[81:90]),
  mean(EPYC.MKL.DP.SPREAD$V4[91:100]),
  mean(EPYC.MKL.DP.SPREAD$V4[101:110]),
  mean(EPYC.MKL.DP.SPREAD$V4[111:120]),
  mean(EPYC.MKL.DP.SPREAD$V4[121:130]),
  mean(EPYC.MKL.DP.SPREAD$V4[131:140]),
  mean(EPYC.MKL.DP.SPREAD$V4[141:150]),
  mean(EPYC.MKL.DP.SPREAD$V4[151:160]),
  mean(EPYC.MKL.DP.SPREAD$V4[161:170]),
  mean(EPYC.MKL.DP.SPREAD$V4[171:180]),
  mean(EPYC.MKL.DP.SPREAD$V4[181:190])
            ) 

  means
  
  
  
  ################################################################################
  #         EPYC OBLAS SP CLOSE
  ################################################################################
  
   EPYC.OBLAS.SP.CLOSE <- read.table("~/Scrivania/HPC/EPYC-OBLAS-SP-CLOSE.dat", quote="\"", comment.char="")
   
   EPYC.OBLAS.SP.CLOSE <- EPYC.OBLAS.SP.CLOSE[-c(3,5)]
   EPYC.OBLAS.SP.CLOSE$V4 <- as.numeric(EPYC.OBLAS.SP.CLOSE$V4, type="double")
   
   dim(EPYC.OBLAS.SP.CLOSE)
   
   means <-c() 
   
   means <- c(means, mean(EPYC.OBLAS.SP.CLOSE$V4[1:10]),
              mean(EPYC.OBLAS.SP.CLOSE$V4[11:20]),
              mean(EPYC.OBLAS.SP.CLOSE$V4[21:30]),
              mean(EPYC.OBLAS.SP.CLOSE$V4[31:40]),
              mean(EPYC.OBLAS.SP.CLOSE$V4[41:50]),
              mean(EPYC.OBLAS.SP.CLOSE$V4[51:60]),
              mean(EPYC.OBLAS.SP.CLOSE$V4[61:70]),
              mean(EPYC.OBLAS.SP.CLOSE$V4[71:80]),
              mean(EPYC.OBLAS.SP.CLOSE$V4[81:90]),
              mean(EPYC.OBLAS.SP.CLOSE$V4[91:100]),
              mean(EPYC.OBLAS.SP.CLOSE$V4[101:110]),
              mean(EPYC.OBLAS.SP.CLOSE$V4[111:120]),
              mean(EPYC.OBLAS.SP.CLOSE$V4[121:130]),
              mean(EPYC.OBLAS.SP.CLOSE$V4[131:140]),
              mean(EPYC.OBLAS.SP.CLOSE$V4[141:150]),
              mean(EPYC.OBLAS.SP.CLOSE$V4[151:160]),
              mean(EPYC.OBLAS.SP.CLOSE$V4[161:170]),
              mean(EPYC.OBLAS.SP.CLOSE$V4[171:180]),
              mean(EPYC.OBLAS.SP.CLOSE$V4[181:190]) ) 
  
  means
  
  
  
  ################################################################################
  #         EPYC OBLAS DP CLOSE
  ################################################################################
  
  EPYC.OBLAS.DP.CLOSE <- read.table("~/Scrivania/HPC/EPYC-OBLAS-DP-CLOSE.dat", quote="\"", comment.char="")
  
  EPYC.OBLAS.DP.CLOSE <- EPYC.OBLAS.DP.CLOSE[-c(3,5)]
  EPYC.OBLAS.DP.CLOSE$V4 <- as.numeric(EPYC.OBLAS.DP.CLOSE$V4, type="double")
  
  dim(EPYC.OBLAS.DP.CLOSE)
  
  means <-c() 
  
  means <- c(means, mean(EPYC.OBLAS.DP.CLOSE$V4[1:10]),
             mean(EPYC.OBLAS.DP.CLOSE$V4[11:20]),
             mean(EPYC.OBLAS.DP.CLOSE$V4[21:30]),
             mean(EPYC.OBLAS.DP.CLOSE$V4[31:40]),
             mean(EPYC.OBLAS.DP.CLOSE$V4[41:50]),
             mean(EPYC.OBLAS.DP.CLOSE$V4[51:60]),
             mean(EPYC.OBLAS.DP.CLOSE$V4[61:70]),
             mean(EPYC.OBLAS.DP.CLOSE$V4[71:80]),
             mean(EPYC.OBLAS.DP.CLOSE$V4[81:90]),
             mean(EPYC.OBLAS.DP.CLOSE$V4[91:100]),
             mean(EPYC.OBLAS.DP.CLOSE$V4[101:110]),
             mean(EPYC.OBLAS.DP.CLOSE$V4[111:120]),
             mean(EPYC.OBLAS.DP.CLOSE$V4[121:130]),
             mean(EPYC.OBLAS.DP.CLOSE$V4[131:140]),
             mean(EPYC.OBLAS.DP.CLOSE$V4[141:150]),
             mean(EPYC.OBLAS.DP.CLOSE$V4[151:160]),
             mean(EPYC.OBLAS.DP.CLOSE$V4[161:170]),
             mean(EPYC.OBLAS.DP.CLOSE$V4[171:180]),
             mean(EPYC.OBLAS.DP.CLOSE$V4[181:190]) ) 
  
  means
  
  ################################################################################
  #         EPYC MKL SP CLOSE
  ################################################################################
  
  
  EPYC.MKL.SP.CLOSE <- read.table("~/Scrivania/HPC/EPYC-MKL-SP-CLOSE.dat", quote="\"", comment.char="")
  
  EPYC.MKL.SP.CLOSE <- EPYC.MKL.SP.CLOSE[-c(3,5)]
  EPYC.MKL.SP.CLOSE$V4 <- as.numeric(EPYC.MKL.SP.CLOSE$V4, type="double")
  
  dim(EPYC.MKL.SP.CLOSE)
  
  means <-c() 
  
  means <- c(means, mean(EPYC.MKL.SP.CLOSE$V4[1:10]),
             mean(EPYC.MKL.SP.CLOSE$V4[11:20]),
             mean(EPYC.MKL.SP.CLOSE$V4[21:30]),
             mean(EPYC.MKL.SP.CLOSE$V4[31:40]),
             mean(EPYC.MKL.SP.CLOSE$V4[41:50]),
             mean(EPYC.MKL.SP.CLOSE$V4[51:60]),
             mean(EPYC.MKL.SP.CLOSE$V4[61:70]),
             mean(EPYC.MKL.SP.CLOSE$V4[71:80]),
             mean(EPYC.MKL.SP.CLOSE$V4[81:90]),
             mean(EPYC.MKL.SP.CLOSE$V4[91:100]),
             mean(EPYC.MKL.SP.CLOSE$V4[101:110]),
             mean(EPYC.MKL.SP.CLOSE$V4[111:120]),
             mean(EPYC.MKL.SP.CLOSE$V4[121:130]),
             mean(EPYC.MKL.SP.CLOSE$V4[131:140]),
             mean(EPYC.MKL.SP.CLOSE$V4[141:150]),
             mean(EPYC.MKL.SP.CLOSE$V4[151:160]),
             mean(EPYC.MKL.SP.CLOSE$V4[161:170]),
             mean(EPYC.MKL.SP.CLOSE$V4[171:180]),
             mean(EPYC.MKL.SP.CLOSE$V4[181:190]) ) 
  
  means
  
  
  ################################################################################
  #         EPYC MKL DP CLOSE
  ################################################################################
  
  EPYC.MKL.DP.CLOSE <- read.table("~/Scrivania/HPC/EPYC-MKL-DP-CLOSE.dat", quote="\"", comment.char="")
  
  EPYC.MKL.DP.CLOSE <- EPYC.MKL.DP.CLOSE[-c(3,5)]
  EPYC.MKL.DP.CLOSE$V4 <- as.numeric(EPYC.MKL.DP.CLOSE$V4, type="double")
  
  dim(EPYC.MKL.DP.CLOSE)
  
  means <-c() 
  
  means <- c(means, mean(EPYC.MKL.DP.CLOSE$V4[1:10]),
             mean(EPYC.MKL.DP.CLOSE$V4[11:20]),
             mean(EPYC.MKL.DP.CLOSE$V4[21:30]),
             mean(EPYC.MKL.DP.CLOSE$V4[31:40]),
             mean(EPYC.MKL.DP.CLOSE$V4[41:50]),
             mean(EPYC.MKL.DP.CLOSE$V4[51:60]),
             mean(EPYC.MKL.DP.CLOSE$V4[61:70]),
             mean(EPYC.MKL.DP.CLOSE$V4[71:80]),
             mean(EPYC.MKL.DP.CLOSE$V4[81:90]),
             mean(EPYC.MKL.DP.CLOSE$V4[91:100]),
             mean(EPYC.MKL.DP.CLOSE$V4[101:110]),
             mean(EPYC.MKL.DP.CLOSE$V4[111:120]),
             mean(EPYC.MKL.DP.CLOSE$V4[121:130]),
             mean(EPYC.MKL.DP.CLOSE$V4[131:140]),
             mean(EPYC.MKL.DP.CLOSE$V4[141:150]),
             mean(EPYC.MKL.DP.CLOSE$V4[151:160]),
             mean(EPYC.MKL.DP.CLOSE$V4[161:170]),
             mean(EPYC.MKL.DP.CLOSE$V4[171:180]),
             mean(EPYC.MKL.DP.CLOSE$V4[181:190]) ) 
  
  means
  