"
I Switched the file path from absolute to relative so we can open it as well
The data file has a header row and 11 columns, so read.table with header = 
FALSE wont work correctly and col doesnt work here because you need a label for 
every column as well as it wouldnt give you the columns you wanted

"
# For question 1 i am combining the data into one table over both years
# For the plots

forage_y1 <- read.csv("data/Isaacson_Year 1 Forage Yield.csv")
forage_y2 <- read.csv("data/Isaacson_Year 2 Forage Yield.csv")

y1 <- data.frame(
  plot      = forage_y1$Plot,
  date      = forage_y1$Date,
  year      = "Year 1",
  treatment = forage_y1$Trtno,     
  weedy     = forage_y1$Weedy,
  yield     = forage_y1$alfalfa.g + forage_y1$ograss.g
)

y2 <- data.frame(
  plot      = forage_y2$Plot,
  date      = forage_y2$Date,
  year      = "Year 2",
  treatment = forage_y2$Trt,       
  weedy     = forage_y2$Weedy,
  yield     = forage_y2$alfalfa.g + forage_y2$ograss.g
)

# Year 1 uses codes for treatments, so we are mapping them.
y1$treatment <- c("Control", "Constant", "Fluctuating")[forage_y1$Trtno]
# Year 2 has +/- weeds, so we are stripping them.
y2$treatment <- sub("[+-]weeds", "", y2$treatment)

# Stacked them into one table
q1_data <- rbind(y1, y2)


q1_data$treatment <- factor(q1_data$treatment, levels = c("Control", "Constant", "Fluctuating"))
q1_data$year <- factor(q1_data$year)

table(q1_data$treatment, q1_data$year, useNA = "ifany")

# Two-way model: treatment, year, and their interaction
fit <- lm(yield ~ treatment * year, data = q1_data)

anova(fit)    
summary(fit)


q1_plot <- q1_data[!is.na(q1_data$yield), ]

# ---- 1. Distributions of Y and each predictor ----
par(mfrow = c(2, 2))

# Y: histogram and boxplot of forage yield
hist(q1_plot$yield, breaks = 20, col = "grey85",
     main = "Distribution of forage yield", xlab = "Forage yield (g)")
boxplot(q1_plot$yield, horizontal = TRUE, col = "grey85",
        main = "Boxplot of forage yield", xlab = "Forage yield (g)")

# Categorical predictors: bar charts of how many plots are in each group
barplot(table(q1_plot$treatment), col = "steelblue",
        main = "Plots per treatment", ylab = "Count")
barplot(table(q1_plot$year), col = "steelblue",
        main = "Plots per year", ylab = "Count")

par(mfrow = c(1, 1))

# ---- 2. Y versus each categorical predictor ----
par(mfrow = c(1, 3))

# Yield by treatment, with individual points on top
boxplot(yield ~ treatment, data = q1_plot, col = "grey85",
        main = "Yield by treatment", xlab = "", ylab = "Forage yield (g)")
stripchart(yield ~ treatment, data = q1_plot, vertical = TRUE,
           method = "jitter", pch = 16, cex = 0.6,
           col = adjustcolor("steelblue", 0.6), add = TRUE)

# Yield by year
boxplot(yield ~ year, data = q1_plot, col = "grey85",
        main = "Yield by year", xlab = "", ylab = "Forage yield (g)")
stripchart(yield ~ year, data = q1_plot, vertical = TRUE,
           method = "jitter", pch = 16, cex = 0.6,
           col = adjustcolor("steelblue", 0.6), add = TRUE)

# Yield by treatment within each year (both predictors together)
boxplot(yield ~ treatment + year, data = q1_plot,
        col = rep(c("grey85", "steelblue"), each = 3),
        names = rep(levels(q1_plot$treatment), 2), las = 2,
        main = "Yield by treatment and year", xlab = "",
        ylab = "Forage yield (g)")
legend("topright", fill = c("grey85", "steelblue"),
       legend = levels(q1_plot$year), bty = "n")

par(mfrow = c(1, 1))

interaction.plot(q1_data$treatment, q1_data$year, q1_data$yield,
                 xlab = "Temperature treatment", ylab = "Mean forage yield (g)",
                 trace.label = "Year")
"
I don't know what these do, to be honest. 

x <- forage_y1$x
y <- forage_y1$y
beta1_hat <- sum( (x - mean(x))*(y - mean(y)) ) / sum( (x - mean(x))^2 )
beta0_hat <- mean(y) - beta1_hat*mean(x)
xbar = mean(x)
ybar = mean(y)
yhat = beta0_hat + beta1_hat * x
SSE = sum((y - yhat)^2)
xvalues = forage_y1$x
n = length(xvalues)
MSE = SSE / (n - 2)
Sxx = sum((x - xbar)^2)
SEbeta1hat = sqrt(MSE / Sxx)
"


