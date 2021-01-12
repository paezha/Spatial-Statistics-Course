den_envelopes <- function(x = ppp, nsim = nsim){
  W <- x$window
  n <- x$n
  xden <- density(x)
  sim.ppp <- runifpoint(n = n, W = W, nsim = nsim)
  sim_den <- lapply(sim.ppp, FUN = density)
  den_env <- array(data = NA, dim = c(ncol(sim_den[[1]]$v), nrow(sim_den[[1]]$v), nsim))
  for(s in 1:nsim){
    den_env[,,s] <- sim_den[[s]]$v
  }
  max_env <- matrix(data = NA, nrow = nrow(den_env), ncol = ncol(den_env))
  min_env <- matrix(data = NA, nrow = nrow(den_env), ncol = ncol(den_env))
  for(i in 1:nrow(den_env)){
    for(j in 1:ncol(den_env)){
      max_env[i,j] <- max(den_env[i,j,])
      min_env[i,j] <- min(den_env[i,j,])
    }
  }
  max_env <- as.im(max_env, W = W)
  min_env <- as.im(min_env, W = W)
  max_env <- xden$v >= max_env
  min_env <- xden$v <= min_env
  as.imlist(list(Max = max_env, Min = min_env))
}