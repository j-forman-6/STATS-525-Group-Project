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
t
y1$treatment <- c("Control", "Constant", "Fluctuating")[y1$treatment]
y2$treatment <- sub("[+-]weeds", "", y2$treatment)

# Stacked them into one table
q1_data <- rbind(y1, y2)



# I left your line in case you wanted to take a look
# temp1 = read.table("C:/Users/natal/OneDrive/Documents/Stats Project/STATS-525-Group-Project/data/Isaacson_Year 1 Forage Yield.csv", header = FALSE, col.names = c("y", "x"))
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



