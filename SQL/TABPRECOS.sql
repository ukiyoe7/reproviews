

 WITH PRECO AS(SELECT PROCODIGO,PREPCOVENDA,PREPCOVENDA2 FROM PREMP WHERE EMPCODIGO=1)
               
               SELECT PD.PROCODIGO,
                           PRODESCRICAO,
                             GR1CODIGO,
                              GR2CODIGO,
                              TPLCODIGO,
                               PD.MARCODIGO,
                                MARNOME MARCA,
                                 PROTIPO,
                                  PROUN,
                                  PREPCOVENDA,
                                   PREPCOVENDA2,
                                    PREPCOVENDA*2 PAR_ATC,
                                     PREPCOVENDA2*2 PAR_LAB
               FROM PRODU PD
               
               INNER JOIN PRECO P ON PD.PROCODIGO=P.PROCODIGO
               LEFT JOIN MARCA M ON PD.MARCODIGO=M.MARCODIGO 
               WHERE GR1CODIGO<>17 AND PROSITUACAO='A'
                 AND PROCODIGO2 IS NULL