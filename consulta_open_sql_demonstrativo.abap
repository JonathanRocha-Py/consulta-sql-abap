*&---------------------------------------------------------------------*
*&  Consulta com Open SQL — Demonstrativo
*&  Jonathan Rocha — Outubro/2026
*&---------------------------------------------------------------------*

REPORT zdemo_consulta_sql.

* Estrutura para receber os dados
TYPES: BEGIN OF ts_material,
         matnr TYPE n LENGTH 10,  "Número do material
         maktx TYPE string,       "Descrição
         mtart TYPE c LENGTH 4,   "Tipo de material
       END OF ts_material.

* Tabela interna que vai receber o resultado
DATA: gt_resultado TYPE TABLE OF ts_material,
      gs_linha     TYPE ts_material.

* 1. Selecionar dados
SELECT matnr maktx mtart
  FROM makt
  INTO CORRESPONDING FIELDS OF TABLE gt_resultado
  UP TO 10 ROWS.

* 2. Verificar se deu certo
IF sy-subrc = 0.
  WRITE: / '✅ Consulta realizada com sucesso!',
         / 'Foram encontrados', lines( gt_resultado ), 'registros.', /.

* 3. Exibir os resultados
  LOOP AT gt_resultado INTO gs_linha.
    WRITE: / 'Material:', gs_linha-matnr,
             '| Descrição:', gs_linha-maktx,
             '| Tipo:', gs_linha-mtart.
  ENDLOOP.
ELSE.
  WRITE: / '❌ Nenhum registro encontrado.'.
ENDIF.
