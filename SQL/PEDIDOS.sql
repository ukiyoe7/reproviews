
WITH CLI AS (SELECT DISTINCT C.CLICODIGO,
                         CLINOMEFANT,
                          ENDCODIGO,
                           GCLCODIGO,
                           SETOR
                            FROM CLIEN C
                             LEFT JOIN (SELECT CLICODIGO,E.ZOCODIGO,ZODESCRICAO SETOR,ENDCODIGO FROM ENDCLI E
                              LEFT JOIN (SELECT ZOCODIGO,ZODESCRICAO FROM ZONA 
                              WHERE ZOCODIGO IN (20,21,22,23,24,25,26,27,28))Z ON 
                              E.ZOCODIGO=Z.ZOCODIGO WHERE ENDFAT='S')A ON C.CLICODIGO=A.CLICODIGO
                               WHERE CLICLIENTE='S'),
                               
                               
   FIS AS (SELECT FISCODIGO FROM TBFIS WHERE FISTPNATOP IN ('V','R','SR')),
    
    PED AS (SELECT ID_PEDIDO,
                    EMPCODIGO,
                    TPCODIGO,
                     PEDDTEMIS,
                      P.CLICODIGO,
                       GCLCODIGO,
                        SETOR,
                         IIF(FISCODIGO IS NULL,0,1) VENDA,
                          CLINOMEFANT,
                           PEDORIGEM
                            FROM PEDID P
                             LEFT JOIN FIS ON P.FISCODIGO1=FIS.FISCODIGO
                              INNER JOIN CLI C ON P.CLICODIGO=C.CLICODIGO AND P.ENDCODIGO=C.ENDCODIGO
                               WHERE PEDDTEMIS BETWEEN '01.02.2023' AND '16.02.2023' AND PEDSITPED<>'C' ),
                               
      PROD AS (SELECT PROCODIGO,IIF(PROCODIGO2 IS NULL,PROCODIGO,PROCODIGO2)CHAVE,PROTIPO FROM PRODU)

    
      SELECT PD.ID_PEDIDO,
              PD.EMPCODIGO,
               PEDDTEMIS,
                CLICODIGO,
                 CLINOMEFANT,
                  GCLCODIGO,
                   SETOR,
                    PEDORIGEM,
                     TPCODIGO,
                      FISCODIGO,
                       VENDA,
                        PD.PROCODIGO,
                         CHAVE,
                          PDPDESCRICAO,
                           PROTIPO,
                            PDPPCOUNIT PRECO_UNIT,
                             SUM(PDPQTDADE)QTD,
                              SUM(PDPUNITLIQUIDO*PDPQTDADE)VRVENDA,
                               ROUND((((SUM(PDPUNITLIQUIDO*PDPQTDADE)/NULLIF(SUM(PDPPCOUNIT*PDPQTDADE), 0)-1)*100)*-1),2) DESCTO
                                FROM PDPRD PD
                                 INNER JOIN PED P ON PD.ID_PEDIDO=P.ID_PEDIDO
                                  LEFT JOIN PROD PR ON PD.PROCODIGO=PR.PROCODIGO
                                   GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16 ORDER BY ID_PEDIDO DESC
                               
                               