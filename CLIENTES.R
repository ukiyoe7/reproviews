## VIEW CLIENTES

library(DBI)
library(dplyr)
library(readr)

con2 <- dbConnect(odbc::odbc(), "reproreplica")


cli <- dbGetQuery(con2, statement = read_file('SQL/CLIENTS.sql'))

View(cli)

inativos <- dbGetQuery(con2, statement = read_file('SQL/INATIVOS.sql'))

View(inativos)

clien <- anti_join(cli,inativos,by="CLICODIGO") 

View(clien)