# Question 4: How is forage yield associated with average temperature
# during the growing season?

forage_y1 <- read.csv("data/Isaacson_Year 1 Forage Yield.csv")
forage_y2 <- read.csv("data/Isaacson_Year 2 Forage Yield.csv")
temp_y1   <- read.csv("data/daily temp.2021.csv")
temp_y2   <- read.csv("data/daily temp.2022.csv")

# Date conversion that handles both 5/25/21 and 2022-05-25 formats
to_date <- function(x) {
  d <- as.Date(x, format = "%m/%d/%y")
  d[is.na(d)] <- as.Date(x[is.na(d)], format = "%Y-%m-%d")
  d
}

# ---- Yield: mean yield per harvest for each plot ----
y1 <- data.frame(
  plot  = forage_y1$Plot,
  year  = "Year 1",
  date  = to_date(forage_y1$Date),
  yield = forage_y1$alfalfa.g + forage_y1$ograss.g
)
y2 <- data.frame(
  plot  = forage_y2$Plot,
  year  = "Year 2",
  date  = to_date(forage_y2$Date),
  yield = forage_y2$alfalfa.g + forage_y2$ograss.g
)
yield_all <- rbind(y1, y2)
yield_all <- yield_all[!is.na(yield_all$yield), ]

plot_yield <- aggregate(yield ~ plot + year, data = yield_all, FUN = mean)

# Last harvest date in each year (end of the growing season window)
last_harvest <- tapply(yield_all$date, yield_all$year, max)

# ---- Temperature: mean daily temperature per plot ----
t1 <- data.frame(plot = temp_y1$plot, year = "Year 1",
                 date = to_date(temp_y1$Date), temp = temp_y1$dly.avg)
t2 <- data.frame(plot = temp_y2$plot, year = "Year 2",
                 date = to_date(temp_y2$Date), temp = temp_y2$dly.avg)
temp_all <- rbind(t1, t2)

# Keep days up to the last harvest of that year
temp_all <- temp_all[!is.na(temp_all$date) &
                       temp_all$date <= as.Date(last_harvest[temp_all$year],
                                                origin = "1970-01-01"), ]

plot_temp <- aggregate(temp ~ plot + year, data = temp_all, FUN = mean)

# ---- Merge by plot and year ----
q4_data <- merge(plot_yield, plot_temp, by = c("plot", "year"))

# Check how many plots matched in each year
table(plot_yield$year)   # plots with yield data
table(q4_data$year)      # plots with both yield and temperature

# ---- Exploratory plots ----
par(mfrow = c(1, 3))

hist(q4_data$yield, breaks = 15, col = "grey85",
     main = "Distribution of forage yield",
     xlab = "Mean yield per harvest (g per 0.5 m²)")
hist(q4_data$temp, breaks = 15, col = "tomato",
     main = "Distribution of average temperature",
     xlab = "Average daily temperature (°C)")

plot(q4_data$temp, q4_data$yield, pch = 16,
     col = ifelse(q4_data$year == "Year 1", "grey40", "steelblue"),
     xlab = "Average daily temperature (°C)",
     ylab = "Mean yield per harvest (g per 0.5 m²)",
     main = "Yield vs. average temperature")
legend("topright", pch = 16, col = c("grey40", "steelblue"),
       legend = c("Year 1", "Year 2"), bty = "n")

par(mfrow = c(1, 1))

# ---- Simple linear regression ----
fit4 <- lm(yield ~ temp, data = q4_data)
summary(fit4)

# Add the fitted line to the scatterplot
plot(q4_data$temp, q4_data$yield, pch = 16,
     xlab = "Average daily temperature (°C)",
     ylab = "Mean yield per harvest (g per 0.5 m²)",
     main = "Yield vs. average temperature")
abline(fit4, col = "tomato", lwd = 2)

# ---- Manual calculations (should match summary(fit4)) ----
x <- q4_data$temp
y <- q4_data$yield
n <- length(x)
xbar <- mean(x)
ybar <- mean(y)

Sxx <- sum((x - xbar)^2)
beta1_hat <- sum((x - xbar) * (y - ybar)) / Sxx
beta0_hat <- ybar - beta1_hat * xbar

yhat <- beta0_hat + beta1_hat * x
SSE  <- sum((y - yhat)^2)
MSE  <- SSE / (n - 2)
SEbeta1hat <- sqrt(MSE / Sxx)

t_stat  <- beta1_hat / SEbeta1hat
p_value <- 2 * pt(-abs(t_stat), df = n - 2)

c(beta0 = beta0_hat, beta1 = beta1_hat, SE_beta1 = SEbeta1hat,
  t = t_stat, p = p_value)

confint(fit4)