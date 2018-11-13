#### The following code creates duplicates of rows of a data frame (df), conditionally based on values in one column (y).
#### In this case, creates 3 duplicates when values in column 'y' = 1.


df <- as.data.frame(cbind(y = c(1,2,3), x = c(4,5,6)))

df
#   y x
# 1 1 4
# 2 2 5
# 3 3 6

df2 <- df[rep(which(df$y == "1"), 3),]
# df$y == "1"  : rows where y = 1
# which(df$y == "1")  : indexes the row numbers where y = 1
# rep(which(df$y == "1"), 3)  : repeats the row numbers where y = 1, 3 times
# df[rep(which(df$y == "1"), 3),]  : returns rows of data frame where y=1, duplicated 3 times

df2
#     y x
# 1   1 4
# 1.1 1 4
# 1.2 1 4

#### to include all rows in original data frame, including duplicates:

df3 <- rbind(df[rep(which(df$y == "1") ,3),], df[df$y != "1",])
# df[df$y != "1",]  : returns rows of data frame where y is not 1

df3
#     y x
# 1   1 4
# 1.1 1 4
# 1.2 1 4
# 2   2 5
# 3   3 6
