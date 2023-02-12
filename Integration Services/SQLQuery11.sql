/****** Script do comando SelectTopNRows de SSMS  ******/
SELECT TOP (1000) [Cod_Produto]
      ,[Cod_Fabrica]
      ,[Cod_Dia]
      ,[Meta_Custo]
  FROM [DW_SUCOS].[dbo].[Fato_005]