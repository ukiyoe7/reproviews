

## VIEW CLIENTES

library(DBI)
library(dplyr)
library(readr)

con2 <- dbConnect(odbc::odbc(), "reproreplica")


tabprecos <- dbGetQuery(con2, statement = read_file('SQL/TABPRECOS.sql'))

View(tabprecos)

