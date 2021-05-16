# load SQLite
library(RSQLite)

# see all files in directory
getwd()

# create connection between R and SQL database/file
conn <- dbConnect(SQLite(), "learn_sql/chinook.db")

###........ join tables ........###

query <- "
  select * from tracks
  join genres on tracks.genreid = genres.genreid"

result <- dbGetQuery(conn, query)

# clean column
library(janitor)

result <- result %>%
  clean_names() %>%
  tibble()

result %>%
  select(song_name = name, 
         composer, 
         genres = name_2) %>%
         count(genres) %>%
         arrange( desc(n)) %>%
         ggplot(., aes(genres, n)) +
         geom_col()

## alternative in SQL
dbGetQuery(conn, "SELECT 
                      B.name, 
                      COUNT(*) n 
                  FROM tracks A 
                  JOIN genres B 
                  ON A.genreid = B.genreid
                  GROUP BY B.name 
                  ORDER BY n DESC ")

# query data
dbListTables(conn)
dbListFields(conn, "customers")

usa_customers <- dbGetQuery(conn, "SELECT 
                        firstname, 
                        lastname,
                        email,
                        country
           FROM customers 
           WHERE country = 'USA' 
           LIMIT 10")

usa_customers %>%
  complete.cases()

# close connection when are done
dbDisconnect(conn)

###......................
### create new database
conn <- dbConnect(SQLite(),"learn_sql/shop.db")

dbListTables(conn)

locations <- data.frame(
  location_id = 1:5,
  location_city = c("London", 
                "Bangkok", 
                "New York", 
                "Tokyo", 
                "Soul")
)

locations_2 <- data.frame(
  location_id = 6:10,
  location_city = c("Norway", 
                    "Sweden", 
                    "Netherland", 
                    "Alaska", 
                    "Brazil")
)


# write tables to our db
dbWriteTable(conn, "locations", locations)
dbWriteTable(conn, "locations", locations_2, append = T) 
## append new data to original db

# see list of table
dbListTables(conn)

# query data
dbGetQuery(conn, "SELECT * FROM locations")
























