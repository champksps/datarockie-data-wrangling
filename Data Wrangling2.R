## load library
library(tidyverse)
library(jsonlite)
library(RSQLite)
library(RPostgreSQL)

# data wrangling
mtcars
head(mtcars)
tail(mtcars)
summary(mtcars)

# dplyr 
# 1. select column we want
mtcars %>% 
  select(mpg, hp, wt) %>%
  head(10)

mtcars %>%
  select(1, 3, 5, 10) %>%
  head(10)

mtcars %>%
  select(mpg, 3, hp, 10) %>%
  head(10)

mtcars %>% 
  select(starts_with("a"), ends_with("p"), contains("g")) %>%
  head(10)

# rename column
m <- mtcars %>%
  select(milePerGallon = mpg, 
         HorsePower = hp, 
         weight = wt) %>%
  head(10)
  
# 2. filter
# AND operator >> , & 
mtcars %>%
  select(milePerGallon = mpg, 
         HorsePower = hp, 
         weight = wt) %>%
  filter(HorsePower < 100, weight < 2)

# OR operator >> |
mtcars %>%
  select(milePerGallon = mpg, 
         HorsePower = hp, 
         weight = wt,
         transmission = am) %>%
  filter(HorsePower < 100 | weight < 2 | transmission == 1)

# row name to column
mtcars <- mtcars %>%
  rownames_to_column() %>%
  rename(model = rowname) %>%
  tibble()

# 3. arrange
mtcars %>%
  select(mpg, hp, wt) %>%
  arrange(desc(hp))

#4. mutate creat new columns
mtcars %>%
  select(mpg, hp, wt, am) %>%
  mutate(hp_edit = hp + 5,
         wt_double = wt * 2,
         am = if_else(am == 0, "Auto", "Manual")) %>%
  filter(am == "Auto")
# if use original name it will replace the original column

# 5.summarize data
mtcars %>%
  select(mpg, am) %>%
  mutate(am = if_else(am == 0, "Auto", "Manual")) %>%
  group_by(am) %>%
  summarise(mean_mpg = mean(mpg),
            sum_mpg = sum(mpg),
            sd_mpg = sd(mpg),
            min_mpg = min(mpg),
            max_mpg = max(mpg))

# pipe >> Data Pipeline
data %>% function %>% function2 %>% ...

# skimr
library(skimr)
mtcars <- mtcars %>%
  mutate(am = if_else(am == 0, "Auto", "Manual"))

mtcars %>%
  group_by(am) %>%
  skim()

mtcars %>%
  filter(hp < 150) %>%
  select(model, mpg, hp, wt, am) %>%
  group_by(am) %>%
  skim()






