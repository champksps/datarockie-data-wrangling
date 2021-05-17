library(dplyr)
library(tidyverse)

mtcars <- mtcars %>%
            rownames_to_column() %>%
            rename(model = rowname) %>%
            tibble()
            

mtcars %>%
  filter(hp > 200) %>%
  select(model,
         milePerGallon = mpg,
         horsePower = hp,
         weight = wt,
         transmission = am,
         speedGear = gear)
