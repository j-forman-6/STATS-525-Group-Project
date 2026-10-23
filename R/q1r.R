temp1 = read.table("C:/Users/natal/OneDrive/Documents/Stats Project/STATS-525-Group-Project/data/Isaacson_Year 1 Forage Yield.csv", header = FALSE, col.names = c("y", "x"))
x <- temp1$x
y <- temp1$y
beta1_hat <- sum( (x - mean(x))*(y - mean(y)) ) / sum( (x - mean(x))^2 )
beta0_hat <- mean(y) - beta1_hat*mean(x)
xbar = mean(x)
ybar = mean(y)
yhat = beta0_hat + beta1_hat * x
SSE = sum((y - yhat)^2)
xvalues = temp1$x
n = length(xvalues)
MSE = SSE / (n - 2)
Sxx = sum((x - xbar)^2)
SEbeta1hat = sqrt(MSE / Sxx)



