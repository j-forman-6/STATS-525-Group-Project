# Question 3: How does the temperature treatment affect forage yield
# at different points in the growing season?
# Treatment codes for Year 1 (from the data documentation):
# 1 = Control, 2 = Constant Warming, 3 = Fluctuating Warming

forage_y1 <- read.csv("data/Isaacson_Year 1 Forage Yield.csv")
forage_y2 <- read.csv("data/Isaacson_Year 2 Forage Yield.csv")

# Forage yield = alfalfa + orchardgrass
y1 <- data.frame(
  plot      = forage_y1$Plot,
  year      = "Year 1",
  date      = forage_y1$Date,
  treatment = c("Control", "Constant", "Fluctuating")[forage_y1$Trtno],
  yield     = forage_y1$alfalfa.g + forage_y1$ograss.g
)

# Year 2: use the text labels in Trt, not Trtno
y2 <- data.frame(
  plot      = forage_y2$Plot,
  year      = "Year 2",
  date      = forage_y2$Date,
  treatment = sub("[+-]weeds", "", forage_y2$Trt),
  yield     = forage_y2$alfalfa.g + forage_y2$ograss.g
)

q3_data <- rbind(y1, y2)

# Convert dates (handles both 5/25/21 and 2022-05-25 formats)
d <- as.Date(q3_data$date, format = "%m/%d/%y")
d[is.na(d)] <- as.Date(q3_data$date[is.na(d)], format = "%Y-%m-%d")
q3_data$date <- d

# Number the harvests in date order within each year
q3_data$harvest <- NA
for (yr in unique(q3_data$year)) {
  rows  <- q3_data$year == yr
  dates <- sort(unique(q3_data$date[rows]))
  q3_data$harvest[rows] <- match(q3_data$date[rows], dates)
}
q3_data$harvest <- factor(paste("Harvest", q3_data$harvest))

# Make the other predictors categorical
q3_data$treatment <- factor(q3_data$treatment,
                            levels = c("Control", "Constant", "Fluctuating"))
q3_data$year <- factor(q3_data$year)

# Drop rows with missing yield
q3_data <- q3_data[!is.na(q3_data$yield), ]

# Check: which dates became which harvest, and counts per combination
table(q3_data$date, q3_data$year, useNA = "ifany")
table(q3_data$treatment, q3_data$harvest, q3_data$year, useNA = "ifany")

# ---- Exploratory plots ----

# 1. Distributions of Y and each predictor
par(mfrow = c(2, 2))
hist(q3_data$yield, breaks = 20, col = "grey85",
     main = "Distribution of forage yield", xlab = "Forage yield (g per 0.5 m²)")
boxplot(q3_data$yield, horizontal = TRUE, col = "grey85",
        main = "Boxplot of forage yield", xlab = "Forage yield (g per 0.5 m²)")
barplot(table(q3_data$treatment), col = "steelblue",
        main = "Plots per treatment", ylab = "Count")
barplot(table(q3_data$harvest), col = "darkorange",
        main = "Plots per harvest", ylab = "Count")
par(mfrow = c(1, 1))

# 2. Y versus each categorical predictor
par(mfrow = c(1, 3))

boxplot(yield ~ treatment, data = q3_data, col = "grey85",
        main = "Yield by treatment", xlab = "", ylab = "Forage yield (g per 0.5 m²)")
stripchart(yield ~ treatment, data = q3_data, vertical = TRUE,
           method = "jitter", pch = 16, cex = 0.6,
           col = adjustcolor("steelblue", 0.6), add = TRUE)

boxplot(yield ~ harvest, data = q3_data, col = "grey85",
        main = "Yield by harvest", xlab = "", ylab = "Forage yield (g per 0.5 m²)")
stripchart(yield ~ harvest, data = q3_data, vertical = TRUE,
           method = "jitter", pch = 16, cex = 0.6,
           col = adjustcolor("darkorange", 0.6), add = TRUE)

n_harv <- nlevels(q3_data$harvest)
harv_cols <- hcl.colors(n_harv, "Oranges")
boxplot(yield ~ treatment + harvest, data = q3_data,
        col = rep(harv_cols, each = 3),
        names = rep(levels(q3_data$treatment), n_harv), las = 2,
        main = "Yield by treatment and harvest", xlab = "",
        ylab = "Forage yield (g per 0.5 m²)")
legend("topright", fill = harv_cols,
       legend = levels(q3_data$harvest), bty = "n")

par(mfrow = c(1, 1))

# ---- Model ----
# treatment * harvest answers the question; year accounts for year differences
fit3 <- lm(yield ~ treatment * harvest + year, data = q3_data)

anova(fit3)    # the treatment:harvest row tests whether the effect changes over the season
summary(fit3)

# Mean yield for each treatment at each harvest
tapply(q3_data$yield, list(q3_data$treatment, q3_data$harvest), mean)

# Interaction plot: non-parallel lines suggest the effect changes over the season
interaction.plot(q3_data$harvest, q3_data$treatment, q3_data$yield,
                 xlab = "Harvest", ylab = "Mean forage yield (g per 0.5 m²)",
                 trace.label = "Treatment")

confint(fit3)