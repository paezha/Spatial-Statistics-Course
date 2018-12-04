function(source_xy, z, target_xy, k, longlat = FALSE){
  for(i in 1:nrow(target_xy)){
    x = rbind(source_xy, target_xy[i,1:2])
    knn <- knearneigh(x = as.matrix(x), k = k, longlat = longlat)
    target_xy$z[i] <- mean(z[knn$nn[nrow(x),]])
    target_xy$sd[i] <- sd(z[knn$nn[nrow(x),]])
  }
  target_xy
}
