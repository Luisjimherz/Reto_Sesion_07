
# 1. Conectar con la base de datos shinydemo
install.packages("DBI")
install.packages("RMySQL")

library(DBI)
library(RMySQL)

db <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

# 2. Consulta con dplyr 

install.packages("dplyr")
library(dplyr)

dbListTables(db)
dbListFields(db, 'CountryLanguage')

df <- dbGetQuery(db, "select * from CountryLanguage")
View(DataDB)

query <- df %>% filter(Language == "Spanish")
df.query <- as.data.frame(query) 
View(df.query)

# 3. Grafica que en el eje de las Y aparezca el país y en X el porcentaje, 
#y que diferencíe entre aquellos que es su lengua oficial y los que no con 
#diferente color (puedes utilizar la geom_bin2d() y coord_flip())

install.packages("ggplot2")
library(ggplot2)

df.query %>% ggplot(aes( x = CountryCode, y=Percentage, fill = IsOfficial )) + 
  geom_bin2d() +
  coord_flip()

