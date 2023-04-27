
library(DBI)
library(tidyverse)
library(readr)
library(googledrive)

con2 <- dbConnect(odbc::odbc(), "reproreplica")

## QUERIES

pedidos <- dbGetQuery(con2, statement = read_file('SQL/PEDIDOS.sql'))

promo <- dbGetQuery(con2, statement = read_file('SQL/PROMO.sql'))

## PROMO 

pedid_promo <-  
  left_join(pedidos,promo,by="ID_PEDIDO")  %>% arrange(desc(ID_PEDIDO))

View(pedid_promo)

## VIEW

View(pedidos)


## FILTERS

pedidos2 <- 
  pedidos %>% 
  mutate(CHAVE=str_trim(CHAVE)) %>% 
  filter(CLICODIGO==4571) %>% 
  filter(PROTIPO=='M') %>% 
  filter(VENDA=='1') %>% 
  filter(CHAVE!='SEPAS') %>% 
  arrange(desc(VRVENDA))

View(pedidos2)

## GOOGLESHEETS  

sheet_write(pedidos2 ,ss="1pIm-fjwOMW4RdILrXXa1y3AMNcl2FtOFOyagFHY9sSk",sheet="EXTRATO")


## EXCEL

write.csv2(pedidos,file = "pedidos.csv")
