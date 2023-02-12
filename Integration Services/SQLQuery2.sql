/****** Script do comando SelectTopNRows de SSMS  ******/
SELECT TOP (1000) [Cod_Dia]
      ,[Data]
      ,[Cod_Semana]
      ,[Nome_Dia_Semana]
      ,[Cod_Mes]
      ,[Nome_Mes]
      ,[Cod_Mes_Ano]
      ,[Nome_Mes_Ano]
      ,[Cod_Trimestre]
      ,[Nome_Trimestre]
      ,[Cod_Trimestre_Ano]
      ,[Nome_Trimestre_Ano]
      ,[Cod_Semestre]
      ,[Nome_Semestre]
      ,[Cod_Semestre_Ano]
      ,[Nome_Semestre_Ano]
      ,[Ano]
      ,[Tipo_Dia]
  FROM [DW_SUCOS].[dbo].[Dim_Tempo]
  WHERE ANO = '2013' AND
  COD_MES >= 7 AND COD_MES <= 12