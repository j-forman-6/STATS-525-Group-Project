# Question 2: How does the effect of temperature treatment on forage yield
# differ between weedy and weed-free plots?
# Treatment codes (from the data documentation):
# 1 = Control, 2 = Constant Warming, 3 = Fluctuating Warming

forage_y1 <- read.csv("data/Isaacson_Year 1 Forage Yield.csv")
forage_y2 <- read.csv("data/Isaacson_Year 2 Forage Yield.csv")

# Forage yield = alfalfa + orchardgrass (chickweed is the weed, so it's excluded)
y1 <- data.frame(
  plot      = forage_y1$Plot,
  year      = "Year 1",
  treatment = c("Control", "Constant", "Fluctuating")[forage_y1$Trtno],
  weedy     = forage_y1$Weedy,
  yield     = forage_y1$alfalfa.g + forage_y1$ograss.g
)

y2 <- data.frame(
  plot      = forage_y2$Plot,
  year      = "Year 2",
  treatment = sub("[+-]weeds", "", forage_y2$Trt),
  weedy     = forage_y2$Weedy,
  yield     = forage_y2$alfalfa.g + forage_y2$ograss.g
)

q2_data <- rbind(y1, y2)

# Make the predictors categorical (Weedy: 0 = no chickweed, 1 = chickweed)
q2_data$treatment <- factor(q2_data$treatment,
                            levels = c("Control", "Constant", "Fluctuating"))
q2_data$weedy <- factor(q2_data$weedy, levels = c(0, 1),
                        labels = c("Weed-free", "Weedy"))
q2_data$year <- factor(q2_data$year)

# Drop rows with missing yield
q2_data <- q2_data[!is.na(q2_data$yield), ]

# Check the design: counts in each combination, no NAs
table(q2_data$treatment, q2_data$weedy, useNA = "ifany")
table(q2_data$treatment, q2_data$weedy, q2_data$year)

# ---- Exploratory plots ----

# 1. Distributions of Y and each predictor
par(mfrow = c(2, 2))
hist(q2_data$yield, breaks = 20, col = "grey85",
     main = "Distribution of forage yield", xlab = "Forage yield (g per 0.5 m²)")
boxplot(q2_data$yield, horizontal = TRUE, col = "grey85",
        main = "Boxplot of forage yield", xlab = "Forage yield (g per 0.5 m²)")
barplot(table(q2_data$treatment), col = "steelblue",
        main = "Plots per treatment", ylab = "Count")
barplot(table(q2_data$weedy), col = "darkolivegreen3",
        main = "Plots per weed status", ylab = "Count")
par(mfrow = c(1, 1))

# 2. Y versus each categorical predictor
par(mfrow = c(1, 3))

boxplot(yield ~ treatment, data = q2_data, col = "grey85",
        main = "Yield by treatment", xlab = "", ylab = "Forage yield (g per 0.5 m²)")
stripchart(yield ~ treatment, data = q2_data, vertical = TRUE,
           method = "jitter", pch = 16, cex = 0.6,
           col = adjustcolor("steelblue", 0.6), add = TRUE)

boxplot(yield ~ weedy, data = q2_data, col = "grey85",
        main = "Yield by weed status", xlab = "", ylab = "Forage yield (g per 0.5 m²)")
stripchart(yield ~ weedy, data = q2_data, vertical = TRUE,
           method = "jitter", pch = 16, cex = 0.6,
           col = adjustcolor("darkolivegreen4", 0.6), add = TRUE)

boxplot(yield ~ treatment + weedy, data = q2_data,
        col = rep(c("grey85", "darkolivegreen3"), each = 3),
        names = rep(levels(q2_data$treatment), 2), las = 2,
        main = "Yield by treatment and weed status", xlab = "",
        ylab = "Forage yield (g per 0.5 m²)")
legend("topright", fill = c("grey85", "darkolivegreen3"),
       legend = levels(q2_data$weedy), bty = "n")

par(mfrow = c(1, 1))

# ---- Model ----
# treatment * weedy answers the question; year accounts for year differences.
# A full three-way model isn't possible because Year 2 has no
# weed-free Fluctuating plots.
fit2 <- lm(yield ~ treatment * weedy + year, data = q2_data)

anova(fit2)    # the treatment:weedy row tests whether the effect differs by weed status
summary(fit2)

# Mean yield for each treatment in weedy and weed-free plots
tapply(q2_data$yield, list(q2_data$treatment, q2_data$weedy), mean)

# Interaction plot: non-parallel lines suggest the effect differs by weed status
interaction.plot(q2_data$treatment, q2_data$weedy, q2_data$yield,
                 xlab = "Temperature treatment", ylab = "Mean forage yield (g per 0.5 m²)",
                 trace.label = "Weeds")

confint(fit2)