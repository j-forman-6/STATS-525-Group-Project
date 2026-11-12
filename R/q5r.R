# Question 5: How is forage yield associated with precipitation
# during the growing season?
# Yield is dry biomass in grams per 0.5 m^2 (alfalfa + orchardgrass)

# Start of the growing season, used for the window before the first harvest
season_start <- "04-01"   # month-day; change if needed

forage_y1 <- read.csv("data/Isaacson_Year 1 Forage Yield.csv")
forage_y2 <- read.csv("data/Isaacson_Year 2 Forage Yield.csv")

# The weather files may capitalize column names differently,
# so find the date and precipitation columns by name pattern
read_precip <- function(f) {
  d <- read.csv(f)
  date_col   <- grep("^date$", names(d), ignore.case = TRUE)[1]
  precip_col <- grep("^precip", names(d), ignore.case = TRUE)[1]
  data.frame(Date = d[[date_col]], Precip.in = d[[precip_col]])
}
precip <- rbind(
  read_precip("data/2036_18_YEAR=2020.csv"),
  read_precip("data/2036_18_YEAR=2021.csv"),
  read_precip("data/2036_18_YEAR=2022.csv")
)

# Date conversion that handles 5/25/2021, 5/25/21, and 2021-05-25
to_date <- function(x) {
  d <- as.Date(x, format = "%m/%d/%Y")
  d[!is.na(d) & as.numeric(format(d, "%Y")) < 1900] <- NA
  miss <- is.na(d); d[miss] <- as.Date(x[miss], format = "%m/%d/%y")
  miss <- is.na(d); d[miss] <- as.Date(x[miss], format = "%Y-%m-%d")
  d
}

# ---- Precipitation: daily values ----
precip$date <- to_date(precip$Date)
precip$rain <- precip$Precip.in
precip$rain[precip$rain %in% c("T", "t")] <- 0        # trace amounts
precip$rain <- suppressWarnings(as.numeric(precip$rain))
precip <- precip[!is.na(precip$date), ]

# Check: days with missing precipitation, and the date range covered
sum(is.na(precip$rain))
range(precip$date)

# ---- Yield: one row per plot per harvest ----
y1 <- data.frame(year = 2021, date = to_date(forage_y1$Date),
                 yield = forage_y1$alfalfa.g + forage_y1$ograss.g)
y2 <- data.frame(year = 2022, date = to_date(forage_y2$Date),
                 yield = forage_y2$alfalfa.g + forage_y2$ograss.g)
yield_all <- rbind(y1, y2)
yield_all <- yield_all[!is.na(yield_all$yield), ]

# Mean yield at each harvest
harvests <- aggregate(yield ~ year + date, data = yield_all, FUN = mean)
harvests <- harvests[order(harvests$date), ]

# ---- Precipitation before each harvest ----
harvests$precip <- NA
for (i in seq_len(nrow(harvests))) {
  yr <- harvests$year[i]
  same_year <- harvests$date[harvests$year == yr]
  earlier   <- same_year[same_year < harvests$date[i]]
  
  start <- if (length(earlier) == 0) {
    as.Date(paste0(yr, "-", season_start))
  } else {
    max(earlier) + 1
  }
  
  in_window <- precip$date >= start & precip$date <= harvests$date[i]
  harvests$precip[i] <- sum(precip$rain[in_window], na.rm = TRUE)
}

harvests$year <- factor(paste("Year", harvests$year - 2020))
q5_data <- harvests

# Check: each harvest, its mean yield, and the rain before it
q5_data

# ---- Exploratory plots ----
par(mfrow = c(1, 3))

hist(yield_all$yield, breaks = 20, col = "grey85",
     main = "Distribution of forage yield",
     xlab = "Forage yield per plot (g per 0.5 m²)")
hist(q5_data$precip, breaks = 8, col = "skyblue",
     main = "Precipitation before each harvest",
     xlab = "Precipitation (in)")

plot(q5_data$precip, q5_data$yield, pch = 16, cex = 1.3,
     col = ifelse(q5_data$year == "Year 1", "grey40", "steelblue"),
     xlab = "Precipitation since previous harvest (in)",
     ylab = "Mean yield at harvest (g per 0.5 m²)",
     main = "Yield vs. precipitation")
legend("topright", pch = 16, col = c("grey40", "steelblue"),
       legend = c("Year 1", "Year 2"), bty = "n")

par(mfrow = c(1, 1))

# ---- Simple linear regression ----
fit5 <- lm(yield ~ precip, data = q5_data)
summary(fit5)

plot(q5_data$precip, q5_data$yield, pch = 16,
     xlab = "Precipitation since previous harvest (in)",
     ylab = "Mean yield at harvest (g per 0.5 m²)",
     main = "Yield vs. precipitation")
abline(fit5, col = "steelblue", lwd = 2)

# ---- Manual calculations (should match summary(fit5)) ----
x <- q5_data$precip
y <- q5_data$yield
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

confint(fit5)

