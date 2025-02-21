prep_shark = prepData(greenies,
                      coordNames = NULL,  
                      covNames = c("depth", "temp", "TSR", "hour"))


# 4 state - ds = ODBA / no covariates
nbState <- 4
# define distribution to use for each data stream
dist <- list(ODBA = "gamma", pitch = "norm" )



# Setting up the starting values
ODBA_mu0 <-  rep(c(0.5, 0.6, 0.4, 1.5))
ODBA_sd0 <- rep(c(0.1, 0.1, 0.1, 0.2))
pitch_mu0 <- c(-20, 20, 0, 0)
pitch_sd0 <- c(10, 10, 10, 20)
# combine starting parameters 
Par0 <- list(ODBA = c(ODBA_mu0, ODBA_sd0),
             pitch = c(pitch_mu0, pitch_sd0))

set.seed(1)
all.fit1 <- fitHMM(prep_shark, 
                   nbState = nbState,
                   dist = dist, 
                   Par0 = Par0)

# plot HMM output
plot(all.fit1, breaks = 100, ask = F)
plotPR(all.fit1)
greenies$States<-as.factor(viterbi(all.fit1))