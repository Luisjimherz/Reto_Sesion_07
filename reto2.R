
# 1. Extraer la tabla del HTML

url<- "https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm"

file<-read_html(url)
tables <- html_nodes(file, "table")
table1 <- html_table(tables[1], fill = TRUE)
(df <- as.data.frame(table1))
View(df)

# 2. Quitar caracteres innecesarios
? gsub
clean <- gsub("MXN","",df$Sueldo)
clean <- gsub("[^[:alnum:][:blank:]?]", "", clean)
clean <- gsub("mes", "", clean)

# 3. Asignar la colimna como tipo numerico
(df$Sueldo <- as.numeric(clean))

# ¿Quien paga mas?
max.value <-  which.max(df$Sueldo)
df[max.value,]

# ¿Quien paga menos?
min.value<- which.min(df$Sueldo)
df[min.value,]

