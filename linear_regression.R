# build linear regression model
model <-  lm(mpg ~ hp + wt, data = mtcars)
print(model)