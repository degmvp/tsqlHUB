USE [X1DBSQL]
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_000_load_Extnulltb]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2012-06-09				*/
--Objetivo:update tables [tx1_Extendednull] Extended Properties
--  exec dbo.[prc1_Ase_000_load_Extnulltb]
/********************************************************************************/
CREATE proc [dbo].[prc1_Ase_000_load_Extnulltb]
as
-----------------------------------------------------------------------
-- User-defined variables

-- Set these to 1 or 0 to indicate whether you wish to output the elements

-----------------------------------------------------------------------
set nocount on
DECLARE @OutputTables BIT 
DECLARE @OutputViews BIT 
DECLARE @OutputProcedures BIT 
DECLARE @OutputFunctions BIT 
DECLARE @OutputTableColumns BIT 
DECLARE @OutputViewColumns BIT 
DECLARE @OutputIndexes BIT 
DECLARE @OutputConstraints BIT 

SET @OutputTables = 1
SET @OutputViews = 1
SET @OutputProcedures = 1
SET @OutputFunctions = 1
SET @OutputTableColumns = 1
SET @OutputViewColumns = 1
SET @OutputIndexes = 1
SET @OutputConstraints = 1


-----------------------------------------------------------------------
-- Process variables
-----------------------------------------------------------------------

DECLARE @ObjectType NVARCHAR(50) = ''
DECLARE @SecondaryObjectType NVARCHAR(50) = ''


-----------------------------------------------------------------------
-- Create the temporary table to hold the scripts and metadata
-----------------------------------------------------------------------


IF OBJECT_ID('#ModifyCreate') IS NOT NULL
DROP TABLE #ModifyCreate;

CREATE TABLE #ModifyCreate (PrimaryObjectType VARCHAR(25), SecondaryObjectType VARCHAR(25), 
SchemaName NVARCHAR(128), PrimaryObjectName NVARCHAR(128), SecondaryObjectName NVARCHAR(128), 
Classification NVARCHAR(128), DescriptionText NVARCHAR(1700), SQLText NVARCHAR(2500))



-----------------------------------------------------------------------
-- Output scripts for Table objects
-----------------------------------------------------------------------

IF @OutputTables = 1
BEGIN
SET @ObjectType = 'Table'

INSERT INTO #ModifyCreate

SELECT     
@ObjectType AS PrimaryObjectType
,CAST(NULL AS VARCHAR(25)) AS SecondaryObjectType
,SCH.name AS SchemaName
,CAST(TBL.name AS NVARCHAR(128)) AS PrimaryObjectName
,CAST(NULL AS VARCHAR(25)) AS SecondaryObjectName
,EX.DescriptionType AS Classification
,CAST(EX.DescriptionDefinition AS NVARCHAR(128)) AS DescriptionText
,CASE
WHEN EX.DescriptionType IS NULL THEN 'sp_addextendedproperty @level0type = N''Schema'', @level0name = [' + SCH.name + '], @level1type = ''' + @ObjectType + ''',  @level1name = [' + TBL.name + '], @name = N'''', @value = '''';'
ELSE 'sp_updateextendedproperty @level0type = N''Schema'', @level0name = [' + SCH.name + '], @level1type = ''' + @ObjectType + ''',  @level1name = [' + TBL.name + '], @name = N''' + EX.DescriptionType  + ''', @value = ''' + CAST(EX.DescriptionDefinition AS NVARCHAR(1700)) + ''';'
END AS SQLText

FROM        sys.tables TBL
			INNER JOIN sys.schemas SCH
			ON TBL.schema_id = SCH.schema_id 
			LEFT OUTER JOIN
							(
								SELECT DISTINCT    
								SEP.name AS DescriptionType
								,SEP.value AS DescriptionDefinition
								,SEP.major_id
								FROM        sys.extended_properties SEP
								WHERE		SEP.class = 1 
											AND SEP.minor_id = 0
											AND (SEP.value <> '1' AND SEP.value <> 1)
							) EX
							ON TBL.object_id = EX.major_id

END  -- Tables
-----------------------------------------------------------------------
-- Output scripts
-----------------------------------------------------------------------
IF  EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dbo].[x1tb_obj_Extendednull]') AND type in (N'U'))
truncate TABLE [dbo].x1tb_obj_Extendednull

insert into X1DBSQL.dbo.x1tb_obj_Extendednull 
SELECT PrimaryObjectType,SchemaName,PrimaryObjectName,Classification,
DescriptionText
FROM #ModifyCreate where classification is null
order by PrimaryObjectName;


select * from X1DBSQL.dbo.x1tb_obj_Extendednull 


GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_001_load_Extnullsp]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2012-06-09				*/
--Objetivo:update procs [tx1_Extendednull] Extended Properties
--  exec x1dbsql.dbo.[prc1_Ase_001_load_Extnullsp]
/********************************************************************************/
CREATE proc [dbo].[prc1_Ase_001_load_Extnullsp]
as
-----------------------------------------------------------------------
-- User-defined variables

-- Set these to 1 or 0 to indicate whether you wish to output the elements

-----------------------------------------------------------------------
set nocount on
DECLARE @OutputTables BIT 
DECLARE @OutputViews BIT 
DECLARE @OutputProcedures BIT 
DECLARE @OutputFunctions BIT 
DECLARE @OutputTableColumns BIT 
DECLARE @OutputViewColumns BIT 
DECLARE @OutputIndexes BIT 
DECLARE @OutputConstraints BIT 

SET @OutputTables = 1
SET @OutputViews = 1
SET @OutputProcedures = 1
SET @OutputFunctions = 1
SET @OutputTableColumns = 1
SET @OutputViewColumns = 1
SET @OutputIndexes = 1
SET @OutputConstraints = 1


-----------------------------------------------------------------------
-- Process variables
-----------------------------------------------------------------------

DECLARE @ObjectType NVARCHAR(50) = ''
DECLARE @SecondaryObjectType NVARCHAR(50) = ''


-----------------------------------------------------------------------
-- Create the temporary table to hold the scripts and metadata
-----------------------------------------------------------------------


IF OBJECT_ID('#ModifyCreate') IS NOT NULL
DROP TABLE #ModifyCreate;

CREATE TABLE #ModifyCreate (PrimaryObjectType VARCHAR(25), SecondaryObjectType VARCHAR(25), 
SchemaName NVARCHAR(128), PrimaryObjectName NVARCHAR(128), SecondaryObjectName NVARCHAR(128), 
Classification NVARCHAR(128), DescriptionText NVARCHAR(1700), SQLText NVARCHAR(2500))


-----------------------------------------------------------------------
-- Output scripts for Stored procedure objects
-----------------------------------------------------------------------

IF @OutputProcedures = 1
BEGIN

SET @ObjectType = 'Procedure'

INSERT INTO #ModifyCreate

SELECT     
@ObjectType AS PrimaryObjectType
,CAST(NULL AS VARCHAR(25)) AS SecondaryObjectType
,SCH.name AS SchemaName
,CAST(PRC.name AS NVARCHAR(128)) AS PrimaryObjectName
,CAST(NULL AS VARCHAR(25)) AS SecondaryObjectName
,EX.DescriptionType AS Classification
,CAST(EX.DescriptionDefinition AS NVARCHAR(128)) AS DescriptionText
,CASE
WHEN EX.DescriptionType IS NULL THEN 'sp_addextendedproperty @level0type = N''Schema'', @level0name = [' + SCH.name + '], @level1type = ''' + @ObjectType + ''',  @level1name = [' + PRC.name + '], @name = N'''', @value = '''';'
ELSE 'sp_updateextendedproperty @level0type = N''Schema'', @level0name = [' + SCH.name + '], @level1type = ''' + @ObjectType + ''',  @level1name = [' + PRC.name + '], @name = N''' + EX.DescriptionType  + ''', @value = ''' + CAST(EX.DescriptionDefinition AS NVARCHAR(1700)) + ''';'
END AS SQLText

FROM        sys.procedures PRC
			INNER JOIN sys.schemas SCH
			ON PRC.schema_id = SCH.schema_id 
			LEFT OUTER JOIN
							(
								SELECT DISTINCT    
								SEP.name AS DescriptionType
								,SEP.value AS DescriptionDefinition
								,SEP.major_id
								FROM        sys.extended_properties SEP
								WHERE		SEP.class = 1 
											AND SEP.minor_id = 0
											AND (SEP.value <> '1' AND SEP.value <> 1)
							) EX
							ON PRC.object_id = EX.major_id

END -- Procedures
----------------------------------------------------------------------
-- Output scripts
-----------------------------------------------------------------------
IF  EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'X1DBSQL.dbo.x1tb_obj_Extendednull ') AND type in (N'U'))
truncate TABLE X1DBSQL.dbo.x1tb_obj_Extendednull 


insert into X1DBSQL.dbo.x1tb_obj_Extendednull 
SELECT PrimaryObjectType,SchemaName,PrimaryObjectName,Classification,
DescriptionText
FROM #ModifyCreate where classification is null
and substring(PrimaryObjectName,1,3) <> 'sp_'
order by PrimaryObjectName;


select * from X1DBSQL.dbo.x1tb_obj_Extendednull order by XE3_NAME
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_002_load_Extnullvw]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2012-06-09				*/
--Objetivo:update views [tx1_Extendednull] Extended Properties
--  exec x1dbsql.dbo.[prc1_Ase_002_load_Extnullvw]
/********************************************************************************/
CREATE proc [dbo].[prc1_Ase_002_load_Extnullvw]
as
-----------------------------------------------------------------------
-- User-defined variables

-- Set these to 1 or 0 to indicate whether you wish to output the elements

-----------------------------------------------------------------------
set nocount on
DECLARE @OutputTables BIT 
DECLARE @OutputViews BIT 
DECLARE @OutputProcedures BIT 
DECLARE @OutputFunctions BIT 
DECLARE @OutputTableColumns BIT 
DECLARE @OutputViewColumns BIT 
DECLARE @OutputIndexes BIT 
DECLARE @OutputConstraints BIT 

SET @OutputTables = 1
SET @OutputViews = 1
SET @OutputProcedures = 1
SET @OutputFunctions = 1
SET @OutputTableColumns = 1
SET @OutputViewColumns = 1
SET @OutputIndexes = 1
SET @OutputConstraints = 1


-----------------------------------------------------------------------
-- Process variables
-----------------------------------------------------------------------

DECLARE @ObjectType NVARCHAR(50) = ''
DECLARE @SecondaryObjectType NVARCHAR(50) = ''


-----------------------------------------------------------------------
-- Create the temporary table to hold the scripts and metadata
-----------------------------------------------------------------------


IF OBJECT_ID('#ModifyCreate') IS NOT NULL
DROP TABLE #ModifyCreate;

CREATE TABLE #ModifyCreate (PrimaryObjectType VARCHAR(25), SecondaryObjectType VARCHAR(25), 
SchemaName NVARCHAR(128), PrimaryObjectName NVARCHAR(128), SecondaryObjectName NVARCHAR(128), 
Classification NVARCHAR(128), DescriptionText NVARCHAR(1700), SQLText NVARCHAR(2500))

-----------------------------------------------------------------------
-- Output scripts for View objects
-----------------------------------------------------------------------

IF @OutputViews = 1
BEGIN

SET @ObjectType = 'View'

INSERT INTO #ModifyCreate

SELECT     
@ObjectType AS PrimaryObjectType
,CAST(NULL AS VARCHAR(25)) AS SecondaryObjectType
,SCH.name AS SchemaName
,CAST(VIW.name AS NVARCHAR(128)) AS PrimaryObjectName
,CAST(NULL AS VARCHAR(25)) AS SecondaryObjectName
,EX.DescriptionType AS Classification
,CAST(EX.DescriptionDefinition AS NVARCHAR(128)) AS DescriptionText
,CASE
WHEN EX.DescriptionType IS NULL THEN 'sp_addextendedproperty @level0type = N''Schema'', @level0name = [' + SCH.name + '], @level1type = ''' + @ObjectType + ''',  @level1name = [' + VIW.name + '], @name = N'''', @value = '''';'
ELSE 'sp_updateextendedproperty @level0type = N''Schema'', @level0name = [' + SCH.name + '], @level1type = ''' + @ObjectType + ''',  @level1name = [' + VIW.name + '], @name = N''' + EX.DescriptionType  + ''', @value = ''' + CAST(EX.DescriptionDefinition AS NVARCHAR(1700)) + ''';'
END AS SQLText

FROM        sys.views VIW
			INNER JOIN sys.schemas SCH
			ON VIW.schema_id = SCH.schema_id 
			LEFT OUTER JOIN
							(
								SELECT DISTINCT    
								SEP.name AS DescriptionType
								,SEP.value AS DescriptionDefinition
								,SEP.major_id
								FROM        sys.extended_properties SEP
								WHERE		SEP.class = 1 
											AND SEP.minor_id = 0
											AND (SEP.value <> '1' AND SEP.value <> 1)
							) EX
							ON VIW.object_id = EX.major_id

END -- Views


----------------------------------------------------------------------
-- Output scripts
-----------------------------------------------------------------------
IF  EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'X1DBSQL.dbo.x1tb_obj_Extendednull ') AND type in (N'U'))
truncate TABLE X1DBSQL.dbo.x1tb_obj_Extendednull 


insert into X1DBSQL.dbo.x1tb_obj_Extendednull 
SELECT PrimaryObjectType,SchemaName,PrimaryObjectName,Classification,
DescriptionText
FROM #ModifyCreate where classification is null
order by PrimaryObjectName;


select * from X1DBSQL.dbo.x1tb_obj_Extendednull 



GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_003_list_Extended_triggers]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2019-06-06				*/
--Objetivo:Lista "todos os triggers " de tabelas e database
--  exec x1dbsql.dbo.[prc1_Ase_003_list_Extended_triggers]
/********************************************************************************/
CREATE proc [dbo].[prc1_Ase_003_list_Extended_triggers]
as
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
select trg.name as trigger_name,
    schema_name(tab.schema_id) + '.' + tab.name as [table],
    case when is_instead_of_trigger = 1 then 'Instead of'
        else 'After' end as [activation],
    (case when objectproperty(trg.object_id, 'ExecIsUpdateTrigger') = 1
                then 'Update ' else '' end 
    + case when objectproperty(trg.object_id, 'ExecIsDeleteTrigger') = 1
                then 'Delete ' else '' end
    + case when objectproperty(trg.object_id, 'ExecIsInsertTrigger') = 1
                then 'Insert' else '' end
    ) as [event],
    case when trg.parent_class = 1 then 'Table trigger'
        when trg.parent_class = 0 then 'Database trigger' 
    end [class], 
    case when trg.[type] = 'TA' then 'Assembly (CLR) trigger'
        when trg.[type] = 'TR' then 'SQL trigger' 
        else '' end as [type],
    case when is_disabled = 1 then 'Disabled'
        else 'Active' end as [status],
    object_definition(trg.object_id) as [definition]
from sys.triggers trg
    left join sys.objects tab
        on trg.parent_id = tab.object_id
order by trg.name;

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_004_list_Extended_table]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2012-06-09	alterado:03/08/2014			*/
--Objetivo:Lista "Extended Properties" de todas as tabelas
--  exec x1dbsql.dbo.[prc1_Ase_004_list_Extended_table]
/********************************************************************************/
CREATE proc [dbo].[prc1_Ase_004_list_Extended_table]
as
-----------------------------------------------------------------------------------
SELECT objtype, objname, name, value
FROM fn_listextendedproperty (NULL, 'schema', 'dbo', 'table', default, NULL, NULL);
-----------------------------------------------------------------------------------
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_005_list_Extended_procs]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2012-06-09	alterado:03/08/2014			*/
--Objetivo:Lista "Extended Properties" de todas as procedures
--  exec x1dbsql.dbo.[prc1_Ase_005_list_Extended_procs]
/********************************************************************************/
CREATE proc [dbo].[prc1_Ase_005_list_Extended_procs]
as
-----------------------------------------------------------------------------------
SELECT objtype, objname, name, value
FROM fn_listextendedproperty (NULL, 'schema', 'dbo', 'procedure', default, NULL, NULL)
where substring(objname,1,3) != 'sp_'
ORDER BY objname;
-----------------------------------------------------------------------------------

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_006_list_Extended_views]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2012-06-09	alterado:03/08/2014			*/
--Objetivo:Lista "Extended Properties" de todas as views
--  exec x1dbsql.dbo.[prc1_Ase_006_list_Extended_views]
/********************************************************************************/
create proc [dbo].[prc1_Ase_006_list_Extended_views]
as
-----------------------------------------------------------------------------------
SELECT objtype, objname, name, value
FROM fn_listextendedproperty (NULL, 'schema', 'dbo', 'view', default, NULL, NULL);
-----------------------------------------------------------------------------------
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_007_list_Extended_functions]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2012-06-09	alterado:03/08/2014			*/
--Objetivo:Lista "Extended Properties" de todas as functions
--  exec x1dbsql.dbo.[prc1_Ase_007_list_Extended_functions]
/********************************************************************************/
CREATE proc [dbo].[prc1_Ase_007_list_Extended_functions]
as
-----------------------------------------------------------------------------------
SELECT objtype, objname, name, value
FROM fn_listextendedproperty (NULL, 'schema', 'dbo', 'function', default, NULL, NULL);
-----------------------------------------------------------------------------------
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_008_list_Extended_indexes]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2012-06-09	alterado:03/08/2014			*/
--Objetivo:Lista "Extended Properties" de todas os indices
--  exec x1dbsql.dbo.[prc1_Ase_008_list_Extended_indexes]
/********************************************************************************/
CREATE proc [dbo].[prc1_Ase_008_list_Extended_indexes]
as
-----------------------------------------------------------------------------------
SELECT class, class_desc, major_id, minor_id, ep.name, s.name AS [Index Name], value
FROM sys.extended_properties AS ep
INNER JOIN sys.indexes AS s ON ep.major_id = s.object_id AND ep.minor_id = s.index_id
WHERE class = 7
ORDER BY [Index Name];
-----------------------------------------------------------------------------------
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_009_create_V$view]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2011-05-11	alt: 03/08/2014			*/
--Objetivo: cria view da tabela informada       
--Parametros : tabela
--exec dbo.[prc1_Ase_009_create_V$view] [x1tb_obj_ChangeLog]
--exec dbo.[prc1_Ase_009_create_V$view] [x1tb_obj_ddlcancel]
--exec dbo.[prc1_Ase_009_create_V$view] [x1tb_obj_categoria]
--exec dbo.[prc1_Ase_009_create_V$view] [x2tb_Audit_queries]
/********************************************************************************/
/********************************************************************************/
CREATE  proc [dbo].[prc1_Ase_009_create_V$view]
@v sysname
as

SET NOCOUNT ON 

declare @sql varchar(max);

set @sql = 'create view [dbo].[V$_' + @v + ']' + CHAR(10) +
            'as ' + CHAR(10) +
            'SELECT     dbo.' + @v + '.*' + CHAR(10) +
            'FROM         dbo.' + @v 
            
            exec(@sql);

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_010_create_obj_catalog]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2011-04-18	 alt: 04/08/2014		*/
--Objetivo: Realiza backup de todos os objetos fontes Procs-Funtions-Views-Triggers
-- exec x1dbsql.[dbo].[prc1_Ase_010_create_obj_catalog]
/********************************************************************************/
CREATE PROCEDURE [dbo].[prc1_Ase_010_create_obj_catalog]
as 
IF  EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dbo].[#tb_SCode]') AND type in (N'U'))
DROP TABLE [dbo].[#tb_SCode];

CREATE TABLE [dbo].[#tb_SCode](
	[seq] [int] NULL,
	[id] [int] NULL,
	[sc] [sysname] NOT NULL,
	[n] [sysname] NOT NULL,
	[typ_Desc] [sysname] NOT NULL,
	[typ] [sysname] NOT NULL,
	[Def] [nvarchar](max) NULL
) ON [PRIMARY];
----------------------------------------------------------------------------------
--controle de acesso trunca a tabela do catalogo para nova carga
----------------------------------------------------------------------------------
truncate table x1tb_obj_syscat 
------------------------------ 
;With SqlCode
as
(
Select 
  M.object_id as id
, isnull (SCHEMA_NAME (Ob.schema_id), '') as sc
, object_name(M.object_id) as n
, OB.type_desc as typ_desc
, Case 
    When TYPE_DESC Like 'SQL%PROCEDURE' Then 'Proc'
    When TYPE_DESC Like 'SQL%TRIGGER'    Then 'Trig'
    When TYPE_DESC Like 'view'    Then 'View'
    Else 'VueF'
  End as typ
, M.definition as Def
, M.uses_ansi_nulls as aNull
, M.uses_quoted_identifier as qIden
from 
  sys.sql_modules M
  join
  sys.objects OB
  On OB.object_id = M.object_id 
)  
Insert into #tb_SCode (seq, id, sc, n, typ_desc, typ, def)
Select
  row_number() OVER (ORDER BY sc, n, id) as seq
, id, sc, n, typ_desc, typ, def
From 
  SqlCode
where objectpropertyEx(id, 'isMsShipped') = 0 
  and typ in('VUEF','Proc','Trig','View')

insert into dbo.x1tb_obj_syscat(obj_id,obj_name,obj_usage,obj_status,obj_type,obj_def,obj_date)
Select id,n,'Backup',1,
 Case 
    When TYP Like 'PROC' Then 'P'
    When TYP Like 'TRIG'    Then 'TR'
    When TYP Like 'view'    Then 'V'
    Else 'F'
  End as typ,
  def,GETDATE()
  from #tb_SCode order by typ;
   
 

insert into dbo.x1tb_obj_syscat(obj_id,obj_name,obj_status,obj_usage,obj_type,obj_def,obj_date)
select object_id,name,is_disabled,parent_class_desc,type,'sys.systriggers',GETDATE()
from  sys.triggers 
where parent_class_desc = 'DATABASE' or parent_class_desc = 'OBJECT_OR_COLUMN'

delete  from dbo.x1tb_obj_syscat where substring(obj_name,1,3) = 'sp_';


  select model_id,obj_id,obj_name,obj_status,obj_type,obj_usage,obj_date,obj_def
  from dbo.x1tb_obj_syscat;
--------------------------------------------------------------------------------
----------------------------------------------------------------------------------

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_011_list_obj_accessed]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2011-04-18	 alt: 04/08/2014		*/
--Objetivo: Lista /* Most accessed tables into database */
-- exec x1dbsql.[dbo].[prc1_Ase_011_list_obj_accessed] X1dbsql
/********************************************************************************/
CREATE PROCEDURE [dbo].[prc1_Ase_011_list_obj_accessed] @db sysname
as 
    SELECT 
       db_name(ius.database_id) [Database],
       t.NAME [Table],
      SUM(ius.user_seeks + ius.user_scans + ius.user_lookups) [#TimesAccessed]
    FROM
       sys.dm_db_index_usage_stats ius INNER JOIN sys.tables t 
         ON ius.OBJECT_ID = t.object_id
    WHERE 
       database_id = DB_ID(@db)  
    GROUP BY 
       database_id, 
       t.name
    ORDER BY 
       SUM(ius.user_seeks + ius.user_scans + ius.user_lookups) DESC
--------------------------------------------------------------------------------
----------------------------------------------------------------------------------

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_012_list_obj_accessed_ix]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2011-04-18	 alt: 08/10/2014		*/
--Objetivo: Lista /* Most accessed indexes into database */
-- exec [dbo].[prc1_Ase_012_list_obj_accessed_ix] 
/********************************************************************************/
CREATE PROCEDURE [dbo].[prc1_Ase_012_list_obj_accessed_ix] 
as 
SELECT 
       db_name(ius.database_id) [Database],
       t.NAME [Table],
       i.NAME [Index],
       i.type_desc [IndexType],
       ius.user_seeks + ius.user_scans + ius.user_lookups [#TimesAccessed]
    FROM 
       sys.dm_db_index_usage_stats ius INNER JOIN sys.indexes i 
         ON ius.OBJECT_ID = i.OBJECT_ID 
         AND ius.index_id = i.index_id INNER JOIN sys.tables t 
           ON i.OBJECT_ID = t.object_id
   WHERE 
       database_id = DB_ID()
   ORDER BY 
       ius.user_seeks + ius.user_scans + ius.user_lookups DESC
 
--------------------------------------------------------------------------------
----------------------------------------------------------------------------------
--------------------------------------------------------------------------------


GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_013_memory_used]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2014-04-18	 alt: 2019/07/12		*/
--Objetivo: how much memory is being used
 /***                                        ***/ 
-- exec [dbo].[prc1_Ase_013_memory_used] 
/********************************************************************************/
CREATE PROCEDURE [dbo].[prc1_Ase_013_memory_used] 
as
-- system level info 2008

SELECT cpu_count/hyperthread_ratio AS physical_cpu_count,
    physical_memory_kb / 1048576 AS physical_memory_meg,
    committed_kb / 128 AS committed_kb,
    committed_target_kb / 128 AS committed_target_kb
   FROM sys.dm_os_sys_info
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_014_list_compression_tables]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2014-04-18	 alt: 07/13/2019		*/
--Objetivo: List all compression tables
-- exec [dbo].[prc1_Ase_014_list_compression_tables]
/********************************************************************************/
CREATE PROCEDURE [dbo].[prc1_Ase_014_list_compression_tables] 
as
SELECT st.name, st.object_id, sp.partition_id, sp.partition_number, sp.data_compression,
sp.data_compression_desc FROM sys.partitions SP
INNER JOIN sys.tables ST ON
st.object_id = sp.object_id
WHERE data_compression <> 0
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_015_read_partition_functions]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-12-11					*/
--Objetivo:
--------------------------------------------------
--lista func_range and scheme_range  
--------------------------------------------------
--exec dbo.[prc1_Ase_015_read_partition_functions]
/********************************************************************************/
CREATE proc [dbo].[prc1_Ase_015_read_partition_functions] 
as
SET NOCOUNT ON
 
select sys.partition_functions.name , sys.partition_range_values.* , 
       sys.partition_schemes.name as name_scheme
from sys.partition_functions
inner join sys.partition_range_values on sys.partition_range_values.function_id = sys.partition_functions.function_id
inner join sys.partition_schemes      on sys.partition_schemes.function_id      = sys.partition_functions.function_id
where sys.partition_functions.name = 'func_range'

select sys.partition_schemes.name as name_scheme, sys.data_spaces.name as name_filegroup
from sys.partition_schemes
inner join sys.destination_data_spaces on sys.destination_data_spaces.partition_scheme_id = sys.partition_schemes.data_space_id
inner join sys.data_spaces on sys.data_spaces.data_space_id = sys.destination_data_spaces.data_space_id
where sys.partition_schemes.name = 'scheme_range_pk'

select sys.partition_schemes.name as name_scheme, sys.data_spaces.name as name_filegroup
from sys.partition_schemes
inner join sys.destination_data_spaces on sys.destination_data_spaces.partition_scheme_id = sys.partition_schemes.data_space_id
inner join sys.data_spaces on sys.data_spaces.data_space_id = sys.destination_data_spaces.data_space_id
where sys.partition_schemes.name = 'scheme_range'
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_016_lst_total_buffer_pages]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-12-21				*/
--Objetivo:   Lista total de buffer pages po banco
--            exec [dbo].[prc1_Ase_016_lst_total_buffer_pages]
/********************************************************************************/
CREATE PROCEDURE [dbo].[prc1_Ase_016_lst_total_buffer_pages]
as

set nocount on

DECLARE @total_buffer INT;
SELECT @total_buffer = cntr_value
   FROM sys.dm_os_performance_counters 
   WHERE RTRIM([object_name]) LIKE '%Buffer Manager'
   AND counter_name = 'Total Pages';
;WITH src AS
(


   SELECT 
       database_id, db_buffer_pages = COUNT_BIG(*)
       FROM sys.dm_os_buffer_descriptors
       WHERE database_id BETWEEN 5 AND 32766
       GROUP BY database_id
)

SELECT
   [db_name] = CASE [database_id] WHEN 32767 
       THEN 'Resource DB' 
       ELSE DB_NAME([database_id]) END,
   db_buffer_pages,
   db_buffer_MB = db_buffer_pages / 128,
   db_buffer_percent = CONVERT(DECIMAL(6,3), 
   db_buffer_pages * 100.0 / @total_buffer)
   into #tb_tot
FROM src
ORDER BY db_buffer_MB DESC;
SELECT CASE 

                 WHEN (GROUPING(db_name) = 1) THEN 'Total_Geral'

                     ELSE ISNULL(db_name, 'NÃO INFORMADO')

               END AS db_name,sum(db_buffer_pages)as total_pages,SUM(db_buffer_MB)as total_pages_MB
			   into #TB_REL
from #tb_tot
group by rollup(db_name)
order by total_pages_MB desc
SELECT * FROM #TB_REL
drop table #tb_tot,#TB_REL
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_017_qry_dbPermissions]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2019-07-14					*/
--Objetivo: list of database principals # role membership # dB level permissions
--exec [dbo].[prc1_Ase_017_qry_dbPermissions] null,null,'R'
--exec [dbo].[prc1_Ase_017_qry_dbPermissions] null,null,'S'
/********************************************************************************/
CREATE proc [dbo].[prc1_Ase_017_qry_dbPermissions] 
(
	@Principal sysname = NULL, 
	@Role sysname = NULL, 
	@Type nvarchar(30) = NULL,
	@ObjectName sysname = NULL,
	@Permission sysname = NULL,
    @UseLikeSearch bit = 1,
    @IncludeMSShipped bit = 1,
	@DropTempTables bit = 1,
	@Output varchar(30) = 'Default',
	@Print bit = 0
)
AS
  
SET NOCOUNT ON
    
DECLARE @Collation nvarchar(75) 
SET @Collation = N' COLLATE ' + CAST(SERVERPROPERTY('Collation') AS nvarchar(50))

DECLARE @sql nvarchar(max)
DECLARE @sql2 nvarchar(max)
DECLARE @ObjectList nvarchar(max)
    
DECLARE @LikeOperator nvarchar(4)

IF @UseLikeSearch = 1
	SET @LikeOperator = N'LIKE'
ELSE 
	SET @LikeOperator = N'='
    
IF @UseLikeSearch = 1
BEGIN 
	IF LEN(ISNULL(@Principal,'')) > 0
		SET @Principal = N'%' + @Principal + N'%'
        
	IF LEN(ISNULL(@Role,'')) > 0
		SET @Role = N'%' + @Role + N'%'
    
	IF LEN(ISNULL(@ObjectName,'')) > 0
		SET @ObjectName = N'%' + @ObjectName + N'%'
  
END
  
--=========================================================================
-- Database Principals
SET @sql =   
    N'SELECT DBPrincipals.principal_id AS DBPrincipalId, DBPrincipals.name AS DBPrincipal, DBPrincipals.type, 
       DBPrincipals.type_desc, DBPrincipals.default_schema_name, DBPrincipals.create_date, 
       DBPrincipals.modify_date, DBPrincipals.is_fixed_role, 
       Authorizations.name AS RoleAuthorization, DBPrincipals.sid,  
       CASE WHEN DBPrincipals.is_fixed_role = 0 AND DBPrincipals.name NOT IN (''dbo'',''guest'', ''INFORMATION_SCHEMA'', ''public'', ''sys'') THEN  
				''IF DATABASE_PRINCIPAL_ID('''''' + DBPrincipals.name + '''''') IS NOT NULL '' + 
               ''DROP '' + CASE DBPrincipals.[type] WHEN ''C'' THEN NULL 
                   WHEN ''K'' THEN NULL 
                   WHEN ''R'' THEN ''ROLE'' 
                   WHEN ''A'' THEN ''APPLICATION ROLE''  
                   ELSE ''USER'' END + 
               '' ''+QUOTENAME(DBPrincipals.name' + @Collation + N') + '';'' ELSE NULL END AS DropScript, 
       CASE WHEN DBPrincipals.is_fixed_role = 0 AND DBPrincipals.name NOT IN (''dbo'',''guest'', ''INFORMATION_SCHEMA'', ''public'', ''sys'') THEN  
				''IF DATABASE_PRINCIPAL_ID('''''' + DBPrincipals.name + '''''') IS NULL '' + 
               ''CREATE '' + CASE DBPrincipals.[type] WHEN ''C'' THEN NULL 
                   WHEN ''K'' THEN NULL 
                   WHEN ''R'' THEN ''ROLE'' 
                   WHEN ''A'' THEN ''APPLICATION ROLE'' 
                   ELSE ''USER'' END + 
               '' ''+QUOTENAME(DBPrincipals.name' + @Collation + N') END +  
               CASE WHEN DBPrincipals.[type] = ''R'' THEN 
                   ISNULL('' AUTHORIZATION ''+QUOTENAME(Authorizations.name' + @Collation + N'),'''')  
				   WHEN DBPrincipals.[type] = ''X'' THEN '' FROM EXTERNAL PROVIDER''
                   WHEN DBPrincipals.[type] = ''A'' THEN 
                       ''''  
                   WHEN DBPrincipals.[type] NOT IN (''C'',''K'') THEN 
                       ISNULL('' WITH DEFAULT_SCHEMA =  ''+
                          QUOTENAME(DBPrincipals.default_schema_name' + @Collation + N'),'''') 
               ELSE '''' END +
			   CASE WHEN DBPrincipals.[type] = ''S'' 
					THEN '', PASSWORD = ''''<Insert Strong Password Here '+ CAST(NEWID() AS nvarchar(36))+'>'''' '' ELSE ''''  END + 
               '';'' 
           AS CreateScript 
    FROM sys.database_principals DBPrincipals 
    LEFT OUTER JOIN sys.database_principals Authorizations 
       ON DBPrincipals.owning_principal_id = Authorizations.principal_id 
    WHERE 1=1 
       AND DBPrincipals.sid NOT IN (0x00, 0x01) '
    
IF LEN(ISNULL(@Principal,@Role)) > 0 
    IF @Print = 1
        SET @sql = @sql + NCHAR(13) + N'  AND DBPrincipals.name ' + @LikeOperator + N' ' + 
            ISNULL(QUOTENAME(@Principal,N''''),QUOTENAME(@Role,'''')) 
    ELSE
        SET @sql = @sql + NCHAR(13) + N'  AND DBPrincipals.name ' + @LikeOperator + N' ISNULL(@Principal,@Role) '
    
IF LEN(@Type) > 0
    IF @Print = 1
        SET @sql = @sql + NCHAR(13) + N'  AND DBPrincipals.type ' + @LikeOperator + N' ' + QUOTENAME(@Type,'''')
    ELSE
        SET @sql = @sql + NCHAR(13) + N'  AND DBPrincipals.type ' + @LikeOperator + N' @Type'
    
IF LEN(@ObjectName) > 0
    BEGIN
        SET @sql = @sql + NCHAR(13) + 
        N'   AND EXISTS (SELECT 1 ' + NCHAR(13) + 
        N'               FROM sys.all_objects [Objects] ' + NCHAR(13) + 
        N'               INNER JOIN sys.database_permissions Permission ' + NCHAR(13) +  
        N'                   ON Permission.major_id = [Objects].object_id ' + NCHAR(13) + 
        N'               WHERE Permission.major_id = [Objects].object_id ' + NCHAR(13) + 
        N'                 AND Permission.grantee_principal_id = DBPrincipals.principal_id ' + NCHAR(13)
          
        IF @Print = 1
            SET @sql = @sql + N'                 AND [Objects].name ' + @LikeOperator + N' ' + QUOTENAME(@ObjectName,'''') 
        ELSE
            SET @sql = @sql + N'                 AND [Objects].name ' + @LikeOperator + N' @ObjectName'
  
        SET @sql = @sql + N')'
    END
  
IF LEN(@Permission) > 0
    BEGIN
        SET @sql = @sql + NCHAR(13) + 
        N'   AND EXISTS (SELECT 1 ' + NCHAR(13) + 
        N'               FROM sys.database_permissions Permission ' + NCHAR(13) +  
        N'               WHERE Permission.grantee_principal_id = DBPrincipals.principal_id ' + NCHAR(13)
          
        IF @Print = 1
            SET @sql = @sql + N'                 AND Permission.permission_name ' + @LikeOperator + N' ' + QUOTENAME(@Permission,'''') 
        ELSE
            SET @sql = @sql + N'                 AND Permission.permission_name ' + @LikeOperator + N' @Permission'
  
        SET @sql = @sql + N')'
    END

IF @IncludeMSShipped = 0
	SET @sql = @sql + NCHAR(13) + N'  AND DBPrincipals.is_fixed_role = 0 ' + NCHAR(13) + 
				'  AND DBPrincipals.name NOT IN (''dbo'',''public'',''INFORMATION_SCHEMA'',''guest'',''sys'') '

IF @Print = 1
BEGIN
    PRINT N'-- Database Principals'
    PRINT CAST(@sql AS nvarchar(max))
    PRINT '' -- Spacing before the next print
    PRINT ''
END
ELSE
BEGIN
	IF object_id('tempdb..##DBPrincipals') IS NOT NULL
		DROP TABLE ##DBPrincipals

	-- Create temp table to store the data in
	CREATE TABLE ##DBPrincipals (
		DBPrincipalId int NULL,
		DBPrincipal sysname NULL,
		type char(1) NULL,
		type_desc nchar(60) NULL,
		default_schema_name sysname NULL,
		create_date datetime NULL,
		modify_date datetime NULL,
		is_fixed_role bit NULL,
		RoleAuthorization sysname NULL,
		sid varbinary(85) NULL,
		DropScript nvarchar(max) NULL,
		CreateScript nvarchar(max) NULL
		)
    
	SET @sql =  N'INSERT INTO ##DBPrincipals ' + NCHAR(13) + @sql

    EXEC sp_executesql @sql, N'@Principal sysname, @Role sysname, @Type nvarchar(30), 
        @ObjectName sysname, @Permission sysname', 
        @Principal, @Role, @Type, @ObjectName, @Permission
END  
--=========================================================================
-- Database Role Members
SET @sql =  
N'SELECT Users.principal_id AS UserPrincipalId, Users.name AS UserName, Roles.name AS RoleName, 
   CASE WHEN Users.is_fixed_role = 0 AND Users.name <> ''dbo'' THEN 
   ''EXEC sp_droprolemember @rolename = ''+QUOTENAME(Roles.name' + @Collation + 
            N','''''''')+'', @membername = ''+QUOTENAME(CASE WHEN Users.name = ''dbo'' THEN NULL
            ELSE Users.name END' + @Collation + 
            N','''''''')+'';'' END AS DropScript, 
   CASE WHEN Users.is_fixed_role = 0 AND Users.name <> ''dbo'' THEN 
   ''EXEC sp_addrolemember @rolename = ''+QUOTENAME(Roles.name' + @Collation + 
            N','''''''')+'', @membername = ''+QUOTENAME(CASE WHEN Users.name = ''dbo'' THEN NULL
            ELSE Users.name END' + @Collation + 
            N','''''''')+'';'' END AS AddScript 
FROM sys.database_role_members RoleMembers 
JOIN sys.database_principals Users 
   ON RoleMembers.member_principal_id = Users.principal_id 
JOIN sys.database_principals Roles 
   ON RoleMembers.role_principal_id = Roles.principal_id 
WHERE 1=1 '
        
IF LEN(ISNULL(@Principal,'')) > 0
    IF @Print = 1
        SET @sql = @sql + NCHAR(13) + N'  AND Users.name ' + @LikeOperator + N' '+QUOTENAME(@Principal,'''')
    ELSE
        SET @sql = @sql + NCHAR(13) + N'  AND Users.name ' + @LikeOperator + N' @Principal'
    
IF LEN(ISNULL(@Role,'')) > 0
    IF @Print = 1
        SET @sql = @sql + NCHAR(13) + N'  AND Roles.name ' + @LikeOperator + N' '+QUOTENAME(@Role,'''')
    ELSE
        SET @sql = @sql + NCHAR(13) + N'  AND Roles.name ' + @LikeOperator + N' @Role'
    
IF LEN(@Type) > 0 
    IF @Print = 1
        SET @sql = @sql + NCHAR(13) + N'  AND Users.type ' + @LikeOperator + N' ' + QUOTENAME(@Type,'''')
    ELSE
        SET @sql = @sql + NCHAR(13) + N'  AND Users.type ' + @LikeOperator + N' @Type'
  
IF LEN(@ObjectName) > 0
    BEGIN
        SET @sql = @sql + NCHAR(13) + 
        N'   AND EXISTS (SELECT 1 ' + NCHAR(13) + 
        N'               FROM sys.all_objects [Objects] ' + NCHAR(13) + 
        N'               INNER JOIN sys.database_permissions Permission ' + NCHAR(13) +  
        N'                   ON Permission.major_id = [Objects].object_id ' + NCHAR(13) + 
        N'               WHERE Permission.major_id = [Objects].object_id ' + NCHAR(13) + 
        N'                 AND Permission.grantee_principal_id = Users.principal_id ' + NCHAR(13)
          
        IF @Print = 1
            SET @sql = @sql + N'                 AND [Objects].name ' + @LikeOperator + N' ' + QUOTENAME(@ObjectName,'''') 
        ELSE
            SET @sql = @sql + N'                 AND [Objects].name ' + @LikeOperator + N' @ObjectName'
  
        SET @sql = @sql + N')'
    END
  
IF LEN(@Permission) > 0
    BEGIN
        SET @sql = @sql + NCHAR(13) + 
        N'   AND EXISTS (SELECT 1 ' + NCHAR(13) + 
        N'               FROM sys.database_permissions Permission ' + NCHAR(13) +  
        N'               WHERE Permission.grantee_principal_id = Users.principal_id ' + NCHAR(13)
          
        IF @Print = 1
            SET @sql = @sql + N'                 AND Permission.permission_name ' + @LikeOperator + N' ' + QUOTENAME(@Permission,'''') 
        ELSE
            SET @sql = @sql + N'                 AND Permission.permission_name ' + @LikeOperator + N' @Permission'
  
        SET @sql = @sql + N')'
    END
  
IF @IncludeMSShipped = 0
	SET @sql = @sql + NCHAR(13) + N'  AND Users.is_fixed_role = 0 ' + NCHAR(13) + 
				'  AND Users.name NOT IN (''dbo'',''public'',''INFORMATION_SCHEMA'',''guest'',''sys'') '

IF @Print = 1
BEGIN
    PRINT N'-- Database Role Members'
    PRINT CAST(@sql AS nvarchar(max))
    PRINT '' -- Spacing before the next print
    PRINT '' 
END
ELSE
BEGIN
	IF object_id('tempdb..##DBRoles') IS NOT NULL
		DROP TABLE ##DBRoles

    -- Create temp table to store the data in
    CREATE TABLE ##DBRoles (
        UserPrincipalId int NULL,
		UserName sysname NULL,
        RoleName sysname NULL,
        DropScript nvarchar(max) NULL,
        AddScript nvarchar(max) NULL
        )

	SET @sql =  'INSERT INTO ##DBRoles ' + NCHAR(13) + @sql
    
    EXEC sp_executesql @sql, N'@Principal sysname, @Role sysname, @Type nvarchar(30), 
        @ObjectName sysname, @Permission sysname', 
        @Principal, @Role, @Type, @ObjectName, @Permission
END
    
--=========================================================================
-- Database & object Permissions
SET @ObjectList =
N'; WITH ObjectList AS (
   SELECT SCHEMA_NAME(sys.all_objects.schema_id) ' + @Collation + N' AS SchemaName,
       name ' + @Collation + N' AS name, 
       object_id AS id, 
       ''OBJECT_OR_COLUMN'' AS class_desc,
       ''OBJECT'' AS class 
   FROM sys.all_objects
   UNION ALL
   SELECT name ' + @Collation + N' AS SchemaName, 
       NULL AS name, 
       schema_id AS id, 
       ''SCHEMA'' AS class_desc,
       ''SCHEMA'' AS class 
   FROM sys.schemas
   UNION ALL
   SELECT NULL AS SchemaName, 
       name ' + @Collation + N' AS name, 
       principal_id AS id, 
       ''DATABASE_PRINCIPAL'' AS class_desc,
       CASE type_desc 
           WHEN ''APPLICATION_ROLE'' THEN ''APPLICATION ROLE'' 
           WHEN ''DATABASE_ROLE'' THEN ''ROLE'' 
           ELSE ''USER'' END AS class 
   FROM sys.database_principals
   UNION ALL
   SELECT NULL AS SchemaName, 
       name ' + @Collation + N' AS name, 
       assembly_id AS id, 
       ''ASSEMBLY'' AS class_desc,
       ''ASSEMBLY'' AS class 
   FROM sys.assemblies
   UNION ALL' + NCHAR(13) 

SET @ObjectList = @ObjectList + 
N'   SELECT SCHEMA_NAME(sys.types.schema_id) ' + @Collation + N' AS SchemaName, 
       name ' + @Collation + N' AS name, 
       user_type_id AS id, 
       ''TYPE'' AS class_desc,
       ''TYPE'' AS class 
   FROM sys.types
   UNION ALL
   SELECT SCHEMA_NAME(schema_id) ' + @Collation + N' AS SchemaName, 
       name ' + @Collation + N' AS name, 
       xml_collection_id AS id, 
       ''XML_SCHEMA_COLLECTION'' AS class_desc,
       ''XML SCHEMA COLLECTION'' AS class 
   FROM sys.xml_schema_collections
   UNION ALL
   SELECT NULL AS SchemaName, 
       name ' + @Collation + N' AS name, 
       message_type_id AS id, 
       ''MESSAGE_TYPE'' AS class_desc,
       ''MESSAGE TYPE'' AS class 
   FROM sys.service_message_types
   UNION ALL
   SELECT NULL AS SchemaName, 
       name ' + @Collation + N' AS name, 
       service_contract_id AS id, 
       ''SERVICE_CONTRACT'' AS class_desc,
       ''CONTRACT'' AS class 
   FROM sys.service_contracts
   UNION ALL
   SELECT NULL AS SchemaName, 
       name ' + @Collation + N' AS name, 
       service_id AS id, 
       ''SERVICE'' AS class_desc,
       ''SERVICE'' AS class 
   FROM sys.services
   UNION ALL
   SELECT NULL AS SchemaName, 
       name ' + @Collation + N' AS name, 
       remote_service_binding_id AS id, 
       ''REMOTE_SERVICE_BINDING'' AS class_desc,
       ''REMOTE SERVICE BINDING'' AS class 
   FROM sys.remote_service_bindings
   UNION ALL
   SELECT NULL AS SchemaName, 
       name ' + @Collation + N' AS name, 
       route_id AS id, 
       ''ROUTE'' AS class_desc,
       ''ROUTE'' AS class 
   FROM sys.routes
   UNION ALL
   SELECT NULL AS SchemaName, 
       name ' + @Collation + N' AS name, 
       fulltext_catalog_id AS id, 
       ''FULLTEXT_CATALOG'' AS class_desc,
       ''FULLTEXT CATALOG'' AS class 
   FROM sys.fulltext_catalogs
   UNION ALL
   SELECT NULL AS SchemaName, 
       name ' + @Collation + N' AS name, 
       symmetric_key_id AS id, 
       ''SYMMETRIC_KEYS'' AS class_desc,
       ''SYMMETRIC KEY'' AS class 
   FROM sys.symmetric_keys
   UNION ALL
   SELECT NULL AS SchemaName, 
       name ' + @Collation + N' AS name, 
       certificate_id AS id, 
       ''CERTIFICATE'' AS class_desc,
       ''CERTIFICATE'' AS class 
   FROM sys.certificates
   UNION ALL
   SELECT NULL AS SchemaName, 
       name ' + @Collation + N' AS name, 
       asymmetric_key_id AS id, 
       ''ASYMMETRIC_KEY'' AS class_desc,
       ''ASYMMETRIC KEY'' AS class 
   FROM sys.asymmetric_keys 
   ) ' + NCHAR(13)
  
    SET @sql =
    N'SELECT Grantee.principal_id AS GranteePrincipalId, Grantee.name AS GranteeName, Grantor.name AS GrantorName, 
   Permission.class_desc, Permission.permission_name, 
   ObjectList.name AS ObjectName, 
   ObjectList.SchemaName, 
   Permission.state_desc,  
   CASE WHEN Grantee.is_fixed_role = 0 AND Grantee.name <> ''dbo'' THEN 
   ''REVOKE '' + 
   CASE WHEN Permission.[state]  = ''W'' THEN ''GRANT OPTION FOR '' ELSE '''' END + 
   '' '' + Permission.permission_name' + @Collation + N' +  
       CASE WHEN Permission.major_id <> 0 THEN '' ON '' + 
           ObjectList.class + ''::'' +  
           ISNULL(QUOTENAME(ObjectList.SchemaName),'''') + 
           CASE WHEN ObjectList.SchemaName + ObjectList.name IS NULL THEN '''' ELSE ''.'' END + 
           ISNULL(QUOTENAME(ObjectList.name),'''') 
           ' + @Collation + ' + '' '' ELSE '''' END + 
       '' FROM '' + QUOTENAME(Grantee.name' + @Collation + N')  + ''; '' END AS RevokeScript, 
   CASE WHEN Grantee.is_fixed_role = 0 AND Grantee.name <> ''dbo'' THEN 
   CASE WHEN Permission.[state]  = ''W'' THEN ''GRANT'' ELSE Permission.state_desc' + @Collation + N' END +  
       '' '' + Permission.permission_name' + @Collation + N' + 
       CASE WHEN Permission.major_id <> 0 THEN '' ON '' + 
           ObjectList.class + ''::'' +  
           ISNULL(QUOTENAME(ObjectList.SchemaName),'''') + 
           CASE WHEN ObjectList.SchemaName + ObjectList.name IS NULL THEN '''' ELSE ''.'' END + 
           ISNULL(QUOTENAME(ObjectList.name),'''') 
           ' + @Collation + N' + '' '' ELSE '''' END + 
       '' TO '' + QUOTENAME(Grantee.name' + @Collation + N')  + '' '' +  
       CASE WHEN Permission.[state]  = ''W'' THEN '' WITH GRANT OPTION '' ELSE '''' END +  
       '' AS ''+ QUOTENAME(Grantor.name' + @Collation + N')+'';'' END AS GrantScript 
FROM sys.database_permissions Permission 
JOIN sys.database_principals Grantee 
   ON Permission.grantee_principal_id = Grantee.principal_id 
JOIN sys.database_principals Grantor 
   ON Permission.grantor_principal_id = Grantor.principal_id 
LEFT OUTER JOIN ObjectList 
   ON Permission.major_id = ObjectList.id 
   AND Permission.class_desc = ObjectList.class_desc 
WHERE 1=1 '
    
IF LEN(ISNULL(@Principal,@Role)) > 0
    IF @Print = 1
        SET @sql = @sql + NCHAR(13) + N'  AND Grantee.name ' + @LikeOperator + N' ' + ISNULL(QUOTENAME(@Principal,''''),QUOTENAME(@Role,'''')) 
    ELSE
        SET @sql = @sql + NCHAR(13) + N'  AND Grantee.name ' + @LikeOperator + N' ISNULL(@Principal,@Role) '
            
IF LEN(@Type) > 0
    IF @Print = 1
        SET @sql = @sql + NCHAR(13) + N'  AND Grantee.type ' + @LikeOperator + N' ' + QUOTENAME(@Type,'''')
    ELSE
        SET @sql = @sql + NCHAR(13) + N'  AND Grantee.type ' + @LikeOperator + N' @Type'
    
IF LEN(@ObjectName) > 0
    IF @Print = 1
        SET @sql = @sql + NCHAR(13) + N'  AND ObjectList.name ' + @LikeOperator + N' ' + QUOTENAME(@ObjectName,'''') 
    ELSE
        SET @sql = @sql + NCHAR(13) + N'  AND ObjectList.name ' + @LikeOperator + N' @ObjectName '
    
IF LEN(@Permission) > 0
    IF @Print = 1
        SET @sql = @sql + NCHAR(13) + N'  AND Permission.permission_name ' + @LikeOperator + N' ' + QUOTENAME(@Permission,'''')
    ELSE
        SET @sql = @sql + NCHAR(13) + N'  AND Permission.permission_name ' + @LikeOperator + N' @Permission'

IF @IncludeMSShipped = 0
	SET @sql = @sql + NCHAR(13) + N'  AND Grantee.is_fixed_role = 0 ' + NCHAR(13) + 
				'  AND Grantee.name NOT IN (''dbo'',''public'',''INFORMATION_SCHEMA'',''guest'',''sys'') '
  
IF @Print = 1
    BEGIN
        PRINT '-- Database & object Permissions' 
        PRINT CAST(@ObjectList AS nvarchar(max))
        PRINT CAST(@sql AS nvarchar(max))
    END
ELSE
BEGIN
	IF object_id('tempdb..##DBPermissions') IS NOT NULL
		DROP TABLE ##DBPermissions

    -- Create temp table to store the data in
    CREATE TABLE ##DBPermissions (
        GranteePrincipalId int NULL,
		GranteeName sysname NULL,
        GrantorName sysname NULL,
        class_desc nvarchar(60) NULL,
        permission_name nvarchar(128) NULL,
        ObjectName sysname NULL,
        SchemaName sysname NULL,
        state_desc nvarchar(60) NULL,
        RevokeScript nvarchar(max) NULL,
        GrantScript nvarchar(max) NULL
        )
    
    -- Add insert statement to @sql
    SET @sql =  @ObjectList + 
                N'INSERT INTO ##DBPermissions ' + NCHAR(13) + 
                @sql

    EXEC sp_executesql @sql, N'@Principal sysname, @Role sysname, @Type nvarchar(30), 
        @ObjectName sysname, @Permission sysname', 
        @Principal, @Role, @Type, @ObjectName, @Permission
END

IF @Print <> 1
BEGIN
	IF @Output = 'None'
		PRINT ''
	ELSE IF @Output = 'CreateOnly'
	BEGIN
		SELECT CreateScript FROM ##DBPrincipals WHERE CreateScript IS NOT NULL
		UNION ALL
		SELECT AddScript FROM ##DBRoles WHERE AddScript IS NOT NULL
		UNION ALL
		SELECT GrantScript FROM ##DBPermissions WHERE GrantScript IS NOT NULL
	END 
	ELSE IF @Output = 'DropOnly' 
	BEGIN
		SELECT DropScript FROM ##DBPrincipals WHERE DropScript IS NOT NULL
		UNION ALL
		SELECT DropScript FROM ##DBRoles WHERE DropScript IS NOT NULL
		UNION ALL
		SELECT RevokeScript FROM ##DBPermissions WHERE RevokeScript IS NOT NULL
	END
	ELSE IF @Output = 'ScriptOnly' 
	BEGIN
		SELECT DropScript, CreateScript FROM ##DBPrincipals WHERE DropScript IS NOT NULL OR CreateScript IS NOT NULL
		UNION ALL
		SELECT DropScript, AddScript FROM ##DBRoles WHERE DropScript IS NOT NULL OR AddScript IS NOT NULL
		UNION ALL
		SELECT RevokeScript, GrantScript FROM ##DBPermissions WHERE RevokeScript IS NOT NULL OR GrantScript IS NOT NULL
	END
	ELSE IF @Output = 'Report'
	BEGIN
		SELECT DBPrincipal, type, type_desc,
				STUFF((SELECT ', ' + ##DBRoles.RoleName
						FROM ##DBRoles
						WHERE ##DBPrincipals.DBPrincipalId = ##DBRoles.UserPrincipalId
						ORDER BY ##DBRoles.RoleName
						FOR XML PATH(''),TYPE).value('.','VARCHAR(MAX)')
					, 1, 2, '') AS RoleMembership,
				STUFF((SELECT ', ' + ##DBPermissions.state_desc + ' ' + ##DBPermissions.permission_name + ' on ' + 
						COALESCE('OBJECT:'+##DBPermissions.SchemaName + '.' + ##DBPermissions.ObjectName, 
								'SCHEMA:'+##DBPermissions.SchemaName,
								'DATABASE:'+db_name())
						FROM ##DBPermissions
						WHERE ##DBPrincipals.DBPrincipalId = ##DBPermissions.GranteePrincipalId
						ORDER BY ##DBPermissions.state_desc, ##DBPermissions.ObjectName, ##DBPermissions.permission_name
						FOR XML PATH(''),TYPE).value('.','VARCHAR(MAX)')
					, 1, 2, '') AS DirectPermissions
		FROM ##DBPrincipals
		ORDER BY type, DBPrincipal
	END
	ELSE -- 'Default' or no match
	BEGIN
		SELECT DBPrincipal, type, type_desc, default_schema_name, 
				create_date, modify_date, is_fixed_role, RoleAuthorization, sid, 
				DropScript, CreateScript
		FROM ##DBPrincipals ORDER BY DBPrincipal
		IF LEN(@Role) > 0
			SELECT UserName, RoleName, DropScript, AddScript 
			FROM ##DBRoles ORDER BY RoleName, UserName
		ELSE
			SELECT UserName, RoleName, DropScript, AddScript 
			FROM ##DBRoles ORDER BY UserName, RoleName

		IF LEN(@ObjectName) > 0
			SELECT GranteeName, GrantorName, class_desc, permission_name, ObjectName, 
				SchemaName, state_desc, RevokeScript, GrantScript 
			FROM ##DBPermissions ORDER BY ObjectName, GranteeName
		ELSE
			SELECT GranteeName, GrantorName, class_desc, permission_name, ObjectName, 
				SchemaName, state_desc, RevokeScript, GrantScript 
			FROM ##DBPermissions ORDER BY GranteeName, ObjectName
	END

	IF @DropTempTables = 1
	BEGIN
		DROP TABLE ##DBPrincipals
		DROP TABLE ##DBRoles
		DROP TABLE ##DBPermissions
	END
END


GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_018_list_database_pages]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-06-13	 		*/
--Objetivo: 
 /*** /*Lista total de paginas e MB por banco*/   ***/ 
-- exec [dbo].[prc1_Ase_018_list_database_pages]
/********************************************************************************/
create PROCEDURE [dbo].[prc1_Ase_018_list_database_pages] 
as
 DECLARE @total_buffer INT;
SELECT @total_buffer = cntr_value
   FROM sys.dm_os_performance_counters 
   WHERE RTRIM([object_name]) LIKE '%Buffer Manager'
   AND counter_name = 'Total Pages';
   
;WITH src AS
(

   SELECT 
       database_id, db_buffer_pages = COUNT_BIG(*)
       FROM sys.dm_os_buffer_descriptors
       WHERE database_id BETWEEN 5 AND 32766
       GROUP BY database_id
)

SELECT
   [db_name] = CASE [database_id] WHEN 32767 
       THEN 'Resource DB' 
       ELSE DB_NAME([database_id]) END,
   db_buffer_pages,
   db_buffer_MB = db_buffer_pages / 128,
   db_buffer_percent = CONVERT(DECIMAL(6,3), 
   db_buffer_pages * 100.0 / @total_buffer)
   into #tb_tot
FROM src
ORDER BY db_buffer_MB DESC;
SELECT CASE 

                 WHEN (GROUPING(db_name) = 1) THEN 'Total_Geral'

                     ELSE ISNULL(db_name, 'NÃO INFORMADO')

               END AS db_name,sum(db_buffer_pages)as total_pages,SUM(db_buffer_MB)as total_pages_MB
from #tb_tot
group by rollup(db_name)
order by total_pages_MB desc
drop table #tb_tot
----------------------------------
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_019_list_delay_queries]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-06-13	 		*/
--Objetivo: 
 /*** /*Lista 20 queries mais demoradas*/   ***/ 
--  exec[dbo].[prc1_Ase_019_list_delay_queries]
/********************************************************************************/
CREATE PROCEDURE [dbo].[prc1_Ase_019_list_delay_queries] 
as
set nocount on
SELECT TOP 20
 GETDATE() AS [Collection Date],
qs.execution_count AS Execution_Count,
 SUBSTRING(qt.text,qs.statement_start_offset/2 +1,
 (CASE WHEN qs.statement_end_offset = -1
 THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
 ELSE qs.statement_end_offset END - qs.statement_start_offset
 )/2
 ) AS Query_Text,
 DB_NAME(qt.dbid) AS 'DB Name',
qs.total_worker_time AS 'Total CPU Time',
qs.total_worker_time/qs.execution_count AS 'Avg CPU Time (ms)',
qs.total_physical_reads AS 'Total Physical Reads',
qs.total_physical_reads/qs.execution_count AS 'Avg Physical Reads',
qs.total_logical_reads AS 'Total Logical Reads',
qs.total_logical_reads/qs.execution_count AS 'Avg Logical Reads',
qs.total_logical_writes AS 'Total Logical Writes',
qs.total_logical_writes/qs.execution_count AS 'Avg Logical Writes',
qs.total_elapsed_time AS 'Total Duration',
qs.total_elapsed_time/qs.execution_count AS 'Avg Duration (ms)',
qp.query_plan AS 'Plan'
into #x2tb_obj_delayqry
FROM sys.dm_exec_query_stats AS qs
 CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS qt
 CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) AS qp
 WHERE
 qs.execution_count > 50 OR
 qs.total_worker_time/qs.execution_count > 100 OR
 qs.total_physical_reads/qs.execution_count > 1000 OR
 qs.total_logical_reads/qs.execution_count > 1000 OR
 qs.total_logical_writes/qs.execution_count > 1000 OR
 qs.total_elapsed_time/qs.execution_count > 1000
 ORDER BY
 qs.execution_count DESC,
 qs.total_elapsed_time/qs.execution_count DESC,
 qs.total_worker_time/qs.execution_count DESC,
 qs.total_physical_reads/qs.execution_count DESC,
 qs.total_logical_reads/qs.execution_count DESC,
 qs.total_logical_writes/qs.execution_count DESC;

 select * from #x2tb_obj_delayqry;
 truncate table dbo.x2tb_obj_delayqry;

 insert into dbo.x2tb_obj_delayqry
 select * from #x2tb_obj_delayqry;

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_020_list_last_accessed_tb]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2011-04-18	 alt: 08/10/2014		*/
--Objetivo: Lista /* Last time the table was accessed */
-- exec x1dbsql.[dbo].[prc1_Ase_020_list_last_accessed_tb]
/********************************************************************************/
CREATE PROCEDURE [dbo].[prc1_Ase_020_list_last_accessed_tb] 
as 
;WITH latest AS
   ( 
   SELECT SCHEMA_NAME(B.schema_id) +'.'+object_name(b.object_id) [Table],
   (   SELECT MAX(last_user_dt) 

   FROM (VALUES (last_user_seek),(last_user_scan),(last_user_lookup)) AS all_val(last_user_dt)) [Accessed]
   FROM sys.dm_db_index_usage_stats a RIGHT OUTER JOIN sys.tables b 
     ON a.object_id = b.object_id 
   ) 
   SELECT 
      [Table],
      MAX([Accessed]) [LastAccessed]
   FROM
      latest
   GROUP BY 
      [Table]
   ORDER BY
      [LastAccessed] DESC
 
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_021_qry_default_object]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2011-04-10					*/
--Objetivo: -- Query the default trace by objects:--sp 8272, --tb 8277, --vw 8278
--parametros : --sp 8272, --tb 8277, --vw 8278
--exec [dbo].[prc1_Ase_021_qry_default_object]'X1DBSQL',8272
--exec [dbo].[prc1_Ase_021_qry_default_object]'X1DBSQL',8277
--exec [dbo].[prc1_Ase_021_qry_default_object]'X1DBSQL',8278
/********************************************************************************/
create proc [dbo].[prc1_Ase_021_qry_default_object] @db sysname,@ob int
as
set nocount on
DECLARE @Path varchar(256) = (
SELECT CONVERT(varchar(256),VALUE )
FROM   ::fn_trace_getinfo(1) 
WHERE  property = 2 ); SELECT @Path
-- C:\Program Files\Microsoft SQL Server\MSSQL10.SRV2008\MSSQL\Log\log_89.trc 
 

IF  EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dbo].[tb_#qry]') AND type in (N'U'))
DROP TABLE [dbo].[tb_#qry];
-- Query the default trace rollover file for altered objects
SELECT         
  DatabaseID,NTUserName,NTDomainName,ApplicationName,StartTime,ObjectID,ServerName,
        ObjectType,DatabaseName,e.name into tb_#qry
FROM  ::fn_trace_gettable(@Path, 0) 
        INNER JOIN sys.trace_events e  
           ON eventclass = trace_event_id 
        INNER JOIN sys.trace_categories AS cat 
           ON e.category_id = cat.category_id 
WHERE  databasename = @db
        AND objectname IS NULL
        AND e.name in('Object:Altered','Object:Created','Object:deleted')
        and ObjectType = @ob;

 select  DatabaseID,NTUserName,NTDomainName,ApplicationName,StartTime,ObjectID,o.name,
 ServerName,ObjectType,DatabaseName,e.name
 from  tb_#qry e, sys.sysobjects o
 where objectid = id  
 
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_022_list_filegroups]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-07-30			*/
--Objetivo: --Lista filegroups
--exec [dbo].[prc1_Ase_022_list_filegroups]
/********************************************************************************/
CREATE PROCEDURE [dbo].[prc1_Ase_022_list_filegroups]
                 @major int=1,
                 @minor int=0
--with encryption
AS
declare @db_name sysname,
        @version varchar(4),
        @testamt float
BEGIN
set nocount on
/*
*************************************************************************
* create worktable
*************************************************************************
*/
 
create table #filegroup_info
(dbname sysname NULL,
 groupid float NULL,
 groupname sysname NULL,
 total_space decimal(35,2) NULL,
 max_file_growth_size float NULL,
 file_count float NULL)

create table #space_info_objects
(dbname sysname NULL,
 groupid float NULL,
 reserved_pages_tables decimal(35,2) NULL,
 reserved_pages_indexes decimal(35,2) NULL
)
 
create table #logspace
(database_name sysname,
log_space decimal(35,2),
pct_used decimal(35,2) NULL,
status float)

/*
***********************************************************************
* Get server version and set cursor up for databases (only non-
* suspect).
***********************************************************************
*/
 
SET NOCOUNT ON
 
select @version = substring(@@version,23,4)
if @version = '7.00'
    declare db_cursor cursor for
            select name
            from master..sysdatabases
            where databaseproperty(name,N'IsShutdown') <> 1 and
                  databaseproperty(name,N'IsInRecovery') <> 1 and
                  databaseproperty(name,N'IsNotRecovered') <> 1 and 
                  databaseproperty(name,N'IsOffline') <> 1 and
                  databaseproperty(name,N'IsSuspect') <> 1 and 
				  has_dbaccess(name) = 1 
else
    exec ('declare db_cursor cursor for select name from master..sysdatabases where databasepropertyex(name,''status'') not in (''SUSPECT'', ''OFFLINE'', ''RESTORING'', ''RECOVERING'') and has_dbaccess(name) = 1')


open db_cursor
fetch db_cursor into @db_name
 
while @@fetch_status = 0
begin
 
/*
*************************************************************************
* gather base filegroup/file stats
*************************************************************************
*/
 
insert into #filegroup_info
(      dbname,
       groupid,
       groupname,
       total_space,
       max_file_growth_size,
       file_count)
exec ('use [' + @db_name + '] select db_name = db_name(), a.groupid,a.groupname,sum(convert(decimal(35,2),b.size)),max(b.growth),count(b.fileid) from sysfilegroups a RIGHT OUTER JOIN sysfiles b ON a.groupid = b.groupid group by a.groupid,a.groupname')
 
/*
*************************************************************************
* get table/index space info for non-log filegroups
*************************************************************************
*/
 
insert into #space_info_objects
(      dbname,
       groupid,
       reserved_pages_tables,
       reserved_pages_indexes
)
exec ('use [' + @db_name + '] 
                SELECT  DB_NAME = DB_NAME(),
                        c.data_space_id,
                        table_pages = ISNULL((
                 SELECT SUM(total_pages)
                 FROM   sys.allocation_units a,
                        sys.partitions b,
                        sys.tables d 
                      WHERE a.container_id = b.partition_id and
                            b.object_id = d.object_id and
                            b.index_id in (0,1,255)
                      AND c.data_space_id = a.data_space_id), 0), 
                   index_pages = ISNULL((
                 SELECT SUM(total_pages)
                 FROM   sys.allocation_units a,
                        sys.partitions b,
                        sys.indexes d 
                      WHERE a.container_id = b.partition_id and
                            b.object_id = d.object_id and
                            d.index_id = b.index_id and
                            (b.index_id > 1 and b.index_id < 255) and
                            d.name is not null and
                            d.name not like ''_WA_SYS_%'' and
                     d.name <> ''queue_clustered_index'' and
                     d.name <> '' queue_secondary_index'' and
                            c.data_space_id = a.data_space_id), 0)
                FROM sys.allocation_units c 
                GROUP BY c.data_space_id'
)

fetch db_cursor into @db_name
 
end
 
/* get percent used log information */
 
insert into #logspace (database_name,log_space,pct_used,status) 
select  db_name = a.instance_name,
                log_size_mb = convert(decimal(15,2),a.cntr_value) / 1024,
                log_pct_used = case
                                when a.cntr_value = 0 
                                then 100 
                                else 100 * convert(decimal(15,2),b.cntr_value)/convert(decimal(15,2),a.cntr_value)
                               end,
                status = 0
        from    master..sysperfinfo a,
                master..sysperfinfo b
        where   (a.object_name = 'SQLServer:Databases' or a.object_name like '%$%:Databases%') and
                (b.object_name = 'SQLServer:Databases' or b.object_name like '%$%:Databases%') and
                a.counter_name = 'Log File(s) Size (KB)' and
                b.counter_name = 'Log File(s) Used Size (KB)' and
                a.instance_name <> '_Total' and
                b.instance_name <> '_Total' and
                a.instance_name = b.instance_name

/* show file group info */
select  a.dbname,
        filegroupid = isnull(a.groupid,0),
        file_group = case 
        when groupname IS NULL then 'LOG'
        else groupname
       end,
       can_grow = case max_file_growth_size
                   when 0 then 'No'
                   else 'Yes'
                  end,
       file_count,
       size_in_mb = convert(decimal(35,2),((total_space * 8) / 1024)),
       table_reserved_mb = case 
                  when b.reserved_pages_tables IS NULL then 0
                  else convert(decimal(35,2),((b.reserved_pages_tables * 8) / 1024))
                  end,
       index_reserved_mb = case 
                  when b.reserved_pages_indexes IS NULL then 0
                  else convert(decimal(35,2),((b.reserved_pages_indexes * 8) / 1024))
                  end,
       free_space_mb = case 
                    when groupname IS NULL then 0
                      else
                      convert(decimal(35,2),((total_space * 8) / 1024)) -
                      case 
                        when b.reserved_pages_tables IS NULL then 0
                        else convert(decimal(35,2),((b.reserved_pages_tables * 8) / 1024))
                        end - 
                       case 
                          when b.reserved_pages_indexes IS NULL then 0
                          else convert(decimal(35,2),((b.reserved_pages_indexes * 8) / 1024))
                          end 
                       end,
       free_space_pct = case 
                      when groupname IS NULL then 100 - c.pct_used
                       else
                       convert(decimal(35,2),100 * (convert(decimal(35,2),((total_space * 8) / 1024)) -
                       case 
                       when b.reserved_pages_tables IS NULL then 0
                       else convert(decimal(35,2),((b.reserved_pages_tables * 8) / 1024))
                       end -
                       case b.reserved_pages_indexes
                       when NULL then 0
                       else convert(decimal(17,2),((b.reserved_pages_indexes * 8) / 1024))
                       end) / (convert(decimal(35,2),((total_space * 8) / 1024))))
                       end,
        log_free = case 
                   when groupname IS NULL then (convert(decimal(35,2),(log_space - (log_space * pct_used / 100)) ))
                   else 0 
                   end,
        log_used = case 
                   when groupname IS NULL then (convert(decimal(35,2),(log_space * pct_used / 100) ))
                   else 0 
                   end
from   #filegroup_info a 
       LEFT OUTER JOIN
       #space_info_objects b ON a.dbname = b.dbname
       LEFT OUTER JOIN #logspace c ON a.groupid = b.groupid
where  a.dbname = c.database_name
order by 1,2
 
deallocate db_cursor
drop table #logspace
drop table #filegroup_info
drop table #space_info_objects
 
  RETURN(0)
END

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_023_list_database_overview]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-07-30			*/
--Objetivo:
--calculates the space information for the storage overview
--exec [dbo].[prc1_Ase_023_list_database_overview]
/********************************************************************************/
CREATE procedure [dbo].[prc1_Ase_023_list_database_overview]
                 @major int=1,
                 @minor int=0
/*
*********************************************************************
* This stored procedure calculates the space information for the
* storage overview tab of Space Analyst.
***********************************************************************
*/
--with encryption
AS
 
declare @db_name sysname,
        @sp varchar(50),
        @version varchar(4)
 
/*
***********************************************************************
* Get server version and set cursor up for databases (only non-
* suspect).
***********************************************************************
*/
 
SET NOCOUNT ON
 
select @version = substring(@@version,23,4)
if @version = '7.00'
    declare db_cursor cursor for
            select name
            from master..sysdatabases
            where databaseproperty(name,N'IsShutdown') <> 1 and
                  databaseproperty(name,N'IsInRecovery') <> 1 and
                  databaseproperty(name,N'IsNotRecovered') <> 1 and 
                  databaseproperty(name,N'IsOffline') <> 1 and
                  databaseproperty(name,N'IsSuspect') <> 1 and 
				  has_dbaccess(name) = 1
else
    exec ('declare db_cursor cursor for select name from master..sysdatabases where databasepropertyex(name,''status'') not in (''SUSPECT'', ''OFFLINE'', ''RESTORING'', ''RECOVERING'') and has_dbaccess(name) = 1')
 
 
/*
***********************************************************************
* Create temporary tables needed to hold space information
***********************************************************************
*/
 
create table #dbspace  (database_name sysname,
                        total_space decimal(35,2),
                        used_db_space decimal(35,2) NULL,
                        total_log_space decimal(35,2))
create table #logspace (database_name sysname,
                        auto_grow bigint NULL,
                        log_space decimal(35,2),
                        pct_used decimal(35,2) NULL,
                        status bigint)
create table #dbgrowth  (database_name sysname NULL,
                        auto_grow char(1) NULL)
create table #loggrowth (database_name sysname NULL,
                        auto_grow bigint NULL)
create table #dbdetails (database_name sysname NULL,
                        table_count bigint NULL,
                        index_count bigint NULL,
                        total_table_reserved decimal(35,2) NULL,
                        total_index_reserved decimal(35,2) NULL)
 
/*
**********************************************************************
* Open database cursor and loop through all databases on server to
* collect their database space information
***********************************************************************
*/
 
open db_cursor
fetch db_cursor into @db_name
 
while @@fetch_status = 0
begin
 
    insert into #dbspace (database_name,total_space,used_db_space,total_log_space) EXEC ('use [' + @db_name + '] select db_name = db_name(),total_space = (select sum(convert(real,size)) / convert( real, (1048576 / (select low from master.dbo.spt_values where number = 1 and type = ''E''))) from dbo.sysfiles),total_db_used = (SELECT (SUM(convert(real,case type when 2 then used_pages else data_pages end)) * (select low from master.dbo.spt_values where number = 1 and type = ''E''))/1024/1024 FROM sys.allocation_units),total_log_space = (select sum(convert(real,size)) / convert( real, (1048576 / (select low from master.dbo.spt_values where number = 1 and type = ''E''))) from dbo.sysfiles where (status & 0x40)=0x40)' )
    insert into #dbgrowth (auto_grow) EXEC ('use [' + @db_name + '] select count(*) - ISNULL((select count(*) from sysfiles where growth = 0 and groupid=FILEGROUP_ID(''PRIMARY'')),0) from sysfiles where groupid=FILEGROUP_ID(''PRIMARY'')')
    insert into #loggrowth (auto_grow) EXEC ('use [' + @db_name + '] select count(*) - ISNULL((select count(*) from sysfiles where growth = 0 and (status&0x40)=0x40),0) from sysfiles where (status&0x40)=0x40')
    update #dbgrowth set database_name = @db_name where database_name is NULL
    update #loggrowth set database_name = @db_name where database_name is NULL
    insert into #dbdetails (database_name,table_count,index_count,total_table_reserved,total_index_reserved) EXEC ('use [' + @db_name + '] select db_name = db_name(), table_count = (select count(*) from sys.tables where type in (''U'',''S'')),index_count = (select count(*) from sys.indexes where name is not null and name not like ''_WA%'' and name <> ''queue_clustered_index'' and name <> ''queue_secondary_index''),table_pages = isnull((select sum(convert(decimal(35,2),total_pages)) FROM   sys.allocation_units a,sys.partitions b,sys.tables d WHERE a.container_id = b.partition_id and b.object_id = d.object_id and b.index_id in (0,1,255)),0),index_pages = isnull((select sum(convert(decimal(35,2),total_pages)) FROM   sys.allocation_units a,sys.partitions b,sys.indexes d WHERE d.index_id = b.index_id and a.container_id = b.partition_id and b.object_id = d.object_id and (b.index_id > 1 and b.index_id < 255) and d.name is not null and d.name not like ''_WA_SYS_%'' and d.name <> ''queue_clustered_index'' and d.name <> '' queue_secondary_index''),0)') 

    fetch db_cursor into @db_name
end
 
/*
**********************************************************************
* Get log space information
***********************************************************************
*/
 
insert into #logspace (database_name,log_space,pct_used,status)
select  db_name = a.instance_name,
                log_size_mb = convert(decimal(15,2),a.cntr_value) / 1024,
                log_pct_used = case
                                when a.cntr_value = 0 
                                then 100
                                else 100 * convert(decimal(15,2),b.cntr_value)/convert(decimal(15,2),a.cntr_value)
                               end,
                status = 0
        from    master..sysperfinfo a,
                master..sysperfinfo b
        where   (a.object_name = 'SQLServer:Databases' or a.object_name like '%$%:Databases%') and
                (b.object_name = 'SQLServer:Databases' or b.object_name like '%$%:Databases%') and
                a.counter_name = 'Log File(s) Size (KB)' and
                b.counter_name = 'Log File(s) Used Size (KB)' and
                a.instance_name <> '_Total' and
                b.instance_name <> '_Total' and
                a.instance_name = b.instance_name

 
/*
***********************************************************************
* Display space information for databases and logs
***********************************************************************
*/
 
select database_name = a.database_name,
       total_space,
       total_db_space = total_space - total_log_space,
       db_can_grow = case
                      when c.auto_grow > '0' then 'Yes' else 'No'
                     end,
       table_count,
       index_count,
       table_reserved_mb = case 
                  when e.total_table_reserved IS NULL then 0
                  else convert(decimal(35,2),((e.total_table_reserved *
                  8) / 1024))
                  end,
       index_reserved_mb = case 
                  when e.total_index_reserved IS NULL then 0
                  else convert(decimal(35,2),((e.total_index_reserved * 
                  8) / 1024))
                  end,
       total_log_space,
       log_can_grow = case
                       when d.auto_grow > 0 then 'Yes'
                       when d.auto_grow = 0 then 'No'
                     end,
       total_space_used = case
                           when (total_space - total_log_space) - used_db_space > 0 
                           then convert(decimal(35,2),(used_db_space + (a.total_log_space * (pct_used/100))))
                           else convert(decimal(35,2),((total_space - total_log_space) + (a.total_log_space * (pct_used/100))))
                          end,
       total_db_space_used = case
                              when (total_space - total_log_space) - used_db_space > 0 
                              then used_db_space
                              else total_space - total_log_space
                             end,
       total_log_space_used = convert(decimal(35,2),(a.total_log_space * (pct_used/100))),
       total_free_space = case
                           when (total_space - total_log_space) - used_db_space > 0 
                           then convert(decimal(35,2),(total_space - (used_db_space + (a.total_log_space * (pct_used/100)))))
                           else convert(decimal(35,2),(total_space - ((total_space - total_log_space) + (a.total_log_space * (pct_used/100)))))
                          end,
       total_free_db_space = case
                              when (total_space - total_log_space) - used_db_space > 0 
                              then (total_space - total_log_space) - used_db_space
                              else 0
                             end,
       total_free_log_space = convert(decimal(35,2),(total_log_space - (a.total_log_space * (pct_used/100)))),
       percent_db_used = case
                           when (total_space - total_log_space) - used_db_space > 0 
                           then convert(decimal(35,2),(100 * (used_db_space / (total_space - total_log_space)))) 
                           else convert(decimal(35,2),100) 
                          end,
       percent_log_used = pct_used
from   #dbspace a,
       #logspace b,
       #dbgrowth c,
       #loggrowth d,
       #dbdetails e
where  a.database_name = b.database_name and
       a.database_name = c.database_name and
       b.database_name = d.database_name and
       a.database_name = e.database_name
order by database_name
 
/*
***********************************************************************
* Clean up work
***********************************************************************
*/
 
deallocate db_cursor
drop table #dbspace
drop table #logspace
drop table #dbgrowth
drop table #loggrowth
drop table #dbdetails

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_024_list_database_map]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015/07/30			*/
--Objetivo:--Lista map de area do banco informado
--exec [dbo].[prc1_Ase_024_list_database_map]1,0,X1DBSQL,X1DBSQL 
/********************************************************************************/
CREATE PROCEDURE [dbo].[prc1_Ase_024_list_database_map]
    @major int=1,
    @minor int=0,
    @db sysname,
    @filename sysname
--with encryption
AS
declare @version varchar(4)
BEGIN
set nocount on
 
select @version = substring(@@version,23,4)
 
/*
*****************************************************************************
 * create worktable for extent information
******************************************************************************
*/
if @version = '7.00'
    create table #extent_info7
    (fileid int NULL,
     pageid int NULL,
     pgalloc int NULL,
     extent_size int NULL,
     table_id int NULL,
     index_id int NULL,
     pfs_bytes varbinary(1000) NULL,
     avg_used int NULL)
else if @version = '2000'
        create table #extent_info8
        (fileid int NULL,
         pageid int NULL,
         pgalloc int NULL,
         extent_size int NULL,
         table_id int NULL,
         index_id int NULL,
         pfs_bytes varbinary(1000) NULL)
     else
        create table #extent_info9
        (fileid int NULL,
         pageid int NULL,
         pgalloc int NULL,
         extent_size int NULL,
         table_id int NULL,
         index_id int NULL,
         partition_number int NULL,
	     partition_id bigint NULL,
         iam_chain_type varchar(50) NULL,
         pfs_bytes varbinary(1000) NULL)
 
/*
*****************************************************************************
 * get number of extents for file and number of blocks for map
******************************************************************************
*/

exec ('use [' + @db + '] select last_extent_number = size - 8,number_of_map_blocks = ((size - 8) / 8) + 1 from sysfiles where name = ''' + @filename + '''')  

/*
*****************************************************************************
 * get database extent map
******************************************************************************
*/
 
if @version = '7.00'
    insert into #extent_info7 exec ('dbcc extentinfo ([' + @db + ']) WITH NO_INFOMSGS'  )
else if @version = '2000'
    insert into #extent_info8 exec ('dbcc extentinfo ([' + @db + ']) WITH NO_INFOMSGS'  )
else
    insert into #extent_info9 exec ('dbcc extentinfo ([' + @db + ']) WITH NO_INFOMSGS'  )
/*
*****************************************************************************
 * present database map
******************************************************************************
*/
 
if @version = '7.00'
    exec ('use [' + @db + '] select fileid,pageid,map_block = pageid / 8,extent_number = (pageid / 8) * 8,pgalloc,extent_size,owner = user_name(uid),table_name = object_name(table_id), object_type = case index_id when 0 then ''TABLE'' when 1 then ''CLUSTERED TABLE/INDEX'' when 255 then ''TEXT'' else ''INDEX'' end,index_name = case index_id when 0 then ''N/A'' when 255 then ''N/A'' else c.name end, table_id,index_id from #extent_info7 a, sysobjects b, sysindexes c where a.table_id = b.id and a.table_id = c.id and a.index_id = c.indid and c.name not like ''_WA%'' and file_name(fileid) = ''' + @filename + ''' order by 1,2')
else if @version = '2000'
    exec ('use [' + @db + '] select fileid,pageid,map_block = pageid / 8,extent_number = (pageid / 8) * 8,pgalloc,extent_size,owner = user_name(uid),table_name = object_name(table_id), object_type = case index_id when 0 then ''TABLE'' when 1 then ''CLUSTERED TABLE/INDEX'' when 255 then ''TEXT'' else ''INDEX'' end,index_name = case index_id when 0 then ''N/A'' when 255 then ''N/A'' else c.name end, table_id,index_id from #extent_info8 a, sysobjects b, sysindexes c where a.table_id = b.id and a.table_id = c.id and a.index_id = c.indid and c.name not like ''_WA%'' and file_name(fileid) = ''' + @filename + ''' order by 1,2')
else
    exec ('use [' + @db + '] select fileid,pageid,map_block = pageid / 8,extent_number = (pageid / 8) * 8,pgalloc,extent_size,owner = schema_name(uid),table_name = object_name(table_id), object_type = case index_id when 0 then ''TABLE'' when 1 then ''CLUSTERED TABLE/INDEX'' when 255 then ''TEXT'' else ''INDEX'' end,index_name = case index_id when 0 then ''N/A'' when 255 then ''N/A'' else c.name end, table_id,index_id from #extent_info9 a, sysobjects b, sysindexes c where a.table_id = b.id and a.table_id = c.id and a.index_id = c.indid and (c.name NOT LIKE ''_WA%'' or c.name is null) and file_name(fileid) = ''' + @filename + ''' order by 1,2')

/*
*****************************************************************************
 * present accompanying grid
******************************************************************************
*/
 
if @version = '7.00'
    exec('use [' + @db + '] select owner = user_name(uid),table_name = object_name(table_id),object_type = case index_id when 0 then ''TABLE'' when 1 then ''CLUSTERED TABLE/INDEX'' when 255 then ''TEXT'' else ''INDEX'' end, index_name = case index_id when 0 then ''N/A'' when 255 then ''N/A'' else c.name end,pages_used = sum(convert(decimal(35,2),pgalloc)), pages_allocated = sum(convert(decimal(35,2),extent_size)), in_extents = count(distinct (pageid / 8) * 8), table_id,index_id from #extent_info7 a, sysobjects b, sysindexes c where a.table_id = b.id and a.table_id = c.id and a.index_id = c.indid and c.name not like ''_WA%'' and file_name(fileid) = ''' + @filename + ''' group by b.uid,object_name(table_id),index_id,c.name,table_id order by 1,2,9')
else if @version = '2000'
    exec('use [' + @db + '] select owner = user_name(uid),table_name = object_name(table_id),object_type = case index_id when 0 then ''TABLE'' when 1 then ''CLUSTERED TABLE/INDEX'' when 255 then ''TEXT'' else ''INDEX'' end, index_name = case index_id when 0 then ''N/A'' when 255 then ''N/A'' else c.name end,pages_used = sum(convert(decimal(35,2),pgalloc)), pages_allocated = sum(convert(decimal(35,2),extent_size)), in_extents = count(distinct (pageid / 8) * 8), table_id,index_id from #extent_info8 a, sysobjects b, sysindexes c where a.table_id = b.id and a.table_id = c.id and a.index_id = c.indid and c.name not like ''_WA%'' and file_name(fileid) = ''' + @filename + ''' group by b.uid,object_name(table_id),index_id,c.name,table_id order by 1,2,9')
else
    exec('use [' + @db + '] select owner = schema_name(uid),table_name = object_name(table_id),object_type = case index_id when 0 then ''TABLE'' when 1 then ''CLUSTERED TABLE/INDEX'' when 255 then ''TEXT'' else ''INDEX'' end, index_name = case index_id when 0 then ''N/A'' when 255 then ''N/A'' else c.name end,pages_used = sum(convert(decimal(35,2),pgalloc)), pages_allocated = sum(convert(decimal(35,2),extent_size)), in_extents = count(distinct (pageid / 8) * 8), table_id,index_id from #extent_info9 a, sysobjects b, sysindexes c where a.table_id = b.id and a.table_id = c.id and a.index_id = c.indid and (c.name NOT LIKE ''_WA%'' or c.name is null) and file_name(fileid) = ''' + @filename + ''' group by b.uid,object_name(table_id),index_id,c.name,table_id order by 1,2,9')
 
/*
*****************************************************************************
 * present extent/space overview
******************************************************************************
*/
 
if @version = '7.00'
    exec ('use [' + @db + '] select table_extents = (select count(distinct (pageid / 8) * 8) from #extent_info7 where index_id in (0,1) and file_name(fileid) = ''' + @filename + '''),index_extents = (select count(distinct (pageid / 8) * 8) from #extent_info7 where index_id > 1 and index_id < 255 and file_name(fileid) = ''' + @filename + '''),text_extents = (select count(distinct (pageid / 8) * 8) from #extent_info7 where index_id = 255 and file_name(fileid) = ''' + @filename + ''')')
else if @version = '2000'
    exec ('use [' + @db + '] select table_extents = (select count(distinct (pageid / 8) * 8) from #extent_info8 where index_id in (0,1) and file_name(fileid) = ''' + @filename + '''),index_extents = (select count(distinct (pageid / 8) * 8) from #extent_info8 where index_id > 1 and index_id < 255 and file_name(fileid) = ''' + @filename + '''),text_extents = (select count(distinct (pageid / 8) * 8) from #extent_info8 where index_id = 255 and file_name(fileid) = ''' + @filename + ''')')
else
    exec ('use [' + @db + '] select table_extents = (select count(distinct (pageid / 8) * 8) from #extent_info9 where index_id in (0,1) and file_name(fileid) = ''' + @filename + '''),index_extents = (select count(distinct (pageid / 8) * 8) from #extent_info9 where index_id > 1 and index_id < 255 and file_name(fileid) = ''' + @filename + '''),text_extents = (select count(distinct (pageid / 8) * 8) from #extent_info9 where index_id = 255 and file_name(fileid) = ''' + @filename + ''')')
    
/* clean up */
 
if @version = '7.00'
    drop table #extent_info7
else if @version = '2000' 
    drop table #extent_info8
else
    drop table #extent_info9
    
  RETURN(0)
END

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_025_list_db_map_files]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-07-30			*/
--Objetivo:--Lista map de area total dos bancos
--exec [dbo].[prc1_Ase_025_list_db_map_files]1,0
/********************************************************************************/
CREATE PROCEDURE [dbo].[prc1_Ase_025_list_db_map_files]
                 @major int=1,
                 @minor int=0
--with encryption
AS
declare @db_name sysname,
        @version varchar(4),
        @testamt float
BEGIN
set nocount on
/*
*****************************************************************
* create worktable
*****************************************************************
*/
 
create table #file_info
(dbname sysname NULL,
 groupid int NULL,
 groupname sysname NULL,
 logicname nchar(128) NULL,
 filename nchar(260) NULL,
 filestatus int NULL,  /* to get data or log */
 file_size float NULL,
 file_max_size float NULL,
 file_growth_size float NULL)
 
/*
**************************************************************
* Get server version and set cursor up for databases (only non-
* suspect).
****************************************************************
*/
 
SET NOCOUNT ON
 
select @version = substring(@@version,23,4)
if @version = '7.00'
    declare db_cursor cursor for
            select name
            from master..sysdatabases
            where databaseproperty(name,N'IsShutdown') <> 1 and
                  databaseproperty(name,N'IsInRecovery') <> 1 and
                  databaseproperty(name,N'IsNotRecovered') <> 1 and 
                  databaseproperty(name,N'IsOffline') <> 1 and
                  databaseproperty(name,N'IsSuspect') <> 1 and 
				  has_dbaccess(name) = 1
else
    exec ('declare db_cursor cursor for select name from master..sysdatabases where databasepropertyex(name,''status'') not in (''SUSPECT'', ''OFFLINE'', ''RESTORING'', ''RECOVERING'') and has_dbaccess(name) = 1')
 
open db_cursor
fetch db_cursor into @db_name
 
while @@fetch_status = 0
begin
 
/*
*****************************************************************
* gather base filegroup/file stats
*****************************************************************
*/
 
insert into #file_info
(      dbname,
       groupid,
       groupname,
       logicname,
       filename,
       filestatus,
       file_size,
       file_max_size,
       file_growth_size)
exec ('use [' + @db_name + '] select db_name = db_name(),b.groupid,a.groupname,b.name,b.filename,b.status,b.size,b.maxsize,b.growth from  sysfilegroups a right outer join sysfiles b on a.groupid = b.groupid')
 
fetch db_cursor into @db_name
 
end
 
/* show file info */
 
select  dbname,
        rtrim(logicname) 'logicname',
        file_group = rtrim(case 
        when groupname IS NULL then 'LOG'
        else groupname
        end),
       rtrim(filename) 'filename',
       size_in_mb = convert(decimal(35,2),((file_size * 8) / 1024)),
       can_grow = case file_growth_size
                   when 0 then 'No'
                   else 'Yes'
                  end,
       growth_amount = case (filestatus&0x100000)
                        when 0x100000 then convert(varchar(50),file_growth_size) + '%'
                        else convert(varchar(50),(file_growth_size * 8) / 1024) + 'MB'
                       end,
       max_file_size_mb = case(file_max_size)
                           when -1 then 'UNLIMITED'
                           else convert(varchar(50),((file_max_size * 8) / 1024))
                          end
from   #file_info
order by 1

deallocate db_cursor
drop table #file_info
 
  RETURN(0)
END
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_026_list_map_index_space]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-07-30			*/
--Objetivo:
--Lista map de area dos indices geral banco informado
--exec [dbo].[prc1_Ase_026_list_map_index_space]1,0,X1DBSQL
/********************************************************************************/
CREATE PROCEDURE [dbo].[prc1_Ase_026_list_map_index_space]
    @major int=1,
    @minor int=0,
    @db sysname,
    @filegroup sysname = '',
    @index_owner sysname = ''
--with encryption
AS
declare @total_db_space_kb decimal(28,0),
        @sql varchar(2000)
 
BEGIN
set nocount on
/*
*********************************************************************
* create worktable
*********************************************************************
*/
 
create table #index_info
(owner sysname NULL,
 tablename sysname NULL,
 indexname sysname NULL,
 indid int NULL,
 partition_number int NULL,
 file_group nchar(128) NULL,
 index_reserved decimal(28,0) NULL,
 index_used decimal(28,0) NULL)
 
create table #db_space
(dbspace decimal(28,0) NULL)
 
/*
*********************************************************************
* gather base index space info
*********************************************************************
*/
 
select @sql = 'use [' + @db + '] SELECT    SCHEMA_NAME(d.schema_id),
               d.name,
               a.name,
               a.index_id,
               b.partition_number,
               FILEGROUP_NAME(c.data_space_id),
               sum(c.total_pages),
               sum(c.data_pages)
            FROM    sys.indexes a,
                    sys.partitions b,
                    sys.allocation_units c,
                    sys.tables d
            WHERE   a.object_id = d.object_id and
                    a.object_id = b.object_id and
                    a.index_id = b.index_id and
                    d.type = ''U'' and
                    (b.index_id > 0 and
                    b.index_id < 255) and
                    b.partition_id = c.container_id and
                    (upper(a.name) not like ''_WA_SYS_%'' and
                    a.name <> ''queue_clustered_index'' and
                    a.name <> ''queue_secondary_index'') '
 
if @filegroup = '' 
    begin
        select @sql = @sql
    end        
    else
    begin
        select @sql = @sql + ' and filegroup_name(c.data_space_id) = ''' + @filegroup + ''''
    end
 
if @index_owner = '' 
    begin
        select @sql = @sql
    end        
    else
    begin
        select @sql = @sql + ' and user_name(d.schema_id) = ''' + @index_owner + ''''
    end

select @sql = @sql + ' group by SCHEMA_NAME(d.schema_id),
                           d.name,
                           a.name,
                           a.index_id,
                           b.partition_number,
                           FILEGROUP_NAME(c.data_space_id)'
 
insert into #index_info exec (@sql)
 
/*
*********************************************************************
* get total space (in kb) of database
*********************************************************************
*/
 
insert into #db_space exec ('use [' + @db + '] select total_space = 1024 * (select sum(convert(decimal(35,2),size)) / convert( float, (1048576 / (select low from master.dbo.spt_values where number = 1 and type = ''E''))) from dbo.sysfiles) - (1024 * (select sum(convert(decimal(35,2),size)) / convert( float, (1048576 / (select low from master.dbo.spt_values where number = 1 and type = ''E''))) from dbo.sysfiles where (status & 0x40)=0x40))' )
 
select @total_db_space_kb = dbspace from #db_space
/*
*********************************************************************
* present table space info
*********************************************************************
*/
 
select owner,
       tablename,
       indexname,
       index_type = case indid
        when 1 then 'Clustered'
        else 'Non-Clustered'
        end,
       partition_number,
       rtrim(file_group) 'file_group',
       index_reserved_kb = index_reserved * 8,
       index_used_kb = index_used * 8,
       index_free_kb = (index_reserved * 8) - (index_used * 8),
       pct_index_used = convert(decimal(35,2),100 * (index_used * 8)/
(case(index_reserved) when 0 then 1 else index_reserved * 8 end)),
       pct_of_database = convert(decimal(35,2),100 * ((index_reserved * 8) / @total_db_space_kb))
from   #index_info
order by 1,2,3,5

 
drop table #index_info
drop table #db_space
 
  RETURN(0)
END

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_027_list_server_overview]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-07-30			*/
/*
*********************************************************************
* calculates the space information for storage overview 
*********************************************************************
*/
--exec [dbo].[prc1_Ase_027_list_server_overview]1,0
/********************************************************************************/
CREATE PROCEDURE [dbo].[prc1_Ase_027_list_server_overview]
                 @major int=1,
                 @minor int=0

--with encryption
AS
declare @db_name sysname,
        @sp varchar(50),
        @version varchar(4),
        @dbcount int,
        @filecount int,
        @filegcount int
 
/*
***********************************************************************
* Get server version and set cursor up for databases (only non-
* suspect).
***********************************************************************
*/
 
SET NOCOUNT ON
 
select @version = substring(@@version,23,4)
if @version = '7.00'
    declare db_cursor cursor for
            select name
            from master..sysdatabases
            where databaseproperty(name,N'IsShutdown') <> 1 and
                  databaseproperty(name,N'IsInRecovery') <> 1 and
                  databaseproperty(name,N'IsNotRecovered') <> 1 and 
                  databaseproperty(name,N'IsOffline') <> 1 and
                  databaseproperty(name,N'IsSuspect') <> 1 and 
				  has_dbaccess(name) = 1
else
    exec ('declare db_cursor cursor for select name from master..sysdatabases where databasepropertyex(name,''status'') not in (''SUSPECT'', ''OFFLINE'', ''RESTORING'', ''RECOVERING'') and has_dbaccess(name) = 1')
 
/*
***********************************************************************
* Create temporary tables needed to hold space information
***********************************************************************
*/
 
create table #dbspace  (database_name sysname,
                        total_space decimal(35,2),
                        used_db_space decimal(35,2) NULL,
                        total_log_space decimal(35,2))
create table #logspace (database_name sysname,
                        auto_grow int NULL,
                        log_space decimal(35,2),
                        pct_used decimal(35,2) NULL,
                        status int)
create table #dbgrowth  (database_name sysname NULL,
                        auto_grow char(1) NULL)
create table #loggrowth (database_name sysname NULL,
                        auto_grow int NULL)
create table #disk_free (diskname  varchar(50) null,
                         freespace decimal(35,2) null)
create table #sql_space (diskname varchar(50) null,
                         dbname   sysname     null,
                         logspace decimal(35,2) null,
                         sqlspace decimal(35,2) null)
create table #file_count (filecount int null,
                          filegroupcount int null)
 
/* initialize server counters */
select @dbcount = 0
select @filecount = 0
select @filegcount = 0
 
/* get information for disk free space */
 
insert into #disk_free exec ('master.dbo.xp_fixeddrives')
 
/*
**********************************************************************
* Open database cursor and loop through all databases on server to
* collect their database space information
***********************************************************************
*/
 
open db_cursor
fetch db_cursor into @db_name
 
while @@fetch_status = 0
begin
 
    insert into #file_count EXEC ('use [' + @db_name + '] select file_count = (select count(*) from sysfiles), file_group_count = (select count(*) from sysfilegroups)') 
    select @filecount = @filecount + filecount from #file_count
    select @filegcount = @filegcount + filegroupcount from #file_count
    truncate table #file_count
 
    insert into #dbspace (database_name,total_space,used_db_space,total_log_space) EXEC ('use [' + @db_name + '] select db_name = db_name(),total_space = (select sum(convert(real,size)) / convert( real, (1048576 / (select low from master.dbo.spt_values where number = 1 and type = ''E''))) from dbo.sysfiles),total_db_used = (SELECT (SUM(CONVERT(real, case type when 2 then used_pages else data_pages end)) * (select low from master.dbo.spt_values where number = 1 and type = ''E''))/1024/1024 FROM sys.allocation_units),total_log_space = (select sum(convert(real,size)) / convert( real, (1048576 / (select low from master.dbo.spt_values where number = 1 and type = ''E''))) from dbo.sysfiles where (status & 0x40)=0x40)' )
    insert into #dbgrowth (auto_grow) EXEC ('use [' + @db_name + '] select count(*) - ISNULL((select count(*) from sysfiles where growth = 0 and groupid=FILEGROUP_ID(''PRIMARY'')),0) from sysfiles where groupid=FILEGROUP_ID(''PRIMARY'')')
    insert into #loggrowth (auto_grow) EXEC ('use [' + @db_name + '] select count(*) - ISNULL((select count(*) from sysfiles where growth = 0 and (status&0x40)=0x40),0) from sysfiles where (status&0x40)=0x40')
    update #dbgrowth set database_name = @db_name where database_name is NULL
    update #loggrowth set database_name = @db_name where database_name is NULL
 
    insert into #sql_space exec ('use [' + @db_name + '] SELECT UPPER(SUBSTRING(a.filename,1,2)),DB_NAME(),log_space = CASE groupid WHEN 0 THEN SUM(convert(decimal(35,2),size)) ELSE 0 END, sql_space = CASE groupid WHEN 0 THEN 0 ELSE SUM(convert(decimal(35,2),size)) END FROM sysfiles a GROUP BY UPPER(SUBSTRING(a.filename,1,2)),groupid')
 
    fetch db_cursor into @db_name
 
end
 
/*
**********************************************************************
* Get log space information
***********************************************************************
*/
 
insert into #logspace (database_name,log_space,pct_used,status)
select  db_name = a.instance_name,
                log_size_mb = convert(decimal(15,2),a.cntr_value) / 1024,
                log_pct_used = case
                                when a.cntr_value = 0 
                                then 100 
                                else 100 * convert(decimal(15,2),b.cntr_value)/convert(decimal(15,2),a.cntr_value)
                               end,
                status = 0
        from    master..sysperfinfo a,
                master..sysperfinfo b
        where   (a.object_name = 'SQLServer:Databases' or a.object_name like '%$%:Databases%') and
                (b.object_name = 'SQLServer:Databases' or b.object_name like '%$%:Databases%') and
                a.counter_name = 'Log File(s) Size (KB)' and
                b.counter_name = 'Log File(s) Used Size (KB)' and
                a.instance_name <> '_Total' and
                b.instance_name <> '_Total' and
                a.instance_name = b.instance_name
 
/*
***********************************************************************
* Display server overview counts
***********************************************************************
*/
 
select @dbcount = count(*) from master..sysdatabases
select convert(varchar,@dbcount  )
select convert(varchar,@filecount  )
select convert(varchar,@filegcount + @dbcount )
 
select 'Total Database' = sum(convert(decimal(35,2),total_space)) - sum(convert(decimal(35,2),total_log_space)),
       'Total Log' = sum(convert(decimal(35,2),total_log_space))
from   #dbspace a,
       #logspace b
where  a.database_name = b.database_name
 
/*
***********************************************************************
* Display space information for logs
***********************************************************************
*/
 
select database_name = a.database_name,
       total_log_space,
       log_can_grow = case
                       when d.auto_grow > 0 then 'Yes'
                       when d.auto_grow = 0 then 'No'
                      end,
       total_log_space_used = convert(decimal(35,2),(a.total_log_space * (pct_used/100))),
       total_free_log_space = convert(decimal(35,2),(total_log_space - (a.total_log_space * (pct_used/100)))),
       percent_log_used = pct_used
from   #dbspace a,
       #logspace b,
       #loggrowth d
where  a.database_name = b.database_name and
       b.database_name = d.database_name
order by database_name

/*
***********************************************************************
* Display space information for databases
***********************************************************************
*/
 
select database_name = a.database_name,
       total_space,
       total_db_space = total_space - total_log_space,
       db_can_grow = case
                      when c.auto_grow > '0' then 'Yes' else 'No'
                     end,
       total_space_used = case
                           when (total_space - total_log_space) - used_db_space > 0 
                           then convert(decimal(35,2),(used_db_space + (a.total_log_space * (pct_used/100))))
                           else convert(decimal(35,2),((total_space - total_log_space) + (a.total_log_space * (pct_used/100))))
                          end,
       total_db_space_used = case
                              when (total_space - total_log_space) - used_db_space > 0 
                              then used_db_space
                              else total_space - total_log_space
                             end,
       total_free_space = case
                           when (total_space - total_log_space) - used_db_space > 0 
                           then convert(decimal(35,2),(total_space - (used_db_space + (a.total_log_space * (pct_used/100)))))
                           else convert(decimal(35,2),(total_space - ((total_space - total_log_space) + (a.total_log_space * (pct_used/100)))))
                          end,
       total_free_db_space = case
                              when (total_space - total_log_space) - used_db_space > 0 
                              then (total_space - total_log_space) - used_db_space
                              else 0
                             end,
       percent_db_used = case
                           when (total_space - total_log_space) - used_db_space > 0 
                           then convert(decimal(35,2),(100 * (used_db_space / (total_space - total_log_space)))) 
                           else convert(decimal(35,2),100) 
                          end
from   #dbspace a,
       #logspace b,
       #dbgrowth c
where  a.database_name = b.database_name and
       a.database_name = c.database_name
order by database_name
 

/*
***********************************************************************
* Display information for server hard drives
***********************************************************************
*/
 
SELECT a.diskname, 
               total_sql_mb  = isnull(convert(decimal(35,2),ROUND((SUM(convert(decimal(35,2),b.sqlspace * 8)) / 1024),2)),0),
               total_log_mb  = isnull(convert(decimal(35,2),ROUND((SUM(convert(decimal(35,2),b.logspace * 8)) / 1024),2)),0),
               total_free_mb = isnull(MAX(freespace),0)
         FROM  #disk_free a left outer join #sql_space b
         ON a.diskname + ':' = b.diskname
         GROUP By a.diskname
         ORDER by 1

/*
***********************************************************************
* Clean up work
***********************************************************************
*/
 
deallocate db_cursor
drop table #dbspace
drop table #logspace
drop table #dbgrowth
drop table #loggrowth
drop table #disk_free
drop table #sql_space
drop table #file_count

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_028_list_table_space]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-07-31			*/
/*
*********************************************************************
* This stored procedure calculates the table space 
*********************************************************************
*/
--exec [dbo].[prc1_Ase_028_list_table_space]1,0,x1dbsql
/********************************************************************************/
CREATE PROCEDURE [dbo].[prc1_Ase_028_list_table_space]
    @major int=1,
    @minor int=0,
    @db sysname,
    @filegroup sysname = '',
    @table_owner sysname = ''
--with encryption
AS
declare @total_db_space_kb decimal(28,0),
        @sql varchar(2000)
 
BEGIN
set nocount on
/*
*********************************************************************
* create worktable
*********************************************************************
*/
 
create table #table_info
(owner sysname NULL,
 tablename sysname NULL,
 partition_number int NULL,
 file_group nchar(128) NULL,
 table_rows int NULL,
 table_reserved decimal(28,0) NULL,
 table_used decimal(28,0) NULL)
 
create table #db_space
(dbspace decimal(28,0) NULL)
 
/*
*********************************************************************
* gather base table space info
*********************************************************************
*/
 
select @sql = 'use [' + @db + '] SELECT     SCHEMA_NAME(a.schema_id),
                                                a.name,
                                                b.partition_number,
                                                FILEGROUP_NAME(c.data_space_id),
                                                max(b.rows),
                                                table_reserved = SUM(c.total_pages),
                                                table_used = SUM(case c.type when 2 then c.used_pages else c.data_pages end)
                                        FROM    sys.tables a,
                                                sys.partitions b,
                                                sys.allocation_units c 
                                        WHERE   a.object_id = b.object_id and
                                                b.partition_id = c.container_id and
                                                a.type in (''U'',''S'') and
                                                b.index_id in (0,1,255) '

 
if @filegroup = '' 
    begin
        select @sql = @sql
    end        
    else
    begin
        select @sql = @sql + ' and filegroup_name(c.data_space_id) = ''' + @filegroup + ''''
    end
 
if @table_owner = '' 
    begin
        select @sql = @sql
    end        
    else
    begin
        select @sql = @sql + ' and SCHEMA_NAME(a.schema_id) = ''' + @table_owner + ''''
    end
        
select @sql = @sql + ' group by SCHEMA_NAME(a.schema_id),a.name,partition_number,filegroup_name(c.data_space_id)'
insert into #table_info exec (@sql)
 
/*
*********************************************************************
* get total space (in kb) of database
*********************************************************************
*/
 
insert into #db_space exec ('use [' + @db + '] select total_space = 1024 * (select sum(convert(decimal(35,2),size)) / convert( float, (1048576 / (select low from master.dbo.spt_values where number = 1 and type = ''E''))) from dbo.sysfiles) - (1024 * (select sum(convert(decimal(35,2),size)) / convert( float, (1048576 / (select low from master.dbo.spt_values where number = 1 and type = ''E''))) from dbo.sysfiles where (status & 0x40)=0x40))' )
 
select @total_db_space_kb = dbspace from #db_space
/*
*********************************************************************
* present table space info
*********************************************************************
*/
 
select owner = isnull(owner,'Unknown'),
       tablename,
       partition_number,
       file_group = rtrim(case 
       when file_group IS NULL then 'LOG' 
       else file_group
       end),
       table_rows,
       table_reserved_kb = sum(convert(decimal(35,2),table_reserved * 8)),
       table_used_kb = sum(convert(decimal(35,2),table_used * 8)),
       table_free_kb = sum(convert(decimal(35,2),table_reserved * 8)) - sum(convert(decimal(35,2),table_used * 8)),
       pct_table_used = convert(decimal(35,2),100 * (sum(convert(decimal(35,2),table_used * 8)))/
                        (sum(case(table_reserved) when 0 then 1 else convert(decimal(35,2),table_reserved) end * 8))), 
       pct_of_database = convert(decimal(35,2),100 * (sum(convert(decimal(35,2),table_reserved * 8)) / @total_db_space_kb))
from   #table_info
group by owner, tablename, partition_number, file_group,table_rows
order by 1,2,3
 
 
drop table #table_info
drop table #db_space
 
  RETURN(0)
END

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_029_list_table_space_reorg]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-07-30			*/
/*
*********************************************************************
* This stored procedure calculates the table space reorganization
*********************************************************************
*/
--exec [dbo].[prc1_Ase_029_list_table_space_reorg]1,0,x1dbsql
/********************************************************************************/
CREATE PROCEDURE [dbo].[prc1_Ase_029_list_table_space_reorg]
                 @major int=1,
                 @minor int=0,
                 @db_name  sysname,
                 @mode varchar(8)='DETAILED',
                 @file_group sysname='',
                 @owner sysname='',
                 @forrecpct int = -1,
                 @avgpagedens int = -1
--with encryption
as

declare @sql varchar(2000)
 
SET NOCOUNT ON
 
/********************************************************************
  * Display any tables with fragmentation problems.
  *********************************************************************
  */

declare @dbid int
select @dbid = db_id(@db_name)
 
select @sql = 'use [' + @db_name + '] select  owner = isnull(user_name(b.schema_id),''Unknown''),
        TableName = object_name(a.object_id),
        a.partition_number,
        filegroup = filegroup_name(d.data_space_id),
        record_count,
        forwarded_record_count,
        Forrec_pct = convert(decimal(35,2),100 * (convert(decimal(35,2),forwarded_record_count) / case record_count when 0 then 1 else convert(decimal(35,2),record_count) end)),
        avg_page_space_used_in_percent,
        min_record_size_in_bytes,
        max_record_size_in_bytes,
        avg_record_size_in_bytes,
        page_count,
        ghost_record_count,
        version_ghost_record_count
from    sys.dm_db_index_physical_stats (' + convert(varchar(5),@dbid) + ', NULL,NULL,NULL,''' + @mode + ''') a,
        sys.tables b,
        sys.partitions c,
        sys.allocation_units d
where   index_type_desc in (''Heap'') and
        b.object_id = c.object_id and
        c.partition_id = d.container_id and
        b.type in (''U'',''S'') and
        c.index_id = 0 and
        object_name(a.object_id) = b.name and
        c.partition_number = a.partition_number and
        d.type = 1 '  

if @file_group <> ''
   begin
      select @sql = @sql + ' and filegroup_name(d.data_space_id) = ''' + @file_group + ''''
   end
 
if @owner <> ''
   begin
      select @sql = @sql + ' and user_name(b.schema_id) = ''' + @owner + ''''
   end
 
if @forrecpct >= 0
   begin
      select @sql = @sql + ' and convert(decimal(35,2),100 * (convert(decimal(35,2),forwarded_record_count) / case record_count when 0 then 1 else convert(decimal(35,2),record_count) end)) >= ' + convert(varchar,@forrecpct) + ' '
   end
if @avgpagedens >= 0
   begin
      select @sql = @sql + ' and avg_page_space_used_in_percent <= ' + convert(varchar,@avgpagedens) + ' '
   end
 
select @sql = @sql + ' order by 1,2,3'
exec(@sql)

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_030_list_user_workload]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-07-31			*/
/*
*********************************************************************
* This stored procedure list top user workload
*********************************************************************
*/
--exec [dbo].[prc1_Ase_030_list_user_workload]1,0
/********************************************************************************/
CREATE procedure [dbo].[prc1_Ase_030_list_user_workload]( @major int, @minor int )
--with encryption
AS
    set nocount on
    set ARITHABORT off
    set ARITHIGNORE on
    set ANSI_WARNINGS off

    create table #workload (loadtype varchar(50) NULL,
                            spid int NULL,
                            username sysname NULL,
                            pctused decimal(5,2) NULL)

    insert into #workload SELECT TOP 1 'Top I/O Process', spid, user_name = SUSER_SNAME(sid),pct_io_used = convert(decimal(17,2),(100 * (convert(decimal(17,2),physical_io) / (select convert(decimal(17,2),case sum(physical_io) when 0 then 1 else sum(physical_io) end) from master..sysprocesses)))) FROM master..sysprocesses ORDER BY 4 desc
    insert into #workload SELECT TOP 1 'Top CPU Process', spid, user_name = SUSER_SNAME(sid),pct_cpu_used = convert(decimal(17,2),(100 * (convert(decimal(17,2), cpu) / (select convert(decimal(17,2),case sum(cpu) when 0 then 1 else sum(cpu) end) from master..sysprocesses)))) FROM master..sysprocesses ORDER BY 4 desc
    insert into #workload SELECT TOP 1 'Top Memory Process', spid, user_name = SUSER_SNAME(sid),pct_mem_used = convert(decimal(17,2),(100 * (convert(decimal(17,2),memusage) / (select convert(decimal(17,2),case sum(memusage) when 0 then 1 else sum(memusage) end) from master..sysprocesses)))) FROM master..sysprocesses ORDER BY 4 desc
    insert into #workload SELECT TOP 1 'Top Transaction Process', spid, user_name = SUSER_SNAME(sid),pct_tran_used = isnull(convert(decimal(17,2),(100 * (convert(decimal(17,2),open_tran) / (select case when convert(decimal(17,2),sum(open_tran)) = 0 then 1 end from master..sysprocesses)))),0) FROM master..sysprocesses ORDER BY 4 desc

    select loadtype,
           spid,
           username,
           pctused
    from   #workload
    order by 1

    drop table #workload
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_031_list_dbbottlenecks]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-07-31			*/
/*
*********************************************************************
* List dbbottlenecks
*********************************************************************
*/
--exec [dbo].[prc1_Ase_031_list_dbbottlenecks]1,0,1,0
/********************************************************************************/
CREATE PROCEDURE [dbo].[prc1_Ase_031_list_dbbottlenecks] 
                 @major int=1,
                 @minor int=0,
                 @maxdb_pct int,
                 @maxlog_pct int
--with encryption
AS
 
BEGIN
set nocount on
/*
*****************************************
* Declare variables
******************************************
*/
 
DECLARE @DatabaseName    sysname,
        @db_growth     int,
        @log_growth    int,
        @db_shrink     int,
        @db_maxsize      int,
        @log_maxsize     int,
        @db_log_same_dsk int,
        @dummy_cntr      int,
		@maxdb varchar(50),
		@maxlog varchar(50),
        @version varchar(4)
 
create table #db_necks
(database_name sysname NULL,
 db_growth char(3) NULL,
 log_growth char(3) NULL,
 db_shrink char(3) NULL,
 db_maxsize char(3) NULL,
 log_maxsize char(3) NULL)
 
create table #crazy_temp
(c1 int)
 
/*
*******************************************
* Get server version and set cursor up for
* databases (only non-suspect).
*******************************************
*/
 
SET NOCOUNT ON

SELECT @maxdb = CONVERT(VARCHAR(50), @maxdb_pct)
SELECT @maxlog = CONVERT(VARCHAR(50), @maxlog_pct)

select @version = substring(@@version,23,4)
if @version = '7.00'
    declare DatabaseCursor cursor for
            select name
            from master..sysdatabases
            where databaseproperty(name,N'IsShutdown') <> 1 and
				  databaseproperty(name,N'IsInRecovery') <> 1 and
                  databaseproperty(name,N'IsNotRecovered') <> 1 and 
                  databaseproperty(name,N'IsOffline') <> 1 and
                  databaseproperty(name,N'IsSuspect') <> 1 and 
				  has_dbaccess(name) = 1 and
            name not in ('pubs','Northwind','model')
else
    exec ('declare DatabaseCursor cursor for ' +
          'select name from master..sysdatabases ' +
          'where databasepropertyex(name,''status'') not in (''SUSPECT'', ''OFFLINE'', ''RESTORING'', ''RECOVERING'') and has_dbaccess(name) = 1 ' +
          'and name not in (''pubs'',''Northwind'',''model'')')

  OPEN DatabaseCursor
 
  FETCH NEXT FROM DatabaseCursor INTO @DatabaseName
 
  WHILE (@@fetch_status <> -1)
  BEGIN
    IF (@@fetch_status = -2)
       BEGIN
         FETCH NEXT FROM DatabaseCursor
                    INTO @DatabaseName
         CONTINUE
       END
 
 
          BEGIN
 
            /* add to count of no growth databases */
            insert into #crazy_temp EXEC ('use [' + @DatabaseName +
          '] select count(*) - ISNULL((select count(*) from sysfiles ' 
          +
            'where growth = 0 and groupid <> 0),0) ' +
            'from sysfiles where groupid <> 0')
 
            select @db_growth = (select c1 from #crazy_temp)
 
            delete from #crazy_temp
 
            /* add to count of no growth logs */
            insert into #crazy_temp EXEC ('use [' + @DatabaseName +
        '] select count(*) - ISNULL((select count(*) from sysfiles ' +
        'where growth = 0 and (status&0x40)=0x40),0) from sysfiles ' 
        +  'where (status&0x40)=0x40')
 
            select @log_growth = (select c1 from #crazy_temp)
 
            delete from #crazy_temp
 
            /* add to count of no shrink databases */
            if @version = '7.00'
                begin
                    SELECT @db_shrink =
                    convert(int,DATABASEPROPERTY(@DatabaseName, 'IsAutoShrink'))
                    select @db_shrink = (select case @db_shrink when 1 then 0 when 0 then 1 end)
                end
            else
                begin
                    insert into #crazy_temp  
                    EXEC ('use [' + @DatabaseName +
                    '] select convert(int,DATABASEPROPERTYEX(''' +
                    @DatabaseName + ''', ''IsAutoShrink''))')
 
                    select @db_shrink = (select c1 from #crazy_temp)
                    select @db_shrink = (select case @db_shrink when 1 then 0 when 0 then 1 end)
                end
 
            delete from #crazy_temp
 
            /* add to count of database files nearing maxsize limit */
            insert into #crazy_temp EXEC ('use [' + @DatabaseName +
            '] select count(*) from sysfiles where growth > 0 and maxsize <> -1 ' +
            'and status&0x40<>0x40 and (100 * convert(decimal(35,2),size)/maxsize ) > ' + @maxdb)
 
            select @db_maxsize = (select c1 from #crazy_temp)
 
            delete from #crazy_temp
 
            /* add to count of log files nearing maxsize limit */
             insert into #crazy_temp EXEC ('use [' + @DatabaseName +
            '] select count(*) from sysfiles where growth > 0 and maxsize <> -1 ' +
            'and status&0x40=0x40 and (100 * convert(decimal(35,2),size)/maxsize ) > ' + @maxlog)
 
            select @log_maxsize = (select isnull(c1,0) from #crazy_temp)
 
     delete from #crazy_temp
 
          END
/* insert bottleneck information */
 
    insert into #db_necks
    (database_name,
     db_growth,
     log_growth,
     db_shrink,
     db_maxsize,
     log_maxsize)
    values
    (@DatabaseName,
     case @db_growth
     when 0 then 'No'
       else 'Yes'
     end,
     case @log_growth
     when 0 then 'No'
       else 'Yes'
     end,
     case @db_shrink
       when 0 then 'Yes'
       else 'No'
     end,
     case @db_maxsize
       when 0 then 'No'
       else 'Yes'
     end,
     case @log_maxsize
       when 0 then 'No'
       else 'Yes'
     end)
 
    FETCH NEXT FROM DatabaseCursor INTO @DatabaseName
 
  END
/* select query for grid */
 
  select database_name,
     can_db_grow = db_growth,
     can_log_grow = log_growth,
     can_db_shrink = db_shrink,
     db_near_max_size = db_maxsize,
     log_near_max_size = log_maxsize
  from #db_necks
  order by 1
 
/* select query for graph totals */
/* version 1.0 flags no autoshrink, version 1.1 flags with autoshrink */
  if @major=1 and @minor=0 
    select total_db_growth_problems  = (select count(*) from #db_necks where db_growth = 'No'),
         total_log_growth_problems  = (select count(*) from #db_necks where log_growth = 'No'),
         total_db_shrink_problems  = (select count(*) from #db_necks where db_shrink = 'No'),
         total_db_maxsize_problems  = (select count(*) from #db_necks where db_maxsize = 'Yes'),
         total_log_maxsize_problems  = (select count(*) from #db_necks where log_maxsize = 'Yes')
  else
    select total_db_growth_problems  = (select count(*) from #db_necks where db_growth = 'No'),
         total_log_growth_problems  = (select count(*) from #db_necks where log_growth = 'No'),
         total_db_shrink_problems  = (select count(*) from #db_necks where db_shrink = 'Yes'),
         total_db_maxsize_problems  = (select count(*) from #db_necks where db_maxsize = 'Yes'),
         total_log_maxsize_problems  = (select count(*) from #db_necks where log_maxsize = 'Yes')

  DEALLOCATE DatabaseCursor
  drop table #db_necks
  drop table #crazy_temp
 
  RETURN(0)
END

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_032_count_typeNon_null]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2019-07-14					*/
--Objetivo: Conta valores non-null na tabela por coluna
--exec [dbo].[prc1_Ase_032_count_typeNon_null] 'dbo','x1tb_obj_ChangeLog'
/********************************************************************************/
  
CREATE PROC [dbo].[prc1_Ase_032_count_typeNon_null] @Schema sysname, @Table sysname AS
BEGIN

    DECLARE @SQL nvarchar(MAX)

    SET @SQL = N'WITH Counts AS (' + NCHAR(13) + NCHAR(10) + 
            N'    SELECT @Schema AS SchemaName,' + NCHAR(13) + NCHAR(10) +
            N'           @Table AS TableName,' +
            STUFF((SELECT N',' + NCHAR(13) + NCHAR(10) + 
                            N'           COUNT(' + CASE WHEN C.DATA_TYPE IN ('text','image') THEN '1' ELSE QUOTENAME(C.COLUMN_NAME) END + N') AS ' + QUOTENAME(COLUMN_NAME)
                    FROM INFORMATION_SCHEMA.COLUMNS C
                    WHERE C.TABLE_SCHEMA = @Schema
                        AND C.TABLE_NAME = @Table
                        --AND C.DATA_TYPE NOT IN ('text','image')
                    ORDER BY C.ORDINAL_POSITION
                    FOR XML PATH(N''),TYPE).value('.','nvarchar(MAX)'),1,14,N'') + NCHAR(13) + NCHAR(10) + 
            N'    FROM ' + QUOTENAME(@Schema) + N'.' + QUOTENAME(@Table) + N')' + NCHAR(13) + NCHAR(10) + 
            N'SELECT V.ColumnName,' + NCHAR(13) + NCHAR(10) + 
            N'       V.NonNullCount,' + NCHAR(13) + NCHAR(10) + 
            N'       ISC.DATA_TYPE + ISNULL(NULLIF(DT.S,''(*)''),'''') AS Datatype,' + NCHAR(13) + NCHAR(10) +
            N'       K.KeyType' + NCHAR(13) + NCHAR(10) +
            N'FROM Counts C' + NCHAR(13) + NCHAR(10) + 
            N'     CROSS APPLY(VALUES' + STUFF((SELECT N',' + NCHAR(13) + NCHAR(10) + 
                                                        N'                       (N' + QUOTENAME(C.COLUMN_NAME,'''') + N',C.' + QUOTENAME(C.COLUMN_NAME) + N')'
                                                FROM INFORMATION_SCHEMA.COLUMNS C
                                                WHERE C.TABLE_NAME = @Table
                                                  --AND C.DATA_TYPE NOT IN ('text','image')
                                                ORDER BY C.ORDINAL_POSITION
                                                FOR XML PATH(N''),TYPE).value('.','nvarchar(MAX)'),1,26,N'') + N')V(ColumnName,NonNullCount)' + NCHAR(13) + NCHAR(10) +
            N'     JOIN INFORMATION_SCHEMA.COLUMNS ISC ON C.SchemaName = ISC.TABLE_SCHEMA' + NCHAR(13) + NCHAR(10) +
            N'                                        AND C.TableName = ISC.TABLE_NAME' + NCHAR(13) + NCHAR(10) +
            N'                                        AND V.ColumnName = ISC.COLUMN_NAME' + NCHAR(13) + NCHAR(10) + 
            N'     CROSS APPLY (VALUES(''('' + STUFF(CONCAT('','' + CASE ISC.CHARACTER_MAXIMUM_LENGTH WHEN -1 THEN ''MAX'' ELSE CONVERT(varchar(4),ISC.CHARACTER_MAXIMUM_LENGTH) END,' + NCHAR(13) + NCHAR(10)+
            N'                                            '','' + CASE WHEN ISC.DATA_TYPE NOT LIKE ''%int'' THEN CONVERT(varchar(4),ISC.NUMERIC_PRECISION) END,' + NCHAR(13) + NCHAR(10) +
            N'                                            '','' + CASE WHEN ISC.DATA_TYPE NOT LIKE ''%int'' THEN CONVERT(varchar(4),ISC.NUMERIC_SCALE) END,' + NCHAR(13) + NCHAR(10) +
            N'                                            '','' + CASE WHEN ISC.DATA_TYPE NOT IN (''datetime'',''smalldatetime'') THEN CONVERT(varchar(4),ISC.DATETIME_PRECISION) END),1,1,'''') + '')'')) DT(S)' + NCHAR(13) + NCHAR(10) +
            N'     OUTER APPLY(SELECT TC.CONSTRAINT_TYPE AS KeyType ' + NCHAR(13) + NCHAR(10) + 
            N'                 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS TC' + NCHAR(13) + NCHAR(10) + 
            N'                      JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE KCU ON TC.TABLE_SCHEMA = KCU.TABLE_SCHEMA' + NCHAR(13) + NCHAR(10) + 
            N'                                                                  AND TC.TABLE_NAME = KCU.TABLE_NAME' + NCHAR(13) + NCHAR(10) + 
            N'                                                                  AND TC.CONSTRAINT_NAME = KCU.CONSTRAINT_NAME' + NCHAR(13) + NCHAR(10) + 
            N'                 WHERE KCU.COLUMN_NAME = V.ColumnName' + NCHAR(13) + NCHAR(10) + 
            N'                   AND TC.TABLE_SCHEMA = ISC.TABLE_SCHEMA' + NCHAR(13) + NCHAR(10) + 
            N'                   AND TC.TABLE_NAME = ISC.TABLE_NAME) K;';

    PRINT @SQL; --you will need to use the SELECT here if @SQL is over 4,000 characters
    --SELECT @SQL;
    EXEC sp_executesql @SQL, N'@Schema sysname,@Table sysname',@Schema = @Schema, @Table = @Table;
END;
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_033_ShowDown]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2007-11-02 ALT : 2019-07-14					*/
--Objetivo: Lista resultset na vertical
--Parametros :1 Lista Help
--Exemplo:
/*
exec [dbo].[prc1_Ase_033_ShowDown] 1
--------------------------------
SELECT  * 
INTO	#tempwide			
FROM	x1tb_obj_syscat 
 
EXEC [dbo].[prc1_Ase_033_ShowDown]	
              */
/********************************************************************************/
CREATE PROCEDURE [dbo].[prc1_Ase_033_ShowDown] (
	@help	BIT = NULL
)
AS

SET NOCOUNT ON
	-- ------------------------------------------------------------------------
	-- DECLARATION AND TABLE CREATION
	-- ------------------------------------------------------------------------

	DECLARE 
		@Column		VARCHAR(60),		-- the fieldname
		@CurrOrdPos	INT,				-- the order of the column in the table
		@SQL		VARCHAR(1000),		-- dynamic select statement
		@SQ			CHAR(1),			-- single quote
		@MaxTable	VARCHAR(1000),		-- holds the tempwide2 name - the true one stored in tempdb
		@RecordID	INT,				-- each record's number to aid in sorting when more than one record is return
		@DataType	VARCHAR(25),		-- the datatype of the field
		@FieldName	VARCHAR(200)			-- will hold column's name with brackets ready for the SELECT				

	IF OBJECT_ID('tempdb..#tempdown') IS NOT NULL DROP TABLE #tempdown

	CREATE TABLE #tempdown (
		Rec			INT,				-- short column names on purpose so it doesn't take up much 
		Ord			INT,				-- space in final result
		ColumnName	VARCHAR(60),		-- the columnname 
		Data		VARCHAR(7500)		-- the data for the column
	)

	-- ------------------------------------------------------------------------
	-- INITIALIZE
	-- ------------------------------------------------------------------------

	SET @RecordID = 0

	-- CONSTANTS
	SET @SQ = CHAR(39)		-- single quote


	-- ------------------------------------------------------------------------
	-- LOGIC
	-- ------------------------------------------------------------------------ 

	-- print the syntax and usage instructions to the result window
	IF @Help = 1 BEGIN
		PRINT 'Crie o comando INTO #TEMPWIDE no select list antes do from!'
		PRINT ' '
		PRINT 'Example: '
		PRINT ' '
		PRINT ' '
		PRINT 'SELECT * '
		PRINT 'INTO	#tempwide			-- adicione isto a sua QUERY'
		PRINT 'FROM	tabela'
		PRINT ' ' 
		PRINT 'exec prc1_Ase_033_ShowDown	-- adicione isto na linha final'
		PRINT '  '						   
		

		RETURN
	END

	-- Create a new 'wide' table so we can add a RecordID (DIDROCER) which allows muliple records and their fields 
	-- to be grouped together.  DIDROCER is RecordID backwards.  Needed a field name that will have an unlikely
	-- chance of ever being in a real table since it will be excluded from the results displayed vertically.
	SELECT	0 'DIDROCER', *
	INTO	#tempwide2
	FROM	#tempwide

	-- increment the record id for the table
	UPDATE	#tempwide2 SET	@RecordID = DIDROCER = @RecordID + 1

	-- get name of tempwide2 table (the true name in tempdb)
	SET @MaxTable = (	SELECT	MAX(TABLE_NAME) 
						FROM	tempdb.INFORMATION_SCHEMA.TABLES
						WHERE	Table_Name LIKE '%#tempwide2%'
					)

	-- get the min ord position for the first column for my temp table.  Eliminates need for cursor
	SET @CurrOrdPos = ( SELECT	MIN(Ordinal_Position) 
						FROM	tempdb.INFORMATION_SCHEMA.COLUMNS 
						WHERE	Table_Name LIKE '%' + @MaxTable + '%' )


	-- while we have columns in the temp table loop through them and put their data into the 
	-- tempdown table
	WHILE @CurrOrdPos IS NOT NULL BEGIN 

		-- get a column name and the data type
		SELECT	@Column = COLUMN_NAME, @DataType = Data_Type
		FROM	tempdb.INFORMATION_SCHEMA.COLUMNS 
		WHERE	Table_Name LIKE '%' + @MaxTable + '%' 
		AND		Ordinal_Position = @CurrOrdPos 


		IF @Column <> 'DIDROCER' BEGIN		-- if it is not the recordid (spelled backward) row from tempwide2 get the row


			IF @DataType IN ( 'image', 'text' ) BEGIN
				-- 'Size of Data: ' + CONVERT(VARCHAR(15), DATALENGTH([NoteText] )) 
				SET @FieldName = @SQ + 'Size of Data: ' + @SQ + ' + CONVERT(VARCHAR(15), DATALENGTH(' + @FieldName + ')) '
			END ELSE BEGIN
				SET @FieldName = 'CAST( [' + @Column + '] AS VARCHAR(7500) )'			-- the fieldname w/ brackets used in SELECT to display the data
			END

			-- build the insert that will put the data into the tempdown table
			SET @SQL = ' INSERT INTO #tempdown ' 
			SET @SQL = @SQL + 'SELECT didrocer ' + @SQ + 'RecordID' + @SQ + ', '		-- recordid field from tempwide2 table
			SET @SQL = @SQL + CONVERT(VARCHAR(10), @CurrOrdPos) + ', '					-- order of the column
			SET @SQL = @SQL + @SQ + @Column + @SQ + ' ' + @SQ + 'Field' + @SQ + ', '	-- field name 
			SET @SQL = @SQL + @FieldName + @SQ + @Column + @SQ							-- field data
			SET @SQL = @SQL + ' FROM ' + @MaxTable										-- from tempwide2
		END

		--@SQL above looks like this:
		--INSERT INTO #tempdown SELECT DIDROCER 'RecordID', 5, 'UserID' 'Field', [UserID] 'UserID' FROM #tempwide2 {shorten}_____00010000003F
		--PRINT @SQL

		EXEC ( @SQL )		-- run the insert into #tempdown
		
		-- get the next column pos
		SET @CurrOrdPos = ( SELECT	MIN(Ordinal_Position) 
							FROM	tempdb.INFORMATION_SCHEMA.COLUMNS 
							WHERE	Table_Name LIKE '%' + @MaxTable + '%'
								AND Ordinal_Position > @CurrOrdPos)


	END

	-- display the results VERTICALLY!
	SELECT	ColumnName, Data FROM	#tempdown ORDER BY Rec, Ord, ColumnName

	-- clean up
	IF OBJECT_ID('tempdb..#tempdown') IS NOT NULL DROP TABLE #tempdown
	IF OBJECT_ID('tempdb..#tempwide') IS NOT NULL DROP TABLE #tempwide
	IF OBJECT_ID('tempdb..#tempwide2') IS NOT NULL DROP TABLE #tempwide2

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_034_database_analysis]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-07-31			*/
/*
*********************************************************************
* List user_ratio_process
*********************************************************************
*/
--exec [dbo].[prc1_Ase_034_database_analysis]1,0
/********************************************************************************/
create procedure [dbo].[prc1_Ase_034_database_analysis]( @major int, @minor int )
AS
    set nocount on
    set ARITHABORT off
    set ARITHIGNORE on
    set ANSI_WARNINGS off

    select  DB = a.instance_name,
        'DBCC Logical Scans' = a.cntr_value,
        'Transactions/sec' = (select d.cntr_value from master..sysperfinfo d where d.object_name = a.object_name and d.instance_name = a.instance_name and d.counter_name = 'Transactions/sec'),
        'Active Transactions' = (select case when i.cntr_value < 0 then 0 else i.cntr_value end from master..sysperfinfo i where i.object_name = a.object_name and i.instance_name = a.instance_name and i.counter_name = 'Active Transactions'),
        'Bulk Copy Rows' = (select b.cntr_value from master..sysperfinfo b where b.object_name = a.object_name and b.instance_name = a.instance_name and b.counter_name = 'Bulk Copy Rows/sec'),
        'Bulk Copy Throughput' =  (select c.cntr_value from master..sysperfinfo c where c.object_name = a.object_name and c.instance_name = a.instance_name and c.counter_name = 'Bulk Copy Throughput/sec'),
        'Log Cache Reads' = (select e.cntr_value from master..sysperfinfo e where e.object_name = a.object_name and e.instance_name = a.instance_name and e.counter_name = 'Log Cache Reads/sec'),
        'Log Flushes' = (select f.cntr_value from master..sysperfinfo f where f.object_name = a.object_name and f.instance_name = a.instance_name and f.counter_name = 'Log Flushes/sec'),
        'Log Growths' = (select g.cntr_value from master..sysperfinfo g where g.object_name = a.object_name and g.instance_name = a.instance_name and g.counter_name = 'Log Growths'),
        'Log Shrinks' =  (select h.cntr_value from master..sysperfinfo h where h.object_name = a.object_name and h.instance_name = a.instance_name and h.counter_name = 'Log Shrinks')
    from    master..sysperfinfo a
    where   a.object_name like '%Databases%'  and
        a.instance_name <> '_Total' and
        a.counter_name = 'DBCC Logical Scan Bytes/sec'
    order by 1
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_035_database_bottleneck]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-07-31			*/
/*
*********************************************************************
* List database bottleneck
*********************************************************************
*/
--exec [dbo].[prc1_Ase_035_database_bottleneck]1,0
/********************************************************************************/
create procedure [dbo].[prc1_Ase_035_database_bottleneck]( @major int, @minor int )
--with encryption
AS
    set nocount on
    set ARITHABORT off
    set ARITHIGNORE on
    set ANSI_WARNINGS off

    select dbs_without_autocreate_stats = (select count(*) from   master..sysdatabases where  DATABASEPROPERTYEX(name, 'IsAutoCreateStatistics') = 0),
           dbs_without_autoupdate_stats = (select count(*) from   master..sysdatabases where  DATABASEPROPERTYEX(name, 'IsAutoUpdateStatistics') = 0),
           page_splits = (select cntr_value from master..sysperfinfo where object_name like '%Access Methods%' and counter_name = 'Page Splits/sec'),
           extents_allocated = (select cntr_value  from master..sysperfinfo where object_name like '%Access Methods%' and counter_name = 'Extents Allocated/sec'),
           freespace_scans = (select cntr_value  from master..sysperfinfo where object_name like '%Access Methods%' and counter_name = 'FreeSpace Scans/sec')

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_036_backups_detail]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-07-31			*/
/*
*********************************************************************
* List backup details
*********************************************************************
*/
--exec [dbo].[prc1_Ase_036_backups_detail]25,x1dbsql,1,0 
/********************************************************************************/
CREATE PROCEDURE [dbo].[prc1_Ase_036_backups_detail]( @backup_count int=25, @db_name sysname = NULL, @major int, @minor int )
--with encryption
AS
    set nocount on
    set ARITHABORT off
    set ARITHIGNORE on
    set ANSI_WARNINGS off

    declare @sql varchar(2000)

    if @db_name = NULL or LEN(@db_name) = 0
    BEGIN
        set @sql = 'select TOP ' + str( @backup_count ) + ' database_name,
                        backup_start_date,
                        backup_finish_date,
                        backup_type = case type
                            when ''D'' then ''DATABASE''
                            when ''L'' then ''LOG''
                            when ''I'' then ''DATABASE DIFFERENTIAL''
                            when ''F'' then ''FILE GROUP''
                        end,
                        backup_size_kb = convert(float,round((backup_size / 1024),2)),
                        case expiration_date when null then ''None'' else CAST(expiration_date as VARCHAR) end
        from            msdb..backupset
        order by backup_finish_date desc'
    END
    else
    BEGIN
        declare @quotedDB nvarchar(130)
        SET @quotedDB  = QUOTENAME(@db_name, '''')
        set @sql = 'select  TOP ' + str( @backup_count ) + ' database_name,
                        backup_start_date,
                        backup_finish_date,
                        backup_type = case type
                            when ''D'' then ''DATABASE''
                            when ''L'' then ''LOG''
                            when ''I'' then ''DATABASE DIFFERENTIAL''
                            when ''F'' then ''FILE GROUP''
                        end,
                        backup_size_kb = convert(float,round((backup_size / 1024),2)),
                        case expiration_date when null then ''None'' else CAST(expiration_date as VARCHAR) end
        from            msdb..backupset
        where           database_name = ' + @quotedDB + ' order by backup_finish_date desc'
    END
        
    exec( @sql )

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_037_obj_index_det]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-07-31			*/
/*
*********************************************************************
* List index details
*********************************************************************
*/
--exec [dbo].[prc1_Ase_037_obj_index_det][x1dbsql],null,1,0 
/********************************************************************************/
CREATE procedure [dbo].[prc1_Ase_037_obj_index_det]( @db sysname, @objpatt sysname = NULL, @major int, @minor int )
--with encryption
AS
    declare @sql varchar(2000)

    set nocount on
    set ARITHABORT off
    set ARITHIGNORE on
    set ANSI_WARNINGS off
    
    if @db = '' return 0
    
    select  @sql = 'use [' + @db + '] select username = user_name(a.uid),table_name = a.name,index_name = b.name,filegroup = filegroup_name(b.groupid), clustered_index = case INDEXPROPERTY(a.id,b.name,''IsClustered'') when 1 then ''YES'' when 0 then ''NO'' else ''NO'' end, index_unique = case INDEXPROPERTY(a.id,b.name,''IsUnique'') when 1 then ''YES'' when 0 then ''NO'' else ''NO'' end, index_depth = INDEXPROPERTY(a.id,b.name,''IndexDepth''), stats_recompute = case (b.status & 0x1000000) when 0 then ''YES'' else ''NO'' end, b.maxirow, b.xmaxlen from sysobjects a, sysindexes b where a.type = ''U'' and a.id = b.id  and b.indid > 0 and b.indid < 255 and  upper(b.name) not like ''_WA_%'' '
    
    if @objpatt is not null
    begin
        declare @quotedobjpatt nvarchar(130)
        SET @quotedobjpatt  = QUOTENAME('%' + @objpatt + '%', '''')
        select @sql = @sql + ' and b.name like ' + @quotedobjpatt
    end

    select @sql = @sql + ' order by 1,2 '
    exec(@sql)

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_038_list_obj_sum_db]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-07-31			*/
/*
*********************************************************************
* List database sum details
*********************************************************************
*/
--exec [dbo].[prc1_Ase_038_list_obj_sum]1,0 
/********************************************************************************/
CREATE procedure [dbo].[prc1_Ase_038_list_obj_sum_db]( @major int, @minor int )
--with encryption
AS
    declare @db_name sysname,
            @sp varchar(50)

    set nocount on
    set ARITHABORT off
    set ARITHIGNORE on
    set ANSI_WARNINGS off
 
    declare db_cursor cursor local fast_forward for
            select name
            from master..sysdatabases
            where databasepropertyex(name,'status') not in ('SUSPECT', 'OFFLINE', 'RESTORING', 'RECOVERING') and has_dbaccess(name) = 1
 
    create table #dbdetails (database_name sysname NULL,
                             table_count int NULL,
                             index_count int NULL,
                             total_table_reserved float NULL,
                             total_index_reserved float NULL)
 
    open db_cursor
    fetch db_cursor into @db_name
    while @@fetch_status = 0
    begin
        insert into #dbdetails (database_name,table_count,index_count,total_table_reserved,total_index_reserved) EXEC ('USE [' + @db_name + '] select db_name = db_name(), table_count = (select count(*) from sysobjects where type in (''U'',''S'')),index_count = (select count(*) from sysindexes where indid > 0 and indid < 255 and name not like ''_WA_%''),table_pages = isnull((select sum(reserved) from sysindexes a where a.indid in (0,1,255)),0),index_pages = isnull((select sum(reserved) from sysindexes b where b.indid >1 and b.indid < 255 and name not like ''_WA_%''),0)')
        fetch db_cursor into @db_name
    end
 
    deallocate db_cursor
 
    select database_name,
           table_count,
           index_count,
           table_reserved_mb = case e.total_table_reserved
                                  when NULL then 0
                                  else convert(decimal(17,2),((e.total_table_reserved * 8) / 1024))  end -
                                     case e.total_index_reserved
                                        when NULL then 0
                                        else convert(decimal(17,2),((e.total_index_reserved * 8) / 1024))
                               end,
           index_reserved_mb = case e.total_index_reserved
                                  when NULL then 0
                                  else convert(decimal(17,2),((e.total_index_reserved * 8) / 1024))
                               end
    from   #dbdetails e
    order by database_name
    
    drop table #dbdetails

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_039_list_obj_sum_table]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-07-31			*/
/*
*********************************************************************
* List table details
*********************************************************************
*/
--exec [dbo].[prc1_Ase_039_list_obj_sum_table] [x1dbsql],null,1,0
/********************************************************************************/
CREATE procedure [dbo].[prc1_Ase_039_list_obj_sum_table]( @db sysname, @objpatt sysname = NULL, @major int, @minor int )
--with encryption
AS
    declare @sql varchar(2000)

    set nocount on
    set ARITHABORT off
    set ARITHIGNORE on
    set ANSI_WARNINGS off
    
    if @db = '' return 0
    
    select @sql = 'use [' + @db + '] select  username = user_name(a.uid),a.name, pinned = case OBJECTPROPERTY(a.id,''TableIsPinned'') when 1 then ''YES'' when 0 then ''NO'' else ''NO'' end, filegroup = filegroup_name(b.groupid),b.rows,clustered_index = case OBJECTPROPERTY(a.id,''TableHasClustIndex'') when 1 then ''YES'' when 0 then ''NO'' else ''NO'' end, index_count = (select count(*) from sysindexes c where c.indid > 0 and c.indid < 255 and c.id = a.id and upper(c.name) not like ''_WA_SYS_%''),has_fk_constraints = case OBJECTPROPERTY(a.id,''TableHasForeignKey'') when 1 then ''YES'' when 0 then ''NO'' else ''NO'' end,  has_ck_constraints = case OBJECTPROPERTY(a.id,''TableHasCheckCnst'') when 1 then ''YES''  when 0 then ''NO'' else ''NO''  end, has_identity = case OBJECTPROPERTY(a.id,''TableHasIdentity'') when 1 then ''YES'' when 0 then ''NO'' else ''NO'' end from sysobjects a, sysindexes b where a.type = ''U'' and a.id = b.id  and b.indid in (0,1) ' 
    
    if @objpatt is not null
    begin
        declare @quotedobjpatt nvarchar(130)
        SET @quotedobjpatt  = QUOTENAME('%' + @objpatt + '%', '''')
        select @sql = @sql + ' and a.name like ' + @quotedobjpatt 
    end

    select @sql = @sql + ' order by 1,2 '
    exec(@sql)

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_040_list_workload_analysis]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-07-31			*/
/*
*********************************************************************
* List workload analysis total io/cpu/memory
*********************************************************************
*/
--exec [dbo].[prc1_Ase_040_list_workload_analysis]1,0
/********************************************************************************/
CREATE procedure [dbo].[prc1_Ase_040_list_workload_analysis]( @major int, @minor int )
--with encryption
AS
    set nocount on
    set ARITHABORT off
    set ARITHIGNORE on
    set ANSI_WARNINGS off

    select a.name,
    connections = (select count(*) from master..sysprocesses b where a.dbid = b.dbid),
    blocked_users =  (select count(*) from master..sysprocesses b where a.dbid = b.dbid and blocked <> 0),
    total_memory = isnull((select sum(memusage) from master..sysprocesses b where a.dbid = b.dbid),0),
    total_io = isnull((select sum(physical_io) from master..sysprocesses b where a.dbid = b.dbid),0),
    total_cpu = isnull((select sum(cpu) from master..sysprocesses b where a.dbid = b.dbid),0),
    total_waittime = isnull((select sum(waittime) from master..sysprocesses b where a.dbid = b.dbid),0),
    dbcc_running = isnull((select count(*) from master..sysprocesses b where a.dbid = b.dbid and upper(b.cmd) like '%DBCC%'),0),
    bcp_running = isnull((select count(*) from master..sysprocesses b where a.dbid = b.dbid and upper(b.cmd) like '%BCP%'),0),
    backup_restore_running = isnull((select count(*) from master..sysprocesses b where a.dbid = b.dbid and upper(b.cmd) like '%BACKUP%' or upper(b.cmd) like '%RESTORE%'),0)
    from master..sysdatabases a
    order by a.name

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_041_list_db_storages]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-08-16			*/
/*
*********************************************************************
* List database storages on server 
*********************************************************************
*/
--exec [dbo].[prc1_Ase_041_list_db_storages]
/********************************************************************************/
CREATE procedure [dbo].[prc1_Ase_041_list_db_storages]
--with encryption
AS
    set nocount on
    set ARITHABORT off
    set ARITHIGNORE on
    set ANSI_WARNINGS off
-----------------------------------------------------------------
Create Table ##temp
(
    DatabaseName sysname,
    Name sysname,
    physical_name nvarchar(500),
    size decimal (18,2),
    FreeSpace decimal (18,2)
)   
Exec sp_msforeachdb '
	Use [?];
Insert Into ##temp (DatabaseName, Name, physical_name, Size, FreeSpace)
    Select DB_NAME() AS [DatabaseName], Name,  physical_name,
    Cast(Cast(Round(cast(size as decimal) * 8.0/1024.0,2) as int) as nvarchar) Size,
    Cast(Cast(Round(cast(size as decimal) * 8.0/1024.0,2) as int) -
        Cast(FILEPROPERTY(name, ''SpaceUsed'') * 8.0/1024.0 as int) as nvarchar) As FreeSpace
    From sys.database_files
	where type <> 1
'
-----------------------------------------------------------------
-----------------------------------------------------------------
Select convert(char(30),databasename) as bancos,
       convert(decimal(18,2),sum(size/1024)) AS area_mdf_GB 
	   From ##temp
group by databasename
order by area_mdf_GB desc
----------------------------------------------------------------------
Select convert(decimal(18,2),sum(size/1024)) somatorio_mdf From ##temp  
----------------------------------------------------------------------
drop table ##temp
------------------

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_042_list_ple]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-08-21			*/
/*
*********************************************************************
* List Page life expectancy
*********************************************************************
*/
--exec [dbo].[prc1_Ase_042_list_PLE]
/********************************************************************************/
create procedure [dbo].[prc1_Ase_042_list_ple]
--with encryption
AS
    set nocount on
    set ARITHABORT off
    set ARITHIGNORE on
    set ANSI_WARNINGS off
-----------------------------------------------------------------
 SELECT @@SERVERNAME AS 'INSTANCE',
 [object_name],
 [counter_name],
 CASE
 WHEN [counter_name] = 'Page life expectancy'
 THEN (
 SELECT DATEDIFF(MI, MAX([login_time]), GETDATE())
 FROM sys.dm_exec_sessions DMES
 INNER JOIN sys.dm_exec_requests DMER
 ON [DMES].[session_id] = [DMER].[session_id]
 WHERE [command] = 'LAZY WRITER'
 )
 ELSE ''
 END AS 'UPTIME_MIN',
 [cntr_value] AS 'PLE_SECS',
 [cntr_value] / 60 AS 'PLE_MINS',
 [cntr_value] / 3600 AS 'PLE_HOURS',
 [cntr_value] / 86400 AS 'PLE_DAYS'
 FROM sys.dm_os_performance_counters
 WHERE [object_name] LIKE '%Manager%'
 AND [counter_name] = 'Page life expectancy';
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_043_list_last_backup]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-08-21			*/
/*
*********************************************************************
* List  last SQL Server backup
*********************************************************************
*/
--exec [dbo].[prc1_Ase_043_list_last_backup]
/********************************************************************************/
create procedure [dbo].[prc1_Ase_043_list_last_backup]
--with encryption
AS
    set nocount on
    set ARITHABORT off
    set ARITHIGNORE on
    set ANSI_WARNINGS off
-----------------------------------------------------------------
 SELECT
  DISTINCT
        a.Name AS DatabaseName ,
        CONVERT(SYSNAME, DATABASEPROPERTYEX(a.name, 'Recovery')) RecoveryModel ,
        COALESCE(( SELECT   CONVERT(VARCHAR(12), MAX(backup_finish_date), 101)
                   FROM     msdb.dbo.backupset
                   WHERE    database_name = a.name
                            AND type = 'd'
                            AND is_copy_only = '0'
                 ), 'No Full') AS 'Full' ,
        COALESCE(( SELECT   CONVERT(VARCHAR(12), MAX(backup_finish_date), 101)
                   FROM     msdb.dbo.backupset
                   WHERE    database_name = a.name
                            AND type = 'i'
                            AND is_copy_only = '0'
                 ), 'No Diff') AS 'Diff' ,
        COALESCE(( SELECT   CONVERT(VARCHAR(20), MAX(backup_finish_date), 120)
                   FROM     msdb.dbo.backupset
                   WHERE    database_name = a.name
                            AND type = 'l'
                 ), 'No Log') AS 'LastLog' ,
        COALESCE(( SELECT   CONVERT(VARCHAR(20), backup_finish_date, 120)
                   FROM     ( SELECT    ROW_NUMBER() OVER ( ORDER BY backup_finish_date DESC ) AS 'rownum' ,
                                        backup_finish_date
                              FROM      msdb.dbo.backupset
                              WHERE     database_name = a.name
                                        AND type = 'l'
                            ) withrownum
                   WHERE    rownum = 2
                 ), 'No Log') AS 'LastLog2'
FROM    sys.databases a
        LEFT OUTER JOIN msdb.dbo.backupset b ON b.database_name = a.name
WHERE   a.name <> 'tempdb'
        AND a.state_desc = 'online'
GROUP BY a.Name ,
        a.compatibility_level
ORDER BY a.name
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_044_list_last_proc_exec]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-08-26			*/
/*
*********************************************************************
* List  last proc execution
*********************************************************************
*/
--exec [dbo].[prc1_Ase_044_list_last_proc_exec]
/********************************************************************************/
CREATE procedure [dbo].[prc1_Ase_044_list_last_proc_exec]
--with encryption
AS
    set nocount on
    set ARITHABORT off
    set ARITHIGNORE on
    set ANSI_WARNINGS off
-----------------------------------------------------------------
-----------------------------------------------
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

DECLARE @querysought VARCHAR(256) = '%prc1_Ase_%';

SELECT OBJECT_NAME(st.objectid) AS ObjName, qs.last_execution_time
		, cp.size_in_bytes, cp.usecounts, qp.query_plan
		,cp.cacheobjtype,cp.objtype
		, st.text AS QueryText
		,(SELECT st.text AS [processing-instruction(definition)]
            FROM sys.dm_exec_sql_text(qs.sql_handle) sti
            FOR XML PATH(''), TYPE) AS FormattedSQLText
	FROM sys.dm_exec_query_stats qs
		INNER JOIN sys.dm_exec_cached_plans cp
			ON qs.plan_handle = cp.plan_handle
	CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) st
	OUTER APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
	WHERE OBJECT_NAME(st.objectid) LIKE @querysought
		OR st.text LIKE @querysought
	;

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_045_list_srv_start]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-09-06		*/
/*
*********************************************************************
* List srv starting
*********************************************************************
*/
--exec [dbo].[prc1_Ase_045_list_srv_start]
/********************************************************************************/
CREATE procedure [dbo].[prc1_Ase_045_list_srv_start]
--with encryption
AS
    set nocount on
    set ARITHABORT off
    set ARITHIGNORE on
    set ANSI_WARNINGS off
-----------------------------------------------------------------
DECLARE @starttime datetime
SET @starttime = (SELECT crdate FROM master..sysdatabases WHERE name = 'tempdb' )

DECLARE @currenttime datetime
SET @currenttime = GETDATE()

DECLARE @difference_dd int
DECLARE @difference_hh int
DECLARE @difference_mi int

SET @difference_mi = (SELECT DATEDIFF(mi, @starttime, @currenttime))
SET @difference_dd = (@difference_mi/60/24)
SET @difference_mi = @difference_mi - (@difference_dd*60)*24
SET @difference_hh = (@difference_mi/60)
SET @difference_mi = @difference_mi - (@difference_hh*60)

print 'O serviço do SQL Server foi iniciado: '
+ CONVERT(varchar, @difference_dd) + ' dias '
+ CONVERT(varchar, @difference_hh) + ' horas '
+ CONVERT(varchar, @difference_mi) + ' minutos.' 
-----------------------------------------------------
SELECT  crdate  FROM master..sysdatabases 
where name = 'tempdb'
select LastSvrReboot = DATEADD(SECOND, -1 * (OSI.ms_ticks / 1000), 
GETDATE()),LastSQLRestart = sqlserver_start_time  
 from  sys.dm_os_sys_info OSI
-----------------------------------------------------
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_046_list_srv_adhoc]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-09-06		*/
/*
*********************************************************************
* List Setting Optimize for ad hoc workloads
*********************************************************************
*/
--exec [dbo].[prc1_Ase_046_list_srv_adhoc]
/********************************************************************************/
create procedure [dbo].[prc1_Ase_046_list_srv_adhoc]
--with encryption
AS
    set nocount on
    set ARITHABORT off
    set ARITHIGNORE on
    set ANSI_WARNINGS off
-----------------------------------------------------------------
SELECT objtype AS [Cache Store Type],

        COUNT_BIG(*) AS [Total Num Of Plans],

        SUM(CAST(size_in_bytes as decimal(14,2))) / 1048576 AS [Total Size In MB],

        AVG(usecounts) AS [All Plans – Ave Use Count],

        SUM(CAST((CASE WHEN usecounts = 1 THEN size_in_bytes ELSE 0 END) as decimal(14,2)))/ 1048576 AS [Size in MB of plans with a Use count = 1],

        SUM(CASE WHEN usecounts = 1 THEN 1 ELSE 0 END) AS [Number of of plans with a Use count = 1]

        FROM sys.dm_exec_cached_plans

        GROUP BY objtype

        ORDER BY [Size in MB of plans with a Use count = 1] DESC

 

DECLARE @AdHocSizeInMB decimal (14,2), @TotalSizeInMB decimal (14,2)

 

SELECT @AdHocSizeInMB = SUM(CAST((CASE WHEN usecounts = 1 AND LOWER(objtype) = 'adhoc' THEN size_in_bytes ELSE 0 END) as decimal(14,2))) / 1048576,

        @TotalSizeInMB = SUM(CAST(size_in_bytes as decimal (14,2))) / 1048576

        FROM sys.dm_exec_cached_plans 

 

SELECT @AdHocSizeInMB as [Current memory occupied by adhoc plans only used once (MB)],

         @TotalSizeInMB as [Total cache plan size (MB)],

         CAST((@AdHocSizeInMB / @TotalSizeInMB) * 100 as decimal(14,2)) as [% of total cache plan occupied by adhoc plans only used once]

IF  @AdHocSizeInMB > 200 or((@AdHocSizeInMB / @TotalSizeInMB) * 100) > 25  -- 200MB or > 25%

 

        SELECT 'Switch on Optimize for ad hoc workloads as it will make a significant difference' as [Recommendation]

ELSE

        SELECT 'Setting Optimize for ad hoc workloads will make little difference' as [Recommendation]


GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_047_list_cpu_by_dbase]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-09-06		*/
/*
*********************************************************************
* List uso de cpu por banco
*********************************************************************
*/
--exec [dbo].[prc1_Ase_047_list_cpu_by_dbase]
/********************************************************************************/
create procedure [dbo].[prc1_Ase_047_list_cpu_by_dbase]
--with encryption
AS
    set nocount on
    set ARITHABORT off
    set ARITHIGNORE on
    set ANSI_WARNINGS off
-----------------------------------------------------------------
;WITH DB_CPU_Stats

AS
 (SELECT DatabaseID, DB_Name(DatabaseID) AS [DatabaseName], SUM(total_worker_time) AS [CPU_Time_Ms]
 FROM sys.dm_exec_query_stats AS qs
 CROSS APPLY (SELECT CONVERT(int, value) AS [DatabaseID]
 FROM sys.dm_exec_plan_attributes(qs.plan_handle)
 WHERE attribute = N'dbid') AS F_DB
 GROUP BY DatabaseID)
 SELECT ROW_NUMBER() OVER(ORDER BY [CPU_Time_Ms] DESC) AS [row_num],
 DatabaseName, [CPU_Time_Ms],
 CAST([CPU_Time_Ms] * 1.0 / SUM([CPU_Time_Ms]) OVER() * 100.0 AS DECIMAL(5, 2)) AS [CPUPercent]
 FROM DB_CPU_Stats
 WHERE DatabaseID > 4 -- system databases
 AND DatabaseID <> 32767 -- ResourceDB
 ORDER BY row_num OPTION (RECOMPILE);


GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_048_list_tot_bufferpool]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-09-06		*/
/*
*********************************************************************
* List total de datacache + plancache = Bufferpool
*********************************************************************
*/
--exec [dbo].[prc1_Ase_048_list_tot_bufferpool]
/********************************************************************************/
create procedure [dbo].[prc1_Ase_048_list_tot_bufferpool]
--with encryption
AS
    set nocount on
    set ARITHABORT off
    set ARITHIGNORE on
    set ANSI_WARNINGS off
-----------------------------------------------------------------
 SELECT DB_NAME(database_id) AS [Database Name],
 COUNT(*) * 8/1024 AS [Cached Size (MB)] into #temp
 FROM sys.dm_os_buffer_descriptors
 WHERE database_id > 4 -- system databases
 AND database_id <> 32767 -- ResourceDB
 GROUP BY DB_NAME(database_id)
 ORDER BY [Cached Size (MB)] DESC OPTION (RECOMPILE);

select 'DATA CACHE' as TipoDeMemoria,SUM([Cached Size (MB)]) as TotalEmMB from #temp
 union all
 select 'PLAN CACHE' as TipoDeMemoria,(SUM(cast(size_in_bytes as bigint)) / 1024 / 1024 / 1024) as TotalEmMB
 from sys.dm_exec_cached_plans
 union all
 select 'BUFFER POOL' as TipoDeMemoria,(SUM(cast(size_in_bytes as bigint)) / 1024 / 1024 / 1024) + (SELECT SUM([Cached Size (MB)]) from #temp)
 from sys.dm_exec_cached_plans
 drop table #temp

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_049_list_random_types_values]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-09-06		*/
/*
*********************************************************************
* List VALORES RANDOMICOS PELOS TIPOS 
*********************************************************************
*/
--exec [dbo].[prc1_Ase_049_list_random_types_values]1,10,10
/********************************************************************************/
CREATE procedure [dbo].[prc1_Ase_049_list_random_types_values]
@min INT, @max INT, @rowCnt INT
--with encryption
AS
    set nocount on
    set ARITHABORT off
    set ARITHIGNORE on
    set ANSI_WARNINGS off
-----------------------------------------------------------------
SELECT TOP (@rowCnt)

--ints
RandInt				= ABS(CHECKSUM(NEWID())),									-- Random integer
RandIntMinMaxInc	= (ABS(CHECKSUM(NEWID())) % (@max - @min + 1)) + @min,		-- @min & @max inclusive
RandIntMinIncMaxExc	= (ABS(CHECKSUM(NEWID())) % (@max - @min)) + @min,			-- @min inclusive & @max exclusive
RandIntMinExcMaxInc	= (ABS(CHECKSUM(NEWID())) % (@max - @min)) + @min + 1,		-- @min exclusive & @max inclusive
RandIntMinMaxExc	= (ABS(CHECKSUM(NEWID())) % (@max - @min - 1)) + @min + 1,	-- @min exclusive & @max exclusive

--decimals/floats
RandFloatMinMaxExc	= RAND(CHECKSUM(NEWID())) * (@max - @min ) + @min,			-- min & max exlusive
RandDecMinMaxExc	= CONVERT(DECIMAL(11,2), RAND(CHECKSUM(NEWID())) * (@max - @min ) + @min),-- min & max exlusive (set presicion & scale appropriately)

-- DateTime (3,012,153 is max # of days for datetime, 3,652,058 max days for datetime2)
RandDate	= DATEADD(DAY, ABS(CHECKSUM(NEWID())) % (3012153 + 1), CONVERT(DATETIME, '17530101')), -- Datetime (min = 1753-01-01, max = 9999-12-31)
RandDate2	= DATEADD(DAY, ABS(CHECKSUM(NEWID())) % (3652058 + 1), CONVERT(DATETIME2, '00010101')), -- Datetime2 (min = 0001-01-01, max = 9999-12-31)

-- Bit
RandBit		= CONVERT(BIT, ROUND(RAND(CHECKSUM(NEWID())), 0)),

-- varchar
RandLetter	= SUBSTRING('ABCDEFGHIJKLMNOPQRSTUVWXYZ', 1 + ABS(CHECKSUM(NEWID())) % 26, 1),

-- replicate a random letter a random number of times between @min and @max
RandString	= CONVERT(VARCHAR(MAX), REPLICATE(SUBSTRING('ABCDEFGHIJKLMNOPQRSTUVWXYZ', 1 + ABS(CHECKSUM(NEWID())) % 26, 1),(ABS(CHECKSUM(NEWID())) % (@max - @min + 1)) + @min))

FROM sys.columns A CROSS JOIN sys.columns B CROSS JOIN sys.columns C
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_050_seek_objs]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2007-02-27					*/
-- Description:Localiza qualquer string dentro de objetos nao criptografados
--tipos validos C = Check Constraint
--              D = Default
--             FN = Function
--              P = Procedure
--             TR = Trigger
--              V = View
--Parametros:Texto a pesquisar,flag 'C,D,FN,P,TR,V)
--exec dbo.[prc1_Ase_050_seek_objs] 'instancia','p'
/********************************************************************************/
/********************************************************************************/
create PROCEDURE [dbo].[prc1_Ase_050_seek_objs]
    @find VARCHAR(50) = NULL,
    @type VARCHAR(2) = NULL
--with encryption
    AS

    /* Check for null or invalid input and show custom error. */
    IF @find IS NULL AND @type IS NULL
    BEGIN
    	RAISERROR ('This procedure has two required parameters @find and @type',16,-1)
    	RETURN
    END
    ELSE IF @find IS NULL
    BEGIN
    	RAISERROR ('You must enter a valid like criteria for @find without the leading/ending % wildcard.',16,-1)
    	RETURN
    END
    ELSE IF @type IS NULL OR @type NOT IN ('C','D','FN','P','TR','V')
    BEGIN
    	RAISERROR('No value was entered for @type.
    Valid values for @type are
    	C = Check Constraint
    	D = Default
    	FN = Function
    	P = Procedure
    	TR = Trigger
    	V = View',16,-1)
    	RETURN
    END
    /* Set wildcards on end of find value. */
    SET @find = '%' + @find + '%'
    /* Output object names which contain find value. */
    SELECT DISTINCT OBJECT_NAME([id]) FROM syscomments
    WHERE [id] IN (SELECT [id] FROM sysobjects WHERE xtype = @type AND status >= 0) AND [text] LIKE @find








GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_051_find_unindexed_fk]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2007-11-01	*/
--Objetivo:
-----------------------------------------------------------
--Find unindexed foreign keys
-----------------------------------------------------------
--EXEC dbo.[prc1_Ase_051_find_unindexed_fk]
/********************************************************************************/
CREATE proc [dbo].[prc1_Ase_051_find_unindexed_fk]
as

SET NOCOUNT ON;
SET QUOTED_IDENTIFIER ON;


SELECT  DISTINCT      /* remove dups caused by composite constraints */
        DB_NAME()                                   AS "database_name",
        OBJECT_NAME(foreign_keys.parent_object_id)  AS "table_name",
        foreign_keys."name"                         AS "fk_name"
FROM    sys.foreign_keys                            AS foreign_keys
JOIN	sys.foreign_key_columns                     AS foreign_key_columns
  ON	foreign_keys."object_id" = foreign_key_columns.constraint_object_id
WHERE	NOT EXISTS (
			SELECT	'An index with same columns and column order'
			FROM    sys.indexes                                 AS indexes
			JOIN	sys.index_columns							AS index_columns
			  ON	indexes."object_id" = index_columns."object_id"
			WHERE	foreign_keys.parent_object_id = indexes."object_id"
			  AND	indexes.index_id = index_columns.index_id
			  AND	foreign_key_columns.constraint_column_id = index_columns.key_ordinal
			  AND	foreign_key_columns.parent_column_id = index_columns.column_id
			  AND   OBJECTPROPERTYEX(indexes."object_id",'IsMSShipped') = 0
			  AND   indexes.is_hypothetical = 0
		)

 AND    foreign_keys.is_ms_shipped = 0;







GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_052_list_alloc_pages]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-09-21		*/
--Objetivo: 
 /*** /* List allocation unit,page type, page description */   ***/ 
-- exec [dbo].[prc1_Ase_052_list_alloc_pages] 'x1dbsql','x1tb_obj_ChangeLog'
/********************************************************************************/
CREATE PROCEDURE [dbo].[prc1_Ase_052_list_alloc_pages] @db sysname,@tb sysname
as
SELECT  allocation_unit_type,allocation_unit_type_desc,page_type,page_type_desc,has_ghost_records
 FROM sys.dm_db_database_page_allocations (db_id(@db), object_id(@tb), NULL, NULL, 'DETAILED'); 
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_053_crack_log_operation]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2010-11-28	alt: 2019-07-14			*/
--Objetivo:   Lista operation,context,information on active log.
--exec dbo.[prc1_Ase_053_crack_log_operation] x1tb_obj_ChangeLog
/********************************************************************************/
CREATE procedure [dbo].[prc1_Ase_053_crack_log_operation] @tb sysname
as

set nocount on

SELECT Operation,Context,[Transaction ID],[Log Record Fixed Length],[AllocUnitName],
       [Log Record Length],AllocUnitId,[Page ID],[Num Elements],[Offset in Row],
       [Modify Size],[Number of Locks] INTO #tempwide	 FROM fn_dblog(NULL, NULL)
WHERE [AllocUnitName] = @tb and
      Operation in('LOP_INSERT_ROWS','LOP_MODIFY_ROW','LOP_DELETE_ROWS')
--EXEC prc1_Ase_033_ShowDown;
select * from #tempwide




GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_054_find_activity_sql]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-12-10	*/
--Objetivo:
-----------------------------------------------------------
--This script gets an incremental snapshot of activity for all
--sessions on a SQL server.
-----------------------------------------------------------
--EXEC dbo.[prc1_Ase_054_find_activity_sql]
/********************************************************************************/
create proc [dbo].[prc1_Ase_054_find_activity_sql]
as

SET NOCOUNT ON;
SET QUOTED_IDENTIFIER ON;


DECLARE @snapshot_interval varchar(8) = '00:00:30';

-- Server processes sorted by CPU usage

if object_id('tempdb..#tmpSessions') is not null
  drop table #tmpSessions;

SELECT s.spid AS session_id,
	   s.cpu AS cpu,
	   s.physical_io AS physical_io,
	   s.loginame,
	   s.program_name,
	   s.hostname,
	   s.blocked,
	   s.lastwaittype,
	   s.waitresource,
	   s.waittime,
	   dest.text AS sql_text
  INTO #tmpSessions
  FROM sys.sysprocesses s CROSS APPLY sys.dm_exec_sql_text(s.sql_handle) dest
 WHERE s.spid > 50
OPTION (RECOMPILE);

WAITFOR DELAY @snapshot_interval;

SELECT s.spid AS session_id,
	   s.cpu - ts.cpu AS cpu,
	   s.physical_io - ts.physical_io AS physical_io,
	   ts.lastwaittype,
	   ts.waitresource,
	   ts.waittime,
	   ts.program_name,
	   ts.hostname,
	   ts.blocked,
	   ts.sql_text
  FROM sys.sysprocesses s JOIN dbo.#tmpSessions ts
		ON s.spid = ts.session_id
ORDER BY s.cpu - ts.cpu DESC
OPTION (RECOMPILE);

if object_id('tempdb..#tmpSessions') is not null
    drop table #tmpSessions;
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_055_list_unicode]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-12-10	*/
--Objetivo:
-----------------------------------------------------------
--Lista tabelas com tipo de campos Nchar,Nvarchar,Ntext 
-----------------------------------------------------------
--EXEC dbo.[prc1_Ase_055_list_unicode]
/********************************************************************************/
CREATE proc [dbo].[prc1_Ase_055_list_unicode]
as

SET NOCOUNT ON;
SET QUOTED_IDENTIFIER ON;
begin
SELECT c.object_id, c.column_id, tb.name as tabel_name, c.name as user_name,c.user_type_id,t.name,c.max_length
	  FROM sys.all_columns c	   
	  JOIN sys.tables tb on c.object_id = tb.object_id
	  JOIN sys.objects o on c.object_id = o.object_id
	  ,sys.systypes t
	 WHERE c.user_type_id in(35,99,127,231,239) and  t.xusertype =  c.user_type_id 
	 	 order by tb.name
end;
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_056_calc_area_tbpages]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2004-03-28	- 2011-03-28					*/
--Objetivo:Calcula areas da tabela - Registro por paginas-*/
/*                      numero de extents - Espaço total em disco 
                        */
--Parametros: Tabela,numero de registros
--exec dbo.[prc1_Ase_056_calc_area_tbpages] 'data_audit_columns',10000
/********************************************************************************/

create procedure [dbo].[prc1_Ase_056_calc_area_tbpages] @tab varchar(30),@numreg numeric(18,2)
--with encryption
 as



declare @tottam int
declare @colfix int
declare @colvar int
declare @tamreg int
declare @regpag numeric(18,2)
declare @numpag int
declare @numext int

select @tottam=sum(length) from syscolumns a,sysobjects b where a.id=b.id
and b.name=@tab
select @colfix=count(*) from syscolumns a,sysobjects b,systypes c where
a.id=b.id and c.xusertype=a.xtype and b.name=@tab and variable<>1
select @colvar=count(*) from syscolumns a,sysobjects b,systypes c where
a.id=b.id and c.xusertype=a.xtype and b.name=@tab and variable=1
select @tamreg=@tottam + (@colvar*2) + convert(int,2+((@colfix+7)/8)) + 2 +
4
select @regpag=floor(8096.00/(@tamreg+2))
select @numpag=ceiling(@numreg/@regpag)
select @numext=ceiling(@numpag/8.00)
select 'Tabela'=@tab,'Reg_size'=@tamreg,'Regs página'=@regpag,
	'Num Pages'=@numpag,'Num extents'=@numext,'Espaço total-MB'=@numext*64






GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_057_list_wait_time]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-12-10		*/
--Objetivo:Calcula areas da tabela - Registro por paginas-*/
/* This script gets an incremental snapshot of the overall 
   instance level waits in SQL over a short period of time.
 */
--exec dbo.[prc1_Ase_057_list_wait_time]
/********************************************************************************/
create procedure [dbo].[prc1_Ase_057_list_wait_time]
--with encryption
 as
DECLARE @snapshot_interval varchar(8) = '00:00:10';

-- Server waits

if object_id('tempdb..#tmpWaitStats') is not null
  drop table #tmpWaitStats;

SELECT dows.wait_type,
	   dows.waiting_tasks_count,
	   dows.wait_time_ms,
	   dows.signal_wait_time_ms
  INTO #tmpWaitStats
  FROM sys.dm_os_wait_stats dows
 WHERE [wait_type] NOT IN (
        N'BROKER_EVENTHANDLER', N'BROKER_RECEIVE_WAITFOR', N'BROKER_TASK_STOP',
		N'BROKER_TO_FLUSH', N'BROKER_TRANSMITTER', N'CHECKPOINT_QUEUE',
        N'CHKPT', N'CLR_AUTO_EVENT', N'CLR_MANUAL_EVENT', N'CLR_SEMAPHORE',
        N'DBMIRROR_DBM_EVENT', N'DBMIRROR_EVENTS_QUEUE', N'DBMIRROR_WORKER_QUEUE',
		N'DBMIRRORING_CMD', N'DIRTY_PAGE_POLL', N'DISPATCHER_QUEUE_SEMAPHORE',
        N'EXECSYNC', N'FSAGENT', N'FT_IFTS_SCHEDULER_IDLE_WAIT', N'FT_IFTSHC_MUTEX',
        N'HADR_CLUSAPI_CALL', N'HADR_FILESTREAM_IOMGR_IOCOMPLETION', N'HADR_LOGCAPTURE_WAIT', 
		N'HADR_NOTIFICATION_DEQUEUE', N'HADR_TIMER_TASK', N'HADR_WORK_QUEUE',
        N'KSOURCE_WAKEUP', N'LAZYWRITER_SLEEP', N'LOGMGR_QUEUE', N'ONDEMAND_TASK_QUEUE',
        N'PWAIT_ALL_COMPONENTS_INITIALIZED', N'QDS_PERSIST_TASK_MAIN_LOOP_SLEEP',
        N'QDS_CLEANUP_STALE_QUERIES_TASK_MAIN_LOOP_SLEEP', N'REQUEST_FOR_DEADLOCK_SEARCH',
		N'RESOURCE_QUEUE', N'SERVER_IDLE_CHECK', N'SLEEP_BPOOL_FLUSH', N'SLEEP_DBSTARTUP',
		N'SLEEP_DCOMSTARTUP', N'SLEEP_MASTERDBREADY', N'SLEEP_MASTERMDREADY',
        N'SLEEP_MASTERUPGRADED', N'SLEEP_MSDBSTARTUP', N'SLEEP_SYSTEMTASK', N'SLEEP_TASK',
        N'SLEEP_TEMPDBSTARTUP', N'SNI_HTTP_ACCEPT', N'SP_SERVER_DIAGNOSTICS_SLEEP',
		N'SQLTRACE_BUFFER_FLUSH', N'SQLTRACE_INCREMENTAL_FLUSH_SLEEP', N'SQLTRACE_WAIT_ENTRIES',
		N'WAIT_FOR_RESULTS', N'WAITFOR', N'WAITFOR_TASKSHUTDOWN', N'WAIT_XTP_HOST_WAIT',
		N'WAIT_XTP_OFFLINE_CKPT_NEW_LOG', N'WAIT_XTP_CKPT_CLOSE', N'XE_DISPATCHER_JOIN',
        N'XE_DISPATCHER_WAIT', N'XE_TIMER_EVENT')
	   AND dows.waiting_tasks_count > 0
OPTION(RECOMPILE);

WAITFOR DELAY @snapshot_interval;

SELECT dows.wait_type,
	   dows.waiting_tasks_count - tws.waiting_tasks_count AS waiting_tasks_count,
	   dows.wait_time_ms - tws.wait_time_ms AS total_wait_time_ms,
	   (dows.wait_time_ms - tws.wait_time_ms) / (dows.waiting_tasks_count - tws.waiting_tasks_count) AS avg_wait_time_ms,
	   dows.signal_wait_time_ms - tws.signal_wait_time_ms AS signal_wait_time_ms
  FROM sys.dm_os_wait_stats dows JOIN dbo.#tmpWaitStats tws
		 ON dows.wait_type = tws.wait_type
 WHERE dows.[wait_type] NOT IN (
        N'BROKER_EVENTHANDLER', N'BROKER_RECEIVE_WAITFOR', N'BROKER_TASK_STOP',
		N'BROKER_TO_FLUSH', N'BROKER_TRANSMITTER', N'CHECKPOINT_QUEUE',
        N'CHKPT', N'CLR_AUTO_EVENT', N'CLR_MANUAL_EVENT', N'CLR_SEMAPHORE',
        N'DBMIRROR_DBM_EVENT', N'DBMIRROR_EVENTS_QUEUE', N'DBMIRROR_WORKER_QUEUE',
		N'DBMIRRORING_CMD', N'DIRTY_PAGE_POLL', N'DISPATCHER_QUEUE_SEMAPHORE',
        N'EXECSYNC', N'FSAGENT', N'FT_IFTS_SCHEDULER_IDLE_WAIT', N'FT_IFTSHC_MUTEX',
        N'HADR_CLUSAPI_CALL', N'HADR_FILESTREAM_IOMGR_IOCOMPLETION', N'HADR_LOGCAPTURE_WAIT', 
		N'HADR_NOTIFICATION_DEQUEUE', N'HADR_TIMER_TASK', N'HADR_WORK_QUEUE',
        N'KSOURCE_WAKEUP', N'LAZYWRITER_SLEEP', N'LOGMGR_QUEUE', N'ONDEMAND_TASK_QUEUE',
        N'PWAIT_ALL_COMPONENTS_INITIALIZED', N'QDS_PERSIST_TASK_MAIN_LOOP_SLEEP',
        N'QDS_CLEANUP_STALE_QUERIES_TASK_MAIN_LOOP_SLEEP', N'REQUEST_FOR_DEADLOCK_SEARCH',
		N'RESOURCE_QUEUE', N'SERVER_IDLE_CHECK', N'SLEEP_BPOOL_FLUSH', N'SLEEP_DBSTARTUP',
		N'SLEEP_DCOMSTARTUP', N'SLEEP_MASTERDBREADY', N'SLEEP_MASTERMDREADY',
        N'SLEEP_MASTERUPGRADED', N'SLEEP_MSDBSTARTUP', N'SLEEP_SYSTEMTASK', N'SLEEP_TASK',
        N'SLEEP_TEMPDBSTARTUP', N'SNI_HTTP_ACCEPT', N'SP_SERVER_DIAGNOSTICS_SLEEP',
		N'SQLTRACE_BUFFER_FLUSH', N'SQLTRACE_INCREMENTAL_FLUSH_SLEEP', N'SQLTRACE_WAIT_ENTRIES',
		N'WAIT_FOR_RESULTS', N'WAITFOR', N'WAITFOR_TASKSHUTDOWN', N'WAIT_XTP_HOST_WAIT',
		N'WAIT_XTP_OFFLINE_CKPT_NEW_LOG', N'WAIT_XTP_CKPT_CLOSE', N'XE_DISPATCHER_JOIN',
        N'XE_DISPATCHER_WAIT', N'XE_TIMER_EVENT')
	   AND dows.waiting_tasks_count > 0
	   AND dows.waiting_tasks_count - tws.waiting_tasks_count > 0
ORDER BY 3 DESC
OPTION(RECOMPILE);

if object_id('tempdb..#tmpWaitStats') is not null
  drop table #tmpWaitStats;
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_058_list_file_size]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-12-10		*/
/* Get file sizes of database files and free space on disk
 */
--exec dbo.[prc1_Ase_058_list_file_size]
/********************************************************************************/
create procedure [dbo].[prc1_Ase_058_list_file_size]
--with encryption
 as
DECLARE @ServerVersion varchar(100)
SET @ServerVersion = CONVERT(varchar,SERVERPROPERTY('productversion'))
SET @ServerVersion = LEFT(@ServerVersion, CHARINDEX('.',@ServerVersion, 4)-1)
--PRINT @ServerVersion
DECLARE @command nvarchar(2000)  
    
IF OBJECT_ID('tempdb..#FileData','U') IS NOT NULL
BEGIN
    PRINT 'Dropping #FileData'
    DROP TABLE tempdb..#FileData
END    

CREATE TABLE tempdb..#FileData
(
    [CurrentHost]                   varchar(250) COLLATE Latin1_General_CI_AS NULL,
    [ClusterNodes]                  varchar(250) COLLATE Latin1_General_CI_AS NULL,
    [DB]                            varchar(250) COLLATE Latin1_General_CI_AS NULL,
    [FileType]                      varchar(250) COLLATE Latin1_General_CI_AS NULL,
    [Name]                          varchar(250) COLLATE Latin1_General_CI_AS NULL,
    [VolumeOrDrive]                 varchar(250) COLLATE Latin1_General_CI_AS NULL,
    [FileName]                      varchar(250) COLLATE Latin1_General_CI_AS NULL,
    [File Size (MB)]                decimal(15,2) NULL,
    [Space Used In File (MB)]       decimal(15,2) NULL,
    [Available Space In File (MB)]  decimal(15,2) NULL,
    [Drive Free Space (MB)]         decimal(15,2) NULL
)    
IF CONVERT(float, @ServerVersion) < 10.5 BEGIN --–2000, 2005, 2008

    IF OBJECT_ID('tempdb..#xp_fixeddrives','U') IS NOT NULL
    BEGIN 
        PRINT 'Dropping table #xp_fixeddrives'
        DROP TABLE #xp_fixeddrives;
    END

    CREATE TABLE #xp_fixeddrives
    (
        Drive   varchar(250),
        MBFree  int
    )
    
    INSERT INTO #xp_fixeddrives
    (
        Drive,
        MBFree
    )
    EXEC master..xp_fixeddrives  


    SET @command = '
    USE [?]
    INSERT INTO #FileData
    (
        [CurrentHost],
        [ClusterNodes],
        [DB],
        [FileType],
        [Name],
        [VolumeOrDrive],
        [FileName],
        [File Size (MB)],
        [Space Used In File (MB)],
        [Available Space In File (MB)],
        [Drive Free Space (MB)]
    )
    SELECT CONVERT(varchar(250), SERVERPROPERTY(''ComputerNamePhysicalNetBIOS'')) COLLATE Latin1_General_CI_AS AS  [CurrentHost],
           CONVERT(varchar(250), ISNULL(STUFF((SELECT '', '' + NodeName FROM fn_virtualservernodes() FOR XML PATH('''')), 1, 1, '''' ), '''')) COLLATE Latin1_General_CI_AS AS [CluserNodes],
           CONVERT(varchar(250), DB_NAME())             COLLATE Latin1_General_CI_AS    [DB],
           CONVERT(varchar(250), df.type_desc)          COLLATE Latin1_General_CI_AS    [FileType],
           CONVERT(varchar(250), f.Name)                COLLATE Latin1_General_CI_AS    [Name],
           CONVERT(varchar(250), LEFT(f.FileName, 3))   COLLATE Latin1_General_CI_AS    [VolumeOrDrive],
           CONVERT(varchar(250), f.FileName)            COLLATE Latin1_General_CI_AS    [FileName],
           CONVERT(Decimal(15,2), ROUND(f.Size/128.000, 2))                             [File Size (MB)],
           CONVERT(Decimal(15,2), ROUND(FILEPROPERTY(f.Name,''SpaceUsed'')/128.000,2))  [Space Used In File (MB)],
           CONVERT(Decimal(15,2), ROUND((f.Size-FILEPROPERTY(f.Name,''SpaceUsed''))/128.000,2))  [Available Space In File (MB)],
           CONVERT(Decimal(15,2), d.MBFree) [Drive Free Space (MB)] 
      FROM dbo.sysfiles f WITH (NOLOCK)
     INNER JOIN sys.database_files df ON df.file_id = f.fileid 
      LEFT JOIN tempdb..#xp_fixeddrives d
             ON LEFT(f.FileName, 1) COLLATE Latin1_General_CI_AS = d.Drive COLLATE Latin1_General_CI_AS;'
END
ELSE -- SQL 2008R2+ (function sys.dm_os_volume_stats is available)
BEGIN
    SET @command = 'USE [?]
    INSERT INTO #FileData
    (
        [CurrentHost],
        [ClusterNodes],
        [DB],
        [FileType],
        [Name],
        [VolumeOrDrive],
        [FileName],
        [File Size (MB)],
        [Space Used In File (MB)],
        [Available Space In File (MB)],
        [Drive Free Space (MB)]
    )
    SELECT CONVERT(varchar(250), SERVERPROPERTY(''ComputerNamePhysicalNetBIOS'')) COLLATE Latin1_General_CI_AS AS [CurrentHost],
           CONVERT(varchar(250), ISNULL(STUFF((SELECT '', '' + NodeName FROM fn_virtualservernodes() FOR XML PATH('''')), 1, 1, '''' ), '''')) COLLATE Latin1_General_CI_AS AS [CluserNodes],
           CONVERT(varchar(250), DB_NAME(v.database_id)) COLLATE Latin1_General_CI_AS       [DB],
           CONVERT(varchar(250), df.type_desc)            COLLATE Latin1_General_CI_AS      [FileType],
           CONVERT(varchar(250), f.name)                 COLLATE Latin1_General_CI_AS       [Name],
           CONVERT(varchar(250), v.volume_mount_point)   COLLATE Latin1_General_CI_AS       [VolumeOrDrive],
           CONVERT(varchar(250), f.[Filename])           COLLATE Latin1_General_CI_AS       [Filename],
           CONVERT(Decimal(15,2), ROUND(f.Size/128.000,2))                                  [File Size (MB)],
           CONVERT(Decimal(15,2), ROUND(FILEPROPERTY(f.Name,''SpaceUsed'')/128.000,2))      [Space Used In File (MB)],
           CONVERT(Decimal(15,2), ROUND((f.Size-FILEPROPERTY(f.Name,''SpaceUsed''))/128.000,2))    [Available Space In File (MB)],
           CONVERT(Decimal(15,2), v.available_bytes/1048576.0)                              [Drive Free Space (MB)]
      FROM sys.sysfiles f WITH (NOLOCK)
     INNER JOIN sys.database_files df ON df.file_id = f.fileid 
     CROSS APPLY sys.dm_os_volume_stats(DB_ID(), f.fileid) v;'
END -- END IF

EXEC sp_MSforeachdb @command 

SELECT *
  FROM #FileData

DROP TABLE tempdb..#FileData

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_059_list_process_details]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-12-10		*/
/* Lista detalhes do processo
 */
--exec dbo.[prc1_Ase_059_list_process_details]
/********************************************************************************/
CREATE procedure [dbo].[prc1_Ase_059_list_process_details]
--with encryption
 as
SET NOCOUNT ON;

DECLARE @Today DATETIME 
    ,   @sqlcmd NVARCHAR (MAX)
    ,   @i INT
    ,   @MaxRID INT
    ,   @SPID INT
    
SELECT @Today = GETDATE();

DECLARE @RunTimeInfo TABLE
(
    RID                 INT IDENTITY (1,1) NOT NULL
,   DBName              NVARCHAR (256) NOT NULL
,   blocking_session_id SMALLINT NULL
,   session_id          SMALLINT NOT NULL
,   client_net_address  VARCHAR  (48) NULL
,   hostname            NVARCHAR (256) NULL
,   loginame            NVARCHAR (256) NULL
,   [Duration]          VARCHAR (25) NULL
,   wait_type           NVARCHAR (120) NOT NULL
,   wait_time	        INT NOT NULL
,   wait_resource       NVARCHAR (512) NOT NULL
,   [status]            NVARCHAR (60) NOT NULL
,   [program_name]      NVARCHAR (256) NULL
,   command	            NVARCHAR (32) NOT NULL
,   objectid            INT NULL
,   QueryText           NVARCHAR (MAX) NULL
,   InputBuffer         NVARCHAR (4000) NULL
,   percent_complete    REAL NULL
,   connect_time        DATETIME NOT NULL
,   start_time          DATETIME NOT NULL
,   cpu_time            INT NULL
);

DECLARE @InputBuffer TABLE
(
    EventType NVARCHAR (4000)
,   [PARAMETERS] INT
,   EventInfo NVARCHAR (4000)
)

INSERT INTO @RunTimeInfo
    (DBName, blocking_session_id, session_id, client_net_address, hostname, loginame
    ,[Duration], wait_type, wait_time, wait_resource, [status], [program_name]
    ,command, objectid, QueryText, percent_complete, connect_time, start_time, cpu_time
    )
SELECT  db.Name AS [DBName]
    ,   req.blocking_session_id
    ,   req.session_id
    ,   con.client_net_address
    ,   pro.hostname
    ,   pro.loginame
    ,   CASE WHEN DATEDIFF( HOUR,req.start_time,@Today ) > 24 THEN
                CAST(DATEDIFF( DAY,req.start_time,@Today ) AS VARCHAR(18)) + ' Day(s)'
            ELSE
                RIGHT(REPLICATE('0',2)+CAST( (((DATEDIFF( millisecond,req.start_time,@Today )/1000)/60)/60)%60 AS VARCHAR ),2) +':' --Hours
               +RIGHT(REPLICATE('0',2)+CAST( ((DATEDIFF( millisecond,req.start_time,@Today )/1000)/60)%60 AS VARCHAR ),2) +':'      --Minutes
               +RIGHT(REPLICATE('0',2)+CAST( (DATEDIFF( millisecond,req.start_time,@Today )/1000)%60 AS VARCHAR ),2) +'.'           --Seconds
               +RIGHT(REPLICATE('0',3)+CAST( DATEDIFF( millisecond,req.start_time,@Today )%1000 AS VARCHAR ),3)                     --Milliseconds
        END AS [Duration (hh:mm:ss.nnn)]
    ,   ISNULL(req.wait_type,'') AS wait_type
    ,   req.wait_time
    ,   req.wait_resource
    ,   req.[status]
    ,   pro.[program_name]
    ,   req.command
    ,   txt.objectid
    ,   ISNULL(CAST(OBJECT_NAME(txt.objectid,DB_ID(db.name)) AS NVARCHAR(MAX)),txt.[text]) AS [QueryText]
    ,   req.percent_complete
    ,   con.connect_time
    ,   req.start_time
    ,   cpu_time

FROM    sys.dm_exec_connections con INNER JOIN
        ( SELECT spid
            ,    LTRIM( RTRIM( hostname ) ) AS [hostname]
            ,    LTRIM( RTRIM( loginame ) ) AS [loginame]
            ,    LTRIM( RTRIM( [program_name] ) ) AS [program_name]
          FROM  sys.sysprocesses 
          WHERE ASCII(LTRIM( RTRIM( loginame ) )) IS NOT NULL
        ) pro ON con.session_id = pro.spid INNER JOIN
        sys.dm_exec_requests req ON con.connection_id = req.connection_id INNER JOIN
        sys.databases db ON req.database_id = db.database_id CROSS APPLY
        sys.dm_exec_sql_text( req.[sql_handle] ) AS txt 
        
WHERE   ISNULL(req.wait_type,'') NOT IN 
                             ( 'BAD_PAGE_PROCESS','BROKER_EVENTHANDLER','BROKER_RECEIVE_WAITFOR','BROKER_TASK_STOP'
                              ,'BROKER_TO_FLUSH','BROKER_TRANSMITTER','CHECKPOINT_QUEUE','CHKPT','CLR_SEMAPHORE'
                              ,'DBMIRROR_EVENTS_QUEUE','FT_IFTS_SCHEDULER_IDLE_WAIT','KSOURCE_WAKEUP','LAZYWRITER_SLEEP'
                              ,'LOGMGR_QUEUE','MISCELLANEOUS','ONDEMAND_TASK_QUEUE','REQUEST_FOR_DEADLOCK_SEARCH'
                              ,'RESOURCE_QUEUE','SLEEP_SYSTEMTASK','SLEEP_TASK','SQLTRACE_BUFFER_FLUSH'
                              ,'XE_DISPATCHER_WAIT','XE_TIMER_EVENT','WAITFOR'
                             )
        AND req.session_id != @@SPID 
        
ORDER BY 
        db.Name
    ,   req.session_id;
    
SELECT  @sqlcmd = N'DBCC INPUTBUFFER(@session_id)'
    ,   @i = 0
    ,   @MaxRID = MAX(RID)
FROM    @RunTimeInfo;

WHILE   @i <= @MaxRID
 BEGIN
 
    IF (    SELECT  objectid 
            FROM    @RunTimeInfo 
            WHERE   RID = @i
        ) IS NULL
     BEGIN
        SELECT  @i = @i + 1;
        DELETE  @InputBuffer;
        CONTINUE;
     END
     
    SELECT  @SPID = session_id
    FROM    @RunTimeInfo
    WHERE   RID = @i;
    
    INSERT INTO @InputBuffer
    EXECUTE sp_executesql 
                @sqlcmd
            ,   N'@session_id int'
            ,   @SPID;
    
    UPDATE  @RunTimeInfo
    SET     InputBuffer = (SELECT EventInfo FROM @InputBuffer)
    WHERE   RID = @i;
    
    SELECT @i = @i + 1
    DELETE  @InputBuffer
 END
 insert into x2tb_process
SELECT  DBName
    ,   blocking_session_id
    ,   session_id
    ,   client_net_address
    ,   hostname
    ,   loginame
    ,   [Duration]
    ,   wait_type
    ,   wait_time
    ,   wait_resource
    ,   [status]
    ,   [program_name]
    ,   command
    ,   objectid
    ,   QueryText
    ,   InputBuffer
    ,   percent_complete
    ,   connect_time
    ,   start_time
    ,   cpu_time
FROM    @RunTimeInfo;
select * from x2tb_process;
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_060_list_tbix_details]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-12-17		*/
/* Lista table indexes, size and column order
 */
--exec dbo.[prc1_Ase_060_list_tbix_details]
/********************************************************************************/
CREATE procedure [dbo].[prc1_Ase_060_list_tbix_details]
--with encryption
 as
SET NOCOUNT ON;

SELECT			OBJECT_NAME(i.object_id) AS TableName
				, ISNULL(i.name, 'HEAP') AS IndexName
				, ISNULL(STUFF((SELECT ', ' + QUOTENAME(c2.name) + 
						CASE ic2.is_descending_key
						WHEN 0 THEN ' ASC'
						ELSE ' DESC'
						END						 
						FROM sys.indexes i2 INNER JOIN sys.index_columns ic2
						ON i2.object_id = ic2.object_id AND i2.index_id = ic2.index_id
						INNER JOIN  sys.columns c2 ON ic2.object_id = c2.object_id AND ic2.column_id = c2.column_id						
						WHERE ic2.object_id = i.object_id AND ic2.index_id = i.index_id
						ORDER BY ic2.object_id	 
						FOR XML PATH(N''), TYPE).value(N'.[1]', N'NVARCHAR(MAX)'), 1, 1, N''), 'HEAP') AS IndexColumnOrder
				, i.index_id AS IndexID			
				, i.fill_factor				
				, p.rows AS NumRows			
				, au.total_pages AS NumPages
				, au.total_pages / 128 AS TotMBs
				, au.used_pages / 128 AS UsedMBs
				, au.data_pages / 128 AS DataMBs
FROM sys.indexes i INNER JOIN sys.partitions p 
ON i.object_id = p.object_id AND i.index_id = p.index_id
INNER JOIN sys.allocation_units au ON
CASE 
WHEN au.type IN (1,3) THEN p.hobt_id
WHEN au.type = 2 THEN p.partition_id
END = au.container_id
INNER JOIN sys.objects o ON i.object_id = o.object_id
WHERE o.is_ms_shipped <> 1 AND au.type_desc = 'IN_ROW_DATA'
AND p.partition_number = 1			
ORDER BY OBJECT_NAME(i.object_id), i.index_id

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_061_list_Set_File_Growth]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-12-10		*/
/* Lista Set_File_Growth
 */
--exec dbo.[prc1_Ase_061_list_Set_File_Growth]
/********************************************************************************/
CREATE procedure [dbo].[prc1_Ase_061_list_Set_File_Growth]
(
	@datafilesize_lowerlimit INT,
	@datafilesize_upperlimit INT,
	@datafile_growth_target_lower INT,
	@datafile_growth_target_medium INT,
	@datafile_growth_target_upper INT,
	@logfilesize_lowerlimit INT,
	@logfilesize_upperlimit INT,
	@logfile_growth_target_lower INT,
	@logfile_growth_target_medium INT,
	@logfile_growth_target_upper INT
)
 as
SET NOCOUNT ON;
/*
*************************************************************************************************************
   Examples       : EXEC dbo.prc1_Ase_061_list_Set_File_Growth 400,2000,100,200,500,null,null,null,null,null
                        For Datafiles less than 400 MB, set 100 MB autogrow
	     			    For Datafiles between 400 MB and 2000 MB set 200 MB autogrow
		  			    For Datafiles greater than 2000 MB set 500 MB autogrow
						
 				    EXEC dbo.prc1_Ase_061_list_Set_File_Growth null,null,null,null,null,1000,5000,200,500,1000
                        For Logfiles less than 1000 MB, set 200 MB autogrow
	  		 		    For Logfiles between 1000 MB and 5000 MB set 500 MB autogrow
					    For Logfiles greater than 5000 MB set 1000 MB autogrow
						
                    EXEC dbo.prc1_Ase_061_list_Set_File_Growth 400,2000,100,200,500,1000,5000,200,500,1000
                        Set autogrow for Datafiles AND Logfiles as explained in the 2 previous examples
						
 Version          : 1.0
************************************************************************************************************
*/


SET NOCOUNT ON

PRINT '*********** Parameters ******************'
PRINT 'Datafiles size lower limit     : ' + convert(varchar(20), @datafilesize_lowerlimit) + ' MB'
PRINT 'Datafiles size upper limit     : ' + convert(varchar(20), @datafilesize_upperlimit) + ' MB'
PRINT 'Datafiles growth lower target  : ' + convert(varchar(20), @datafile_growth_target_lower) + ' MB'
PRINT 'Datafiles growth medium target : ' + convert(varchar(20), @datafile_growth_target_medium) + ' MB'
PRINT 'Datafiles growth upper target  : ' + convert(varchar(20), @datafile_growth_target_upper) + ' MB'
PRINT ' '
PRINT 'Logfiles size lower limit      : ' + convert(varchar(20), @logfilesize_lowerlimit) + ' MB'
PRINT 'Logfiles size upper limit      : ' + convert(varchar(20), @logfilesize_upperlimit) + ' MB'
PRINT 'Logfiles growth lower target   : ' + convert(varchar(20), @logfile_growth_target_lower) + ' MB'
PRINT 'Logfiles growth medium target  : ' + convert(varchar(20), @logfile_growth_target_medium) + ' MB'
PRINT 'Logfiles growth upper target   : ' + convert(varchar(20), @logfile_growth_target_upper) + ' MB'
PRINT '*****************************************'

-- Retrieve files informations
DECLARE @sql VARCHAR(8000)
SET @sql=' USE [?]
	SELECT ''?'' [Dbname]
		,[name] [Filename]
		,type_desc [Type]
		,physical_name [FilePath]
		,CONVERT(INT,[size]/128.0) [TotalSize_MB]
		,CONVERT(INT,FILEPROPERTY(name, ''SpaceUsed''))/128.0 AS [Space_Used_MB]
		,CASE is_percent_growth
		WHEN 1 THEN CONVERT(VARCHAR(5),growth)
		ELSE CONVERT(VARCHAR(20),(growth/128))
		END [Autogrow_Value]
		,CASE is_percent_growth
		WHEN 1 THEN ''Pct''
		ELSE ''MB''
		END [Unit]
		,CASE max_size
		WHEN -1 THEN CASE growth
		WHEN 0 THEN CONVERT(VARCHAR(30),''Restricted'')
		ELSE CONVERT(VARCHAR(30),''Unlimited'') END
		ELSE CONVERT(VARCHAR(25),max_size/128)
		END [Max_Size]
	FROM [?].sys.database_files'

-- Create temp table to store Files informations
IF EXISTS(SELECT 1 FROM sysobjects WHERE name='AutogrowthDetails') 
	DROP TABLE AutogrowthDetails
CREATE TABLE   AutogrowthDetails (
	Dbname VARCHAR(128)
	,Filename VARCHAR(128)
	,Type VARCHAR(10)
	,Filepath VARCHAR(2000)
	,TotalSize_MB INT
	,Space_Used_MB INT
	,Autogrow_Value VARCHAR(15)
	,Unit VARCHAR(15)
	,Max_Size VARCHAR(30)
)

INSERT INTO AutogrowthDetails EXEC sp_msforeachdb @sql

DECLARE @dbname varchar(8000)
DECLARE @file varchar(8000)
DECLARE @filename varchar(8000)
DECLARE @type varchar(20)
DECLARE @totalsizemb int
DECLARE @autogrowthvalue varchar(20)
DECLARE @filegrowth_target varchar(20)
DECLARE @sql2 varchar(8000)

-- Set file autogrow value depending on thresholds
DECLARE SetAutogrowthSize cursor for 
	SELECT dbname, filename, type, TotalSize_MB, Autogrow_Value 
	FROM AutogrowthDetails  
	WHERE dbname not in ('master','msdb','tempdb','model')
		AND dbname IN (select name from sys.databases where state_desc = 'ONLINE')
		AND Autogrow_Value <> 0
		AND (
				(
					(TotalSize_MB < @datafilesize_lowerlimit AND Autogrow_Value < @datafile_growth_target_lower and type = 'ROWS') 
					OR 
					((TotalSize_MB BETWEEN @datafilesize_lowerlimit AND @datafilesize_upperlimit) AND Autogrow_Value < @datafile_growth_target_medium AND type = 'ROWS')
					OR
					(TotalSize_MB > @datafilesize_upperlimit  AND Autogrow_Value < @datafile_growth_target_upper AND type = 'ROWS')
				) 
				OR 
				(
					(TotalSize_MB < @logfilesize_lowerlimit AND Autogrow_Value < @logfile_growth_target_lower and type = 'LOG') 
					OR 
					((TotalSize_MB BETWEEN @logfilesize_lowerlimit AND @logfilesize_upperlimit) AND Autogrow_Value < @logfile_growth_target_medium AND type = 'LOG')
					OR
					(TotalSize_MB > @logfilesize_upperlimit AND Autogrow_Value < @logfile_growth_target_upper AND type = 'LOG')
				) 
			)
		ORDER BY dbname, filename

OPEN SetAutogrowthSize
FETCH NEXT FROM SetAutogrowthSize INTO @dbname, @file, @type, @totalsizemb, @autogrowthvalue
WHILE @@FETCH_STATUS = 0
BEGIN
	IF @type = 'ROWS' AND (@totalsizemb < @datafilesize_lowerlimit  AND @autogrowthvalue < @datafile_growth_target_lower) 
		SET @filegrowth_target = @datafile_growth_target_lower
	IF @type = 'ROWS' AND ((@totalsizemb between @datafilesize_lowerlimit AND @datafilesize_upperlimit) AND @autogrowthvalue < @datafile_growth_target_medium)
		SET @filegrowth_target = @datafile_growth_target_medium
	IF @type = 'ROWS' AND ((@totalsizemb = @datafilesize_upperlimit OR @totalsizemb > @datafilesize_upperlimit) AND @autogrowthvalue < @datafile_growth_target_upper)
		SET @filegrowth_target = @datafile_growth_target_upper
	IF @type = 'LOG'  AND (@totalsizemb < @logfilesize_lowerlimit  AND @autogrowthvalue < @logfile_growth_target_lower)
		SET @filegrowth_target = @logfile_growth_target_lower
	IF @type = 'LOG'  AND ((@totalsizemb between @logfilesize_lowerlimit AND @logfilesize_upperlimit) AND @autogrowthvalue < @logfile_growth_target_medium)
		SET @filegrowth_target = @logfile_growth_target_medium
	IF @type = 'LOG'  AND ((@totalsizemb = @logfilesize_upperlimit OR @totalsizemb > @logfilesize_upperlimit) AND @autogrowthvalue < @logfile_growth_target_upper)
		SET @filegrowth_target = @logfile_growth_target_upper

	SET @sql2 = 'ALTER DATABASE ['+ @dbname + '] MODIFY FILE (NAME = '''+@file+''', FILEGROWTH =' +@filegrowth_target + ')'
	 
	Print '********************************************************************************************************************************************'
	Print '| Database Name: ' + @dbname + ' | Logical File Name: ' +  @file + ' | File Type: ' +   @type + ' | Current Size: ' +   convert(varchar(20), @totalsizemb) + ' MB | Current Growth increment: ' +  @autogrowthvalue
	Print '| Process will update filegrowth size from ' + convert(varchar(20), @autogrowthvalue) + ' to ' + convert(varchar(20), @filegrowth_target) + ' MB'
	Print '| Executing following ALTER command: '
	Print '| '+ @sql2
	Print '********************************************************************************************************************************************'
	Print ' '
	exec (@sql2)
	 
	FETCH NEXT FROM SetAutogrowthSize INTO @dbname, @file, @type, @totalsizemb, @autogrowthvalue
END

CLOSE SetAutogrowthSize
DEALLOCATE SetAutogrowthSize
select * from AutogrowthDetails;

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_062_list_objects_cre_del_alt]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-17-10		*/
/* Lista  'Object:Deleted', 'Object:Created', 'Object:Altered' 
 */
--exec dbo.[prc1_Ase_062_list_objects_cre_del_alt]
/********************************************************************************/
create procedure [dbo].[prc1_Ase_062_list_objects_cre_del_alt]
as

SELECT * into  #trc
FROM sys.fn_trace_gettable(( SELECT REVERSE(SUBSTRING(REVERSE(path),
CHARINDEX('\',
REVERSE(path)),
256)) + 'log.trc'
FROM sys.traces
WHERE is_default = 1
), DEFAULT) T
JOIN sys.trace_events TE ON T.EventClass = TE.trace_event_id
WHERE StartTime > DATEADD(mi, -5, GETDATE())
AND TE.name IN ( 'Object:Deleted', 'Object:Created', 'Object:Altered' )
AND DatabaseName = 'x1dbsql';
insert into x2tb_trc
select 
	[DatabaseID],
	[HostName],
	[ApplicationName],
	[LoginName],
	[SPID],
	[StartTime],
	[ObjectID],
	[ServerName],
	[ObjectName],
	[DatabaseName],
	[SessionLoginName],
	[name]
from #trc
select * from x2tb_trc
drop table #trc



GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_063_list_qry_stats]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2015-18-10		*/
/*  Finding Queries IN sys.dm_exec_query_stats.
 */
--exec dbo.[prc1_Ase_063_list_qry_stats]
/********************************************************************************/
CREATE procedure [dbo].[prc1_Ase_063_list_qry_stats]
as
set nocount on
/*****************************************************
Setup a temporary table to fetch the data we need from
sys.dm_exec_query_stats.
******************************************************/
IF OBJECT_ID('tempdb..#temp') IS NOT NULL DROP TABLE #temp
CREATE TABLE #temp
(
 objectid INT,
 dbid INT,
 [Object] VARCHAR(8000),
 [IndividualQuery] NVARCHAR(MAX),
 [TotalRunTime (s)] DECIMAL(28,2),
 [TotalTimeWaiting (s)] DECIMAL(28,2),
 [%TimeRunning] DECIMAL(28,2),
 [%TimeWaiting] DECIMAL(28,2),
 [ExecutionCount] INT,
 [AverageRunTime] DECIMAL(28,2),
 [AverageTimeWaiting (s)] DECIMAL(28,2),
 [DatabaseName] NVARCHAR(MAX),
 [QueryPlan] datetime
)


/*****************************************************
Populate the temporary table with the data we need
from sys.dm_exec_query_stats.
******************************************************/
INSERT INTO #temp
SELECT TOP 20
 qt.objectid,
 qt.dbid,
 [Object] = '',
 [IndividualQuery] = SUBSTRING (qt.text,(qs.statement_start_offset/2) + 1,
 ((CASE WHEN qs.statement_end_offset = -1
 THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
 ELSE qs.statement_end_offset
 END - qs.statement_start_offset)/2) + 1),
 [TotalRunTime (s)] = CAST(qs.total_elapsed_time/ 1000000.0 AS DECIMAL(28,2)),
 [TotalTimeWaiting (s)] = CAST((qs.total_elapsed_time - qs.total_worker_time) / 1000000.0 AS DECIMAL(28,2)),
 [%TimeRunning] = CAST(qs.total_worker_time * 100.0 / qs.total_elapsed_time AS DECIMAL(28,2)),
 [%TimeWaiting] = CAST((qs.total_elapsed_time - qs.total_worker_time)* 100.0 / qs.total_elapsed_time AS DECIMAL(28, 2)),
 [ExecutionCount] = qs.execution_count,
 [AverageRunTime] = CAST(qs.total_elapsed_time / 1000000.0 / qs.execution_count AS DECIMAL(28, 2)),
 [AverageTimeWaiting (s)] = CAST((qs.total_elapsed_time - qs.total_worker_time) / 1000000.0 / qs.execution_count AS DECIMAL(28, 2)),
 [DatabaseName] = DB_NAME(qt.dbid),
 [QueryPlan] = getdate()
FROM
 sys.dm_exec_query_stats qs
 CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) as qt
 CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
WHERE
 qs.total_elapsed_time > 0
 AND DB_NAME(qt.dbid) IS NOT NULL
ORDER BY
 [TotalTimeWaiting (s)] DESC


/*****************************************************
This section of code is all about getting the object
name from the dbid and the object id.
******************************************************/
 
-- Declare a Cursor
DECLARE FetchObjectName CURSOR FOR
 SELECT
 objectid, dbid
 FROM
 #temp
 
-- Open the cursor
OPEN FetchObjectName
 
-- Declare some vars to hold the data to pass into the cursor
DECLARE @var1 INT,
 @var2 INT
DECLARE @sql VARCHAR(MAX)
DECLARE @object VARCHAR(MAX)
 
-- Create a temporary table to hold the result of the dynamic SQL
IF OBJECT_ID('tempdb..#object') IS NOT NULL DROP TABLE #object
CREATE TABLE #object
(
 objectname VARCHAR(MAX)
)
 
-- Loop through the 20 records from above and fetch the object names
FETCH NEXT FROM FetchObjectName INTO @var1, @var2
WHILE ( @@FETCH_STATUS <> -1 )
BEGIN
 IF ( @@FETCH_STATUS <> -2 )
 
 -- Set the SQL we need to execute
 SET @sql = 'USE [' + DB_NAME(@var2) + '];
 SELECT OBJECT_SCHEMA_NAME(' + CONVERT(VARCHAR(MAX),@var1) + ',' + CONVERT(VARCHAR(MAX),@var2) + ') + ''.'' + ' + 'OBJECT_NAME(' + CONVERT(VARCHAR(MAX),@var1) + ');'
 
-- Fetch the name of the object
 INSERT INTO #object
 EXEC(@sql)
 
-- Set the object name to the local var.
 SELECT @object = objectname FROM #object
 
-- Update the original results
 UPDATE #temp
 SET
 [Object] = RTRIM(LTRIM(@object))
 WHERE
 objectid = @var1
 and dbid = @var2
 
 -- Go around the loop....
 FETCH NEXT FROM FetchObjectName INTO @var1, @var2
 END
CLOSE FetchObjectName
DEALLOCATE FetchObjectName

/*****************************************************
The final result set
******************************************************/
TRUNCATE TABLE x2tb_qry_stats
insert into x2tb_qry_stats
SELECT
 [Object] = [DatabaseName] + '.' + [Object],
 [IndividualQuery],
 [TotalRunTime (s)],
 [TotalTimeWaiting (s)],
 [%TimeRunning],
 [%TimeWaiting],
 [ExecutionCount],
 [AverageRunTime],
 [AverageTimeWaiting (s)],
 [QueryPlan] 
FROM
 #temp
ORDER BY
 [TotalTimeWaiting (s)] DESC;

 SELECT * FROM x2tb_qry_stats
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_064_gera_missing_index]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	alt 2019-08-23				*/
--Objetivo:  Information returned by sys.dm_db_missing_index_details is updated
-- when a query is optimized by the query optimizer, and is not persisted.
-- Missing index information is kept only until SQL Server is restarted. 
-- EXEC [dbo].[prc1_Ase_064_gera_missing_index]
--
/********************************************************************************/
create procedure [dbo].[prc1_Ase_064_gera_missing_index]
as
SET NOCOUNT ON

DECLARE @IC VARCHAR(4000), @ICWI VARCHAR(4000), @RI VARCHAR(4000), @DB VARCHAR(100), @IHK int, @TBL VARCHAR(100), @Qryins VARCHAR(4000)

CREATE TABLE #IndexCreation (
[DBid] int,
DBName VARCHAR(100),
[Table] VARCHAR(100),
[Equality] VARCHAR(1000),
[Included] VARCHAR(4000),
[Ix_Handle_Key] int,
Col1 VARCHAR(100) NULL,
Col2 VARCHAR(100) NULL,
Col3 VARCHAR(100) NULL,
Col4 VARCHAR(100) NULL,
Col5 VARCHAR(100) NULL,
Col6 VARCHAR(100) NULL,
Col7 VARCHAR(100) NULL,
Col8 VARCHAR(100) NULL,
Col9 VARCHAR(100) NULL,
Col10 VARCHAR(100) NULL,
Col11 VARCHAR(100) NULL,
Col12 VARCHAR(100) NULL,
Col13 VARCHAR(100) NULL,
Col14 VARCHAR(100) NULL,
Col15 VARCHAR(100) NULL,
Col16 VARCHAR(100) NULL
)

CREATE TABLE #IndexCreationSec (
[Ix_Handle_Key] int,
DBName VARCHAR(100),
[Table] VARCHAR(100),
[Equality] VARCHAR(1000),
)

CREATE TABLE #TempIndexCreation(
DBName sysname,
Ix_Handle_Key int,
[Table] VARCHAR(50),
Col1 VARCHAR(100) NULL,
Col2 VARCHAR(100) NULL,
Col3 VARCHAR(100) NULL,
Col4 VARCHAR(100) NULL,
Col5 VARCHAR(100) NULL,
Col6 VARCHAR(100) NULL,
Col7 VARCHAR(100) NULL,
Col8 VARCHAR(100) NULL,
Col9 VARCHAR(100) NULL,
Col10 VARCHAR(100) NULL,
Col11 VARCHAR(100) NULL,
Col12 VARCHAR(100) NULL,
Col13 VARCHAR(100) NULL,
Col14 VARCHAR(100) NULL,
Col15 VARCHAR(100) NULL,
Col16 VARCHAR(100) NULL
)

INSERT INTO #IndexCreation ([DBid],DBName,[Table],[Equality],[Included],[Ix_Handle_Key])
SELECT i.database_id AS [DBid], 
m.[name] AS DBName, 
i.[statement] AS [Table], 
CASE WHEN (i.equality_columns IS NOT NULL AND i.inequality_columns IS NULL) THEN i.equality_columns
WHEN (i.equality_columns IS NULL AND i.inequality_columns IS NOT NULL) THEN i.inequality_columns
ELSE i.equality_columns + ', ' + i.inequality_columns END AS [Equality], 
i.included_columns AS [Included],
i.index_handle [Ix_Handle_Key]
FROM sys.dm_db_missing_index_details i, master..sysdatabases m
WHERE i.database_id = m.dbid
ORDER BY database_id, Equality, i.index_handle

INSERT INTO #IndexCreationSec
SELECT MAX(DISTINCT [Ix_Handle_Key]) AS [Ix_Handle_Key], DBName, [Table], [Equality] FROM #IndexCreation 
GROUP BY DBName, [Table], [Equality]

SELECT DBName, COUNT(DISTINCT [Ix_Handle_Key]) AS Indexes_to_Create FROM #IndexCreationSec
GROUP BY DBName

SELECT DBName, COUNT(DISTINCT [Ix_Handle_Key]) AS Indexes_with_INCLUDEs_to_Create FROM #IndexCreation
WHERE [Included] IS NOT NULL
GROUP BY DBName

PRINT '############# Index creation statements #############' + CHAR(10)

DECLARE cIC CURSOR FOR
SELECT 'USE ' + QUOTENAME(DBName) + CHAR(10) + 'GO' + CHAR(10) + 'IF EXISTS (SELECT name FROM sys.indexes WHERE name = N''IX_' + 
CAST([Ix_Handle_Key] AS NVARCHAR) + ''') DROP INDEX IX_' + 
CAST([Ix_Handle_Key] AS NVARCHAR) + ' ON ' + [Table] + CHAR(10) + 'GO' + CHAR(10) + 'CREATE NONCLUSTERED INDEX IX_' + 
CAST([Ix_Handle_Key] AS NVARCHAR) + ' ON ' + [Table] + ' (' + [Equality] + ') WITH PAD_INDEX, FILLFACTOR = 90' + CHAR(10) + 'GO' + CHAR(10) -- AS CreateStatement 
FROM #IndexCreationSec
ORDER BY DBName, [Table], [Ix_Handle_Key]
OPEN cIC 
FETCH NEXT FROM cIC INTO @IC
WHILE @@FETCH_STATUS = 0 
BEGIN 
PRINT @IC
FETCH NEXT FROM cIC INTO @IC
END
CLOSE cIC 
DEALLOCATE cIC

PRINT '############# Index creation statements with INCLUDEs #############' + CHAR(10)

DECLARE cICWI CURSOR FOR
SELECT 'USE ' + QUOTENAME(DBName) + CHAR(10) + 'GO' + CHAR(10) + 'IF EXISTS (SELECT name FROM sys.indexes WHERE name = N''IX_' + 
CAST([Ix_Handle_Key] AS NVARCHAR) + ''') DROP INDEX IX_' + 
CAST([Ix_Handle_Key] AS NVARCHAR) + ' ON ' + [Table] + CHAR(10) + 'GO' + CHAR(10) + 'CREATE NONCLUSTERED INDEX IX_' + 
CAST([Ix_Handle_Key] AS NVARCHAR) + ' ON ' + [Table] + ' (' + [Equality] + ')' + CHAR(10) + 'INCLUDE (' + [Included] + ') WITH PAD_INDEX, FILLFACTOR = 90' + CHAR(10) + 'GO' + CHAR(10) -- AS CreateStatementWithInclude 
FROM #IndexCreation
WHERE [Included] IS NOT NULL
ORDER BY DBName, [Ix_Handle_Key]
OPEN cICWI 
FETCH NEXT FROM cICWI INTO @ICWI
WHILE @@FETCH_STATUS = 0 
BEGIN 
PRINT @ICWI
FETCH NEXT FROM cICWI INTO @ICWI
END
CLOSE cICWI 
DEALLOCATE cICWI


DECLARE cRI CURSOR FOR SELECT QUOTENAME(DBName), [Ix_Handle_Key], [Table], [Equality]
FROM #IndexCreation
--WHERE [Included] IS NOT NULL
GROUP BY DBName, [Table], [Equality], [Ix_Handle_Key]
ORDER BY DBName, [Ix_Handle_Key]
OPEN cRI 
FETCH NEXT FROM cRI INTO @DB, @IHK, @TBL, @RI
WHILE @@FETCH_STATUS = 0 
BEGIN 
DECLARE @tblCol VARCHAR(4000)
DECLARE @Col VARCHAR(50), @Colctr int, @Colctrdesc int, @StartPos int, @Length int
SET @Colctr = 0
SET @Colctrdesc = 0
WHILE LEN(@RI) > 0
BEGIN
SET @StartPos = CHARINDEX(',', @RI)
IF @StartPos < 0 SET @StartPos = 0
SET @Length = LEN(@RI) - @StartPos - 1
IF @Length < 0 SET @Length = 0
IF @StartPos > 0
BEGIN
SET @Col = SUBSTRING(@RI, 1, @StartPos - 1)
SET @RI = SUBSTRING(@RI, @StartPos + 1, LEN(@RI) - @StartPos)
SET @Colctr = @Colctr + 1
END
ELSE
BEGIN
SET @Col = @RI
SET @RI = ''
SET @Colctr = @Colctr + 1
END
IF @tblCol IS NULL
BEGIN SET @tblCol = CHAR(39) + LTRIM(RTRIM(@Col)) + CHAR(39) END
ELSE
BEGIN SET @tblCol = @tblCol + ',' + CHAR(39) + LTRIM(RTRIM(@Col)) + CHAR(39) END
END
IF @Colctr < 16
BEGIN
SET @Colctrdesc = 16 - @Colctr
WHILE @Colctrdesc > 0
BEGIN
SET @tblCol = @tblCol + ',' + CHAR(39) + CHAR(39)
SET @Colctrdesc = @Colctrdesc - 1
END
SET @Colctr = 0
END
SET @Qryins = 'INSERT INTO #TempIndexCreation (DBName,Ix_Handle_Key,[Table],Col1,Col2,Col3,Col4,Col5,Col6,Col7,Col8,Col9,Col10,Col11,Col12,Col13,Col14,Col15,Col16) VALUES (''' + @DB + ''',' + RTRIM(@IHK) + ',''' + @TBL + ''',' + @tblCol + ')'
EXECUTE (@Qryins)
SET @tblCol = NULL
FETCH NEXT FROM cRI INTO @DB, @IHK, @TBL, @RI
END
CLOSE cRI 
DEALLOCATE cRI

UPDATE #IndexCreation
SET #IndexCreation.Col1 = #TempIndexCreation.Col1,#IndexCreation.Col2 = #TempIndexCreation.Col2,#IndexCreation.Col3 = #TempIndexCreation.Col3,#IndexCreation.Col4 = #TempIndexCreation.Col4,#IndexCreation.Col5 = #TempIndexCreation.Col5,
#IndexCreation.Col6 = #TempIndexCreation.Col6,#IndexCreation.Col7 = #TempIndexCreation.Col7,#IndexCreation.Col8 = #TempIndexCreation.Col8,#IndexCreation.Col9 = #TempIndexCreation.Col9,#IndexCreation.Col10 = #TempIndexCreation.Col10,
#IndexCreation.Col11 = #TempIndexCreation.Col11,#IndexCreation.Col12 = #TempIndexCreation.Col12,#IndexCreation.Col13 = #TempIndexCreation.Col13,#IndexCreation.Col14 = #TempIndexCreation.Col14,#IndexCreation.Col15 = #TempIndexCreation.Col15,
  #IndexCreation.Col16 = #TempIndexCreation.Col16
FROM #IndexCreation, #TempIndexCreation
WHERE #IndexCreation.[Table] = #TempIndexCreation.[Table] AND #IndexCreation.Ix_Handle_Key = #TempIndexCreation.Ix_Handle_Key

SELECT 'Possible Redundant Indexes (no INCLUDEs)' AS Comments, I.DBName, I.[Table], I.[Ix_Handle_Key] AS IndexID, 'IX_' + CAST(I.[Ix_Handle_Key] AS NVARCHAR) AS IndexName, I.[Equality] AS AllColName
FROM #IndexCreation I JOIN #IndexCreation I2
ON I.[Table] = I2.[Table] AND I.[Ix_Handle_Key] <> I2.[Ix_Handle_Key] AND I.Col1 = I2.Col2 AND I.Col2 = I2.Col1
ORDER BY I.[Table],I.[Ix_Handle_Key]

DROP TABLE #IndexCreation
DROP TABLE #IndexCreationSec
DROP TABLE #TempIndexCreation





GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_065_lst_FileSize]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-02-06				*/
--Objetivo: Check FileSize and LogUsage for all DBs
--            
--exec dbo.[prc1_Ase_065_lst_FileSize] 
/********************************************************************************/
create proc [dbo].[prc1_Ase_065_lst_FileSize] 
--with encryption
	
As
SELECT instance_name AS DatabaseName,
       [Data File(s) Size (KB)],
       [LOG File(s) Size (KB)],
       [Log File(s) Used Size (KB)],
       [Percent Log Used]
FROM
(
   SELECT *
   FROM sys.dm_os_performance_counters
   WHERE counter_name IN
   (
       'Data File(s) Size (KB)',
       'Log File(s) Size (KB)',
       'Log File(s) Used Size (KB)',
       'Percent Log Used'
   )
     AND instance_name != '_Total'
) AS Src
PIVOT
(
   MAX(cntr_value)
   FOR counter_name IN
   (
       [Data File(s) Size (KB)],
       [LOG File(s) Size (KB)],
       [Log File(s) Used Size (KB)],
       [Percent Log Used]
   )
) AS pvt 


GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_066_lst_logins_fails]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-02-06				*/
--Objetivo: Lista falha de logins 
--            
--exec dbo.[prc1_Ase_066_lst_logins_fails]
/********************************************************************************/
CREATE proc [dbo].[prc1_Ase_066_lst_logins_fails] 
--with encryption
	
As
DECLARE @FirstDay DATETIME,
	@LastDay DATETIME
SET @FirstDay = DATEADD(MONTH, DATEDIFF(MONTH, -1, GETDATE()) - 2, 0);  --Edit start date here, default first day of previous month
SET @LastDay = GETDATE();  --Edit end date of log pull here

IF OBJECT_ID('tempdb..#TempLog') IS NOT NULL
	BEGIN
		DROP TABLE #TempLog
	END;
IF OBJECT_ID('tempdb..#TempLog2') IS NOT NULL
	BEGIN
		DROP TABLE #TempLog2
	END;
IF OBJECT_ID('tempdb..#TempLog3') IS NOT NULL
	BEGIN
		DROP TABLE #TempLog3
	END;

CREATE TABLE #TempLog (				--Create temp table for xp_readerrorlog data, raw data dump
	LogDate DATETIME,
	ProcessInfo NVARCHAR(50),
	TEXT NVARCHAR(2000)
	);

CREATE TABLE #TempLog2 (			--Create temp table2 for xp_readerrorlog data, grouped failed logins
	[ServerName] NVARCHAR(255),
	[User] NVARCHAR(255),
	[IP] NVARCHAR(255),
	[FailedAttempts] INT,
	[Month] NVARCHAR(255)
	);

CREATE TABLE #TempLog3 (			--Create temp table3 for xp_readerrorlog data, last successful login
	[ServerName] NVARCHAR(255),
	[User] NVARCHAR(255),
	[IP] NVARCHAR(255),
	[LogDate] NVARCHAR(255)
	);

INSERT INTO #TempLog (LogDate, ProcessInfo, TEXT)
EXEC master.dbo.xp_readerrorlog -1, 1, NULL, NULL, @FirstDay, @LastDay;

INSERT INTO #TempLog2				--Group failed logins
SELECT 
	@@SERVERNAME AS [ServerName],
	SUBSTRING(TEXT,(CHARINDEX('''',TEXT)+1),(CHARINDEX('''',TEXT,24)-(CHARINDEX('''',TEXT)+1))) AS [User],
	SUBSTRING(TEXT,(CHARINDEX(':',TEXT)+2),(CHARINDEX(']',TEXT,25)-(CHARINDEX(':',TEXT)+2))) AS [IP],
	'1' AS [FailedAttempts],		--Failed login count
	logdate as data_log
FROM #TempLog
WHERE ProcessInfo = 'Logon'
	AND TEXT LIKE '%Login failed%'

SELECT 
	[ServerName],
	[User],
	[IP],
	COUNT([FailedAttempts]) AS [FailedAttempts],
	[Month]
FROM #TempLog2
GROUP BY [ServerName], [User], [IP], [Month]
ORDER BY [User];

INSERT INTO #TempLog3			--Last successful login per user
SELECT
	@@SERVERNAME AS [ServerName],
	SUBSTRING(TEXT,(CHARINDEX('''',TEXT)+1),(CHARINDEX('''',TEXT,28)-(CHARINDEX('''',TEXT)+1))) AS [User],
	SUBSTRING(TEXT,(CHARINDEX('[',TEXT)+9),(CHARINDEX(']',TEXT,28)-(CHARINDEX('[',TEXT)+9))) AS [IP],
	LogDate AS [LastLogin]
FROM #TempLog
WHERE ProcessInfo = 'Logon'
	AND TEXT LIKE '%Login succeeded%'
	AND TEXT NOT LIKE '%NT AUTHORITY%'
	AND TEXT NOT LIKE '%Database Mirroring%'
GROUP BY TEXT, LogDate;

SELECT
	[ServerName],
	[User],
	[IP],
	MAX(LogDate) AS [LastLogin]
FROM #TempLog3
GROUP BY [ServerName], [User], [IP];

IF OBJECT_ID('tempdb..#TempLog') IS NOT NULL
	BEGIN
		DROP TABLE #TempLog
	END;
IF OBJECT_ID('tempdb..#TempLog2') IS NOT NULL
	BEGIN
		DROP TABLE #TempLog2
	END;
IF OBJECT_ID('tempdb..#TempLog3') IS NOT NULL
	BEGIN
		DROP TABLE #TempLog3
	END;
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_067_lst_tb_pagesplit]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-02-06				*/
--Objetivo: Lista Tabelas com divisões de páginas (page split)   
--            
--exec dbo.[prc1_Ase_067_lst_tb_pagesplit]
/********************************************************************************/
create proc [dbo].[prc1_Ase_067_lst_tb_pagesplit] 
--with encryption	
As
CREATE TABLE #TEMP_05
  (
  db    VARCHAR(200),
  ps    VARCHAR(200),
  pb    VARCHAR(200),
  ix    VARCHAR(200)
  )
  INSERT INTO #TEMP_05
  EXEC sp_MSforeachdb
 '
 use [?] 
  SELECT
      DB_NAME() AS [BANCO DE DADOS]
      ,COUNT(1) AS [DIVISÕES DE PÁGINAS]
      ,AllocUnitName AS [OBJETO]
      ,Context AS [CONTEXTO]
 FROM
      fn_dblog(NULL,NULL)
 WHERE
      Operation = ''LOP_DELETE_SPLIT'' and
      AllocUnitName NOT LIKE ''sys%''
      
 GROUP BY
      AllocUnitName, Context
 ORDER BY
      [BANCO DE DADOS] DESC
      '
 SELECT db [BANCO DE DADOS],
        ps [DIVISÕES DE PÁGINAS],
        pb [OBJETO],
        ix [CONTEXTO]
 FROM #TEMP_05
 WHERE db <> 'master' AND db <> 'model' AND db <> 'msdb' AND db <> 'tempdb'
 ORDER BY db

 DROP TABLE #TEMP_05
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_068_log_truncate]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2010-08-19					*/
--Objetivo: Trunca log do banco informado 
/* Shrinks the log file of @db_name to the @target_size_mb
*
exec [dbo].[prc1_Ase_068_log_truncate] 'X1DBSQL', 1,
'C:\Program Files\Microsoft SQL Server\MSSQL13.WSRV16\MSSQL\DATA\',
 'X1DBSQL_log.LDF'
************************************************************/
--dbcc loginfo('X1DBSQL')
--DBCC SQLPERF(logspace)
/********************************************************************************/
/********************************************************************************/
CREATE PROC [dbo].[prc1_Ase_068_log_truncate]

   @db_name SYSNAME = NULL
  , @target_size_mb INT = 1
  , @backup_location NVARCHAR(200) = NULL
  , @backup_file_name NVARCHAR(200) = NULL
  , @maximum_attempts INT = 10
  
AS

SET NOCOUNT ON

SELECT @db_name = COALESCE(@db_name, DB_NAME())
     
DECLARE @logical_log_file_name SYSNAME,
        @backup_log_sql NVARCHAR(MAX),
        @shrink_sql NVARCHAR(MAX),
        @checkpoint_sql NVARCHAR(MAX),
        @db_id INT = DB_ID (@db_name),
        @start_size_mb INT,
        @final_size_mb INT,
        @attempts INT = 0,
        @recovery_model INT,
        @recovery_model_desc SYSNAME,
        @rc INT = 0 -- return code

SELECT @logical_log_file_name = name,
       @start_size_mb = size / 128
   FROM MASTER..sysaltfiles
   WHERE dbid=@db_id AND  fileid=2
   
SELECT @recovery_model = recovery_model   
     , @recovery_model_desc = recovery_model_desc
   FROM sys.databases
   WHERE database_id=@db_id
   
PRINT 'Starting size of [' + @db_name + '].[' 
            + @logical_log_file_name 
            + '] is ' 
            + CONVERT(VARCHAR(20), @start_size_mb) + ' MB '
            + ' recovery model = ' + @recovery_model_desc

IF @start_size_mb <= @target_size_mb BEGIN
   PRINT '['+@db_name+'] does not need shrinking'
    END
    
ELSE BEGIN    

           
    IF @recovery_model != 3
        AND (@backup_file_name IS NULL OR @backup_location IS NULL) BEGIN
        RAISERROR ('Null backup file location or name. aborting.', 16, 1)
        SET @rc = 50000
        GOTO get_out
    END

   WHILE @attempts < @maximum_attempts
      AND @target_size_mb < (SELECT CONVERT(INT, size/128) FROM MASTER..sysaltfiles 
                               WHERE dbid = @db_id AND 
                                      name = @logical_log_file_name) -- not target
      BEGIN

        SET @attempts = @attempts + 1
        
        IF @recovery_model= 3 BEGIN
           SET @checkpoint_sql = 'use ['+@db_name+']; '
                               + 'checkpoint'
           PRINT @checkpoint_sql
           EXEC (@checkpoint_sql)
            END
        ELSE BEGIN

           SET @backup_log_sql =  'BACKUP LOG ['+ @db_name + '] '
                              + ' to disk = ''' + @backup_location 
                              + CASE WHEN RIGHT(RTRIM(@backup_location), 1)='\' 
                                    THEN '' ELSE '\' END
                              + @backup_file_name 
                              + CONVERT(VARCHAR(10), @attempts) 
                             + '.trn'''
           PRINT @backup_log_sql         

          EXEC (@backup_log_sql) -- See if a trunc of the log shrinks it.
        END
               
       SET @shrink_sql = 'use ['+@db_name+'];'
                       + 'dbcc shrinkfile (['+@logical_log_file_name+'], '
                       + CONVERT(VARCHAR(20), @target_size_mb) + ')'
       EXEC (@shrink_sql)
    END
END 

SELECT @final_size_mb = size/128 
   FROM MASTER..sysaltfiles 
   WHERE dbid = @db_id AND name = @logical_log_file_name
   
PRINT  'Final size of [' + @db_name + '].[' 
            + @logical_log_file_name 
            + '] is ' +
       CONVERT(VARCHAR(20),@final_size_mb)
       + ' MB'
    
get_out:
RETURN @rc




GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_069_seek]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2007-02-27					*/
-- Description:Localiza qualquer string dentro de objetos nao criptografados
--tipos validos C = Check Constraint
--              D = Default
--             FN = Function
--              P = Procedure
--             TR = Trigger
--              V = View
--Parametros:Texto a pesquisar,flag 'C,D,FN,P,TR,V)
--exec dbo.[prc1_Ase_069_seek] 'messages','p'
--exec dbo.[prc1_Ase_069_seek] 'x2tb_obj_Auditqry','p'
--exec dbo.[prc1_Ase_069_seek] 'x2tb_obj_Delayqry','p'
/********************************************************************************/
/********************************************************************************/
CREATE PROCEDURE [dbo].[prc1_Ase_069_seek]
    /* Input variables, default null for custom error output. */
    @find VARCHAR(50) = NULL,
    @type VARCHAR(2) = NULL
--with encryption
    AS

    /* Check for null or invalid input and show custom error. */
    IF @find IS NULL AND @type IS NULL
    BEGIN
    	RAISERROR ('This procedure has two required parameters @find and @type',16,-1)
    	RETURN
    END
    ELSE IF @find IS NULL
    BEGIN
    	RAISERROR ('You must enter a valid like criteria for @find without the leading/ending % wildcard.',16,-1)
    	RETURN
    END
    ELSE IF @type IS NULL OR @type NOT IN ('C','D','FN','P','TR','V')
    BEGIN
    	RAISERROR('No value was entered for @type.
    Valid values for @type are
    	C = Check Constraint
    	D = Default
    	FN = Function
    	P = Procedure
    	TR = Trigger
    	V = View',16,-1)
    	RETURN
    END
    /* Set wildcards on end of find value. */
    SET @find = '%' + @find + '%'
    /* Output object names which contain find value. */
    SELECT DISTINCT OBJECT_NAME([id]) FROM syscomments
    WHERE [id] IN (SELECT [id] FROM sysobjects WHERE xtype = @type AND status >= 0) AND [text] LIKE @find








GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_070_lst_datapages_details]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-23-10	*/
--Objetivo: List total data pages - number of rows used pages
/*
exec dbo.[prc1_Ase_070_lst_datapages_details]
 */ 
/********************************************************************************/
CREATE PROCEDURE [dbo].[prc1_Ase_070_lst_datapages_details]  

As

SET NOCOUNT ON

Select ST.Name As 'Tabela',

SP.rows As 'Linhas',

SA.data_pages As 'Páginas de Dados',

SA.used_pages As 'Páginas de Dados Utilizadas',

SA.total_pages As 'Total de Páginas de Dados'

from sys.tables ST Inner Join sys.partitions SP

On ST.object_id = SP.object_id

Inner Join sys.allocation_units SA

On SA.container_id = SP.partition_id




GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_071_lst_paritioned_table]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-23-10	*/
--Objetivo: Lista detalhes das tabelas particionadas
/*
exec [prc1_Ase_071_lst_paritioned_table]
 */ 
/********************************************************************************/
CREATE PROCEDURE [dbo].[prc1_Ase_071_lst_paritioned_table] 

As

SET NOCOUNT ON

--paritioned table and index details

SELECT
      OBJECT_NAME(p.object_id) AS ObjectName,
      i.name                   AS IndexName,
      p.index_id               AS IndexID,
      ds.name                  AS PartitionScheme, 
      p.partition_number       AS PartitionNumber,
      fg.name                  AS FileGroupName,
	  p.data_compression_desc  as data_compression_desc,
      prv_left.value           AS LowerBoundaryValue,
      prv_right.value          AS UpperBoundaryValue,
	      CASE pf.boundary_value_on_right
            WHEN 1 THEN 'RIGHT'
            ELSE 'LEFT' END    AS Range,
      p.rows AS Rows
FROM sys.partitions                  AS p
JOIN sys.indexes                     AS i
      ON i.object_id = p.object_id
      AND i.index_id = p.index_id
JOIN sys.data_spaces                 AS ds
      ON ds.data_space_id = i.data_space_id
JOIN sys.partition_schemes           AS ps
      ON ps.data_space_id = ds.data_space_id
JOIN sys.partition_functions         AS pf
      ON pf.function_id = ps.function_id
JOIN sys.destination_data_spaces     AS dds2
      ON dds2.partition_scheme_id = ps.data_space_id 
      AND dds2.destination_id = p.partition_number
JOIN sys.filegroups                  AS fg
      ON fg.data_space_id = dds2.data_space_id
LEFT JOIN sys.partition_range_values AS prv_left
      ON ps.function_id = prv_left.function_id
      AND prv_left.boundary_id = p.partition_number - 1
LEFT JOIN sys.partition_range_values AS prv_right
      ON ps.function_id = prv_right.function_id
      AND prv_right.boundary_id = p.partition_number
WHERE
      OBJECTPROPERTY(p.object_id, 'ISMSShipped') = 0
UNION ALL
--non-partitioned table/indexes
SELECT
      OBJECT_NAME(p.object_id)    AS ObjectName,
      i.name                      AS IndexName,
      p.index_id                  AS IndexID,
      NULL                        as PartitionScheme,
      p.partition_number          AS PartitionNumber,
      fg.name                     AS FileGroupName,
	  p.data_compression_desc  as data_compression_desc,
      NULL                        AS LowerBoundaryValue,
      NULL                        AS UpperBoundaryValue,
      NULL                        AS Boundary,
      p.rows                      AS Rows
FROM sys.partitions     AS p
JOIN sys.indexes        AS i
      ON i.object_id = p.object_id
      AND i.index_id = p.index_id
JOIN sys.data_spaces    AS ds
      ON ds.data_space_id = i.data_space_id
JOIN sys.filegroups           AS fg
      ON fg.data_space_id = i.data_space_id
WHERE
      OBJECTPROPERTY(p.object_id, 'ISMSShipped') = 0 
      and p.partition_number  > 1 

ORDER BY
      ObjectName,
      IndexID,
      PartitionNumber;





GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_072_lst_paritioned_details]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-23-10	*/
--Objetivo: Lista Storage Partition Funtions Schemes
/*
exec [dbo].[prc1_Ase_072_lst_paritioned_details]
 */ 
/********************************************************************************/
create PROCEDURE [dbo].[prc1_Ase_072_lst_paritioned_details] 

As

SET NOCOUNT ON

select name,function_id,type_desc,create_date
 from  sys.partition_functions 

select * from sys.partition_schemes

SELECT FILE_ID, name, physical_name, state_desc   
FROM sys.database_files





GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_073_cr_ndf_fgrp0]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-10-23					*/
--Objetivo:
-------------------------------------------------------
--Cria Filegroup dinâmico para qualquer banco fgrp0
-------------------------------------------------------
--Parametros:Banco,path
--Exemplo:
--exec dbo.[prc1_Ase_073_cr_ndf_fgrp0] X1DBSQL,'c:\FGR_P0\'
/********************************************************************************/
CREATE  proc [dbo].[prc1_Ase_073_cr_ndf_fgrp0] @db sysname,@via sysname
as
set nocount on


declare @stm varchar(max),@data varchar(max),@data1 varchar(max)
set @data = @db + '_fgrp0'
set @data1 = @db + '_datafgrp0.ndf'
set @via = @via + ' ' + @data1
set @via = '''' + @via + ''''

-- Create a new file group
set @stm = 
'alter database ' + @db + 
' add filegroup  fgrp0'
exec(@stm)

-- Add a file to the file group, we can now use the file group to store data
set @stm = 
'alter database ' + @db +
' add file
        (name= '+ @data + ', ' +
         'filename= ' + @via + ' ' + 
         ', size=10,
         filegrowth=20)
to filegroup fgrp0'
exec(@stm)





GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_074_cr_ndf_fgrp1]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-10-23					*/
--Objetivo:
-------------------------------------------------------
--Cria Filegroup dinâmico para qualquer banco fgrp1
-------------------------------------------------------
--Parametros:Banco,path
--Exemplo:
--exec dbo.[prc1_Ase_074_cr_ndf_fgrp1] X1DBSQL,'C:\FGR_P1\'
/********************************************************************************/
CREATE  proc [dbo].[prc1_Ase_074_cr_ndf_fgrp1] @db sysname,@via sysname
as
set nocount on


declare @stm varchar(max),@data varchar(max),@data1 varchar(max)
set @data = @db + '_fgrp1'
set @data1 = @db + '_datafgrp1.ndf'
set @via = @via + ' ' + @data1
set @via = '''' + @via + ''''

-- Create a new file group
set @stm = 
'alter database ' + @db + 
' add filegroup  fgrp1'
exec(@stm)

-- Add a file to the file group, we can now use the file group to store data
set @stm = 
'alter database ' + @db +
' add file
        (name= '+ @data + ', ' +
         'filename= ' + @via + ' ' + 
         ', size=10,
         filegrowth=20)
to filegroup fgrp1'
exec(@stm)





GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_075_cr_ndf_fgrp2]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-10-23					*/
--Objetivo:
-------------------------------------------------------
--Cria Filegroup dinâmico para qualquer banco fgrp2
-------------------------------------------------------
--Parametros:Banco,path
--Exemplo:
--exec dbo.[prc1_Ase_075_cr_ndf_fgrp2] X1DBSQL,'E:\FGR_P2\'
/********************************************************************************/
CREATE  proc [dbo].[prc1_Ase_075_cr_ndf_fgrp2] @db sysname,@via sysname
as
set nocount on


declare @stm varchar(max),@data varchar(max),@data1 varchar(max)
set @data = @db + '_fgrp2'
set @data1 = @db + '_datafgrp2.ndf'
set @via = @via + ' ' + @data1
set @via = '''' + @via + ''''

-- Create a new file group
set @stm = 
'alter database ' + @db + 
' add filegroup  fgrp2'
exec(@stm)

-- Add a file to the file group, we can now use the file group to store data
set @stm = 
'alter database ' + @db +
' add file
        (name= '+ @data + ', ' +
         'filename= ' + @via + ' ' + 
         ', size=10,
         filegrowth=20)
to filegroup fgrp2'
exec(@stm)





GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_076_cr_ndf_fgrp3]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-10-23					*/
--Objetivo:
-------------------------------------------------------
--Cria Filegroup dinâmico para qualquer banco fgrp3
-------------------------------------------------------
--Parametros:Banco,path
--Exemplo:
--exec dbo.[prc1_Ase_076_cr_ndf_fgrp3] DBSOLUTION,'E:\FGROUP_P3\'
/********************************************************************************/
CREATE  proc [dbo].[prc1_Ase_076_cr_ndf_fgrp3] @db sysname,@via sysname
as
set nocount on


declare @stm varchar(max),@data varchar(max),@data1 varchar(max)
set @data = @db + '_fgrp3'
set @data1 = @db + '_datafgrp3.ndf'
set @via = @via + ' ' + @data1
set @via = '''' + @via + ''''

-- Create a new file group
set @stm = 
'alter database ' + @db + 
' add filegroup  fgrp3'
exec(@stm)

-- Add a file to the file group, we can now use the file group to store data
set @stm = 
'alter database ' + @db +
' add file
        (name= '+ @data + ', ' +
         'filename= ' + @via + ' ' + 
         ', size=10,
         filegrowth=20)
to filegroup fgrp3'
exec(@stm)





GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_077_cr_ndf_fgrpix0]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2009-01-05					*/
--Objetivo:
-------------------------------------------------------
--Cria Filegroup dinâmico para indice fgrpix0
-------------------------------------------------------
--Parametros:Banco,path
--Exemplo:
--exec dbo.[prc1_Ase_077_cr_ndf_fgrpix0] X2DBSQL,'E:\FGROUP_X0\'
/********************************************************************************/
CREATE  proc [dbo].[prc1_Ase_077_cr_ndf_fgrpix0] @db sysname,@via sysname
as
set nocount on


declare @stm varchar(max),@data varchar(max),@data1 varchar(max)
set @data = @db + '_fgrpix0'
set @data1 = @db + '_datafgrpix0.ndf'
set @via = @via + ' ' + @data1
set @via = '''' + @via + ''''

-- Create a new file group
set @stm = 
'alter database ' + @db + 
' add filegroup  fgrpix0'
exec(@stm)

-- Add a file to the file group, we can now use the file group to store data
set @stm = 
'alter database ' + @db +
' add file
        (name= '+ @data + ', ' +
         'filename= ' + @via + ' ' + 
         ', size=10,
         filegrowth=20)
to filegroup fgrpix0'
exec(@stm)
-------------------------------------------------------------





GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_078_cr_ndf_fgrpix1]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2009-01-05					*/
--Objetivo:
-------------------------------------------------------
--Cria Filegroup dinâmico para indice fgrpix1
-------------------------------------------------------
--Parametros:Banco,path
--Exemplo:
--exec dbo.[prc1_Ase_078_cr_ndf_fgrpix1] X2DBSQL,'G:\FGROUP_X1\'
/********************************************************************************/
CREATE  proc [dbo].[prc1_Ase_078_cr_ndf_fgrpix1] @db sysname,@via sysname
as
set nocount on


declare @stm varchar(max),@data varchar(max),@data1 varchar(max)
set @data = @db + '_fgrpix1'
set @data1 = @db + '_datafgrpix1.ndf'
set @via = @via + ' ' + @data1
set @via = '''' + @via + ''''

-- Create a new file group
set @stm = 
'alter database ' + @db + 
' add filegroup  fgrpix1'
exec(@stm)

-- Add a file to the file group, we can now use the file group to store data
set @stm = 
'alter database ' + @db +
' add file
        (name= '+ @data + ', ' +
         'filename= ' + @via + ' ' + 
         ', size=10,
         filegrowth=20)
to filegroup fgrpix1'
exec(@stm)
-------------------------------------------------------------





GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_079_cr_ndf_fgrpix2]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-10-23				*/
--Objetivo:
-------------------------------------------------------
--Cria Filegroup dinâmico para indice fgrpix2
-------------------------------------------------------
--Parametros:Banco,path
--Exemplo:
--exec dbo.[prc1_Ase_079_cr_ndf_fgrpix2] X2DBSQL,'H:\FGROUP_X2\'
/********************************************************************************/
CREATE  proc [dbo].[prc1_Ase_079_cr_ndf_fgrpix2] @db sysname,@via sysname
as
set nocount on


declare @stm varchar(max),@data varchar(max),@data1 varchar(max)
set @data = @db + '_fgrpix2'
set @data1 = @db + '_datafgrpix2.ndf'
set @via = @via + ' ' + @data1
set @via = '''' + @via + ''''

-- Create a new file group
set @stm = 
'alter database ' + @db + 
' add filegroup  fgrpix2'
exec(@stm)

-- Add a file to the file group, we can now use the file group to store data
set @stm = 
'alter database ' + @db +
' add file
        (name= '+ @data + ', ' +
         'filename= ' + @via + ' ' + 
         ', size=10,
         filegrowth=20)
to filegroup fgrpix2'
exec(@stm)
-------------------------------------------------------------





GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_080_cr_ndf_fgrpix3]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-10-23				*/
--Objetivo:
-------------------------------------------------------
--Cria Filegroup dinâmico para indice fgrpix3
-------------------------------------------------------
--Parametros:Banco,path
--Exemplo:
--exec dbo.[prc1_Ase_080_cr_ndf_fgrpix3] X2DBSQL,'H:\FGROUP_X3\'
/********************************************************************************/
CREATE  proc [dbo].[prc1_Ase_080_cr_ndf_fgrpix3] @db sysname,@via sysname
as
set nocount on


declare @stm varchar(max),@data varchar(max),@data1 varchar(max)
set @data = @db + '_fgrpix3'
set @data1 = @db + '_datafgrpix3.ndf'
set @via = @via + ' ' + @data1
set @via = '''' + @via + ''''

-- Create a new file group
set @stm = 
'alter database ' + @db + 
' add filegroup  fgrpix3'
exec(@stm)

-- Add a file to the file group, we can now use the file group to store data
set @stm = 
'alter database ' + @db +
' add file
        (name= '+ @data + ', ' +
         'filename= ' + @via + ' ' + 
         ', size=10,
         filegrowth=20)
to filegroup fgrpix3'
exec(@stm)
-------------------------------------------------------------





GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_081_lst_range_data_spaces]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2007-04-15	*/
--Objetivo: Lista range values e filegroups
/*
exec [prc1_Ase_081_lst_range_data_spaces]  xtbl_Partition,' WHERE colpk < 100000  '
exec [prc1_Ase_081_lst_range_data_spaces]  xtbl_Partition,' WHERE colpk >  199000  '
exec [prc1_Ase_081_lst_range_data_spaces]  xtbl_Partition,' WHERE colpk >= 400000 AND colpk < 400020'
 */ 
/********************************************************************************/
CREATE PROCEDURE [dbo].[prc1_Ase_081_lst_range_data_spaces] @tb sysname,@where sysname

As

SET NOCOUNT ON

select * from sys.partition_range_values
select * from sys.data_spaces

declare @sql varchar(max)
-- View data with partition number  
set @sql =
'SELECT TOP 10 *, $Partition.Func_Range(colpk) PartitionNo  
FROM ' + @tb + char(10) +
@where

exec(@sql)


GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_082_Partition_Function]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2007-04-08					*/
--Objetivo:   Cria partition function e partition scheme com 4 niveis
--            
--Parametros :Nome,nivel1,nivel2,nivel3
--Exemplo:
--exec dbo.[prc1_Ase_082_Partition_Function]  Func_Range,100000,250000,550000,820000
----------------------------------------------------------------------------------
create procedure [dbo].[prc1_Ase_082_Partition_Function]
@fc sysname, @n1 int,@n2 int, @n3 int,@n4 int
as
set nocount on

declare @stm varchar(max)

set @stm = 'CREATE PARTITION FUNCTION  ' + @fc + '(int) ' + char(10) +
' AS RANGE LEFT FOR VALUES (' + convert(varchar(max),@n1 ) + ',' 
                              + convert(varchar(max),@n2)  + ',' 
                              + convert(varchar(max),@n3 ) + ','
                              + convert(varchar(max),@n4 ) + ')'

exec(@stm)
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_083_lst_docs_partition_cmd]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2013-02-03				*/
--Objetivo:  Exemplos do uso dos comandos para particionamento.....                    
--Parametros : sem
--Exemplo:
--exec dbo.[prc1_Ase_083_lst_docs_partition_cmd]
/********************************************************************************/
/********************************************************************************/
CREATE proc [dbo].[prc1_Ase_083_lst_docs_partition_cmd]
as
set nocount on
---------------------------------------------------------------------
-- Declarations
---------------------------------------------------------------------
declare @doc_partition varchar(max)
set @doc_partition = ' create PARTITION FUNCTION func_range (int)
AS RANGE LEFT FOR VALUES (100000, 220000, 580000) ;
---------------------------------------------------------------------
CREATE PARTITION SCHEME scheme_range
AS PARTITION func_range
TO (fgrp0,fgrp1,fgrp2,fgrp3);
----------------------------------------------------------------------
CREATE PARTITION SCHEME scheme_range_PK
AS PARTITION func_range
TO (fgrpix0,fgrpix1,fgrpix2,fgrpix3);
-----------------------------------------------------------------------
CREATE TABLE dbo.xtbl_Partition 
(
   colPK int identity (1,1)primary key , 
   colNvarchar01 nvarchar(256),
   colNvarchar02 nvarchar(256),
   colNvarchar03 nvarchar(256),
   colNvarchar04 nvarchar(256),
   colDate1 date 
)
ON scheme_range (colPK);
--------------------------------------------------------------------
DECLARE @val INT
SELECT @val=0
WHILE @val < 500000
BEGIN  
   INSERT INTO xtbl_Partition (colNvarchar01,colNvarchar02,colNvarchar03,colNvarchar04,colDate1)
      VALUES (alfa,alfb,alfc,alfd,getdate())
   SELECT @val=@val+1
END
---------------------------------------------------
ALTER TABLE dbo.xtbl_Partition ADD CONSTRAINT PK_xtbl_Partition_colPK PRIMARY KEY CLUSTERED 
    (colpk
    ) ON scheme_range_PK (colPK)
	----------------------------------
	---------------------------------
	exec [prc1_Ase_070_lst_partitions_details] xtbl_Partition
    exec [prc1_Ase_071_lst_paritioned_table]
	---------------------------------------------------------
	sp_spaceused xtbl_Partition
	name	        rows	reserved	data	index_size	unused
    xtbl_Partition	1000000  57888 KB	57568 KB	176 KB	144 KB
	--------------------------------------------------------------
	/* TSQL to implement PAGE compression */
	--------------------------------------------------------------
	xtbl_Partition	1000000  11360 KB	10936 KB	64 KB	360 KB
	---------------------------------------------------------------
	exec [dbo].[prc1_Ase_084_tbix_compression] db_dnit,null,null,page
	------------------------------------------------------------------
	/* TSQL to implement PAGE compression */
-----------------------------------
USE [db_dnit]
GO
ALTER TABLE [dbo].[xtbl_Partition] REBUILD PARTITION = ALL WITH (DATA_COMPRESSION = PAGE);

ALTER INDEX [PK_xtbl_Partition_colPK] ON [dbo].[xtbl_Partition] REBUILD WITH ( DATA_COMPRESSION = PAGE);

--------------------------------------------------------------------------------------------------------
exec [prc1_Ase_081_lst_range_data_spaces]  xtbl_Partition, WHERE colpk < 100000  
exec [prc1_Ase_081_lst_range_data_spaces]  xtbl_Partition, WHERE colpk >  299000  
exec [prc1_Ase_081_lst_range_data_spaces]  xtbl_Partition, WHERE colpk >= 600000 AND colpk < 690020
--------------------------------------------------------------------------------------------------------
'
print @doc_partition








GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_084_tbix_compression]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2009-09-02                                      */
--Objetivo:  List e audita Table & Index Compression
--tbd_vl 207.820 MB........compressed 59.109 MB
--5.320.000 rows
--6.890.000  rows 78.734 MB....compressed   
-------------------------------------------------------------
--exec [dbo].[prc1_Ase_084_tbix_compression] x1dbsql,null,null,page
-------------------------------------------------------------
/********************************************************************************/
CREATE proc [dbo].[prc1_Ase_084_tbix_compression] 
(@database VARCHAR(50) = '' ,@emailrecipients VARCHAR(1000) = '' 
                            ,@emailprofile VARCHAR(50) = '' 
                            ,@compressiontype VARCHAR(4) = 'PAGE')
as

BEGIN

SET NOCOUNT ON

-- Check supplied parameters
IF @database = '' 
	BEGIN 
		PRINT 'Database not specified'
		RETURN 
	END
IF @database NOT IN (SELECT name FROM sys.databases) 
	BEGIN 
		PRINT 'Database ' + @database + ' not found on server ' + @@SERVERNAME
		RETURN 
	END
IF @emailrecipients = '' AND @emailprofile <> '' 
	BEGIN 
		PRINT 'Email profile given but recipients not specified'
		RETURN 
	END
IF @emailrecipients <> '' AND @emailprofile = '' 
	BEGIN 
		PRINT 'Email recipients given but profile not specified'
		RETURN 
	END
SET @compressiontype = UPPER(LTRIM(RTRIM(@compressiontype)))
IF @compressiontype NOT IN ('PAGE', 'ROW')
	BEGIN 
		PRINT 'CompressionType must be PAGE or ROW'
		RETURN 
	END
	
-- Declare variables
DECLARE @indexreport VARCHAR(MAX)
DECLARE @missingindexcompressiontsql VARCHAR(MAX)
DECLARE @missingindextablelist VARCHAR(MAX)
DECLARE @missingindexindexlist VARCHAR(MAX)
DECLARE @missingcompressiontablecount INT
DECLARE @missingcompressionindexcount INT
DECLARE @changeindexcompressiontsql VARCHAR(MAX)
DECLARE @changeindextablelist VARCHAR(MAX)
DECLARE @changeindexindexlist VARCHAR(MAX)
DECLARE @changecompressiontablecount INT
DECLARE @changecompressionindexcount INT
DECLARE @CurrentRow INT
DECLARE @TotalRows INT
DECLARE @Objecttype VARCHAR(10)
DECLARE @objectname VARCHAR(100)
DECLARE @command VARCHAR(1000)
DECLARE @emailsubject VARCHAR(100)
DECLARE @dynamicsql VARCHAR(MAX)               

-- Create temporary tables.
-- These are used because they're scope is greater than a tablevariable i.e. we can pull results back from dynamic sql.
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE name LIKE '##MissingCompression%')
   DROP TABLE ##MissingCompression
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE name LIKE '##ChangeCompression%')
   DROP TABLE ##ChangeCompression      
CREATE TABLE ##MissingCompression
					(uniquerowid INT IDENTITY ( 1 , 1 ) PRIMARY KEY NOT NULL,
                   objecttype VARCHAR(10),
                   objectname VARCHAR(100),
                   command VARCHAR(500));
CREATE TABLE ##ChangeCompression
					(uniquerowid INT IDENTITY ( 1 , 1 ) PRIMARY KEY NOT NULL,
                   objecttype VARCHAR(10),
                   objectname VARCHAR(100),
                   command VARCHAR(500));
                   
-- Work out what indexes are missing compression and build the commands for them
SET @dynamicsql =
'WITH missingcompression
     AS (SELECT ''Table''  AS objecttype,
                s.name + ''.'' + o.name AS objectname,
                ''ALTER TABLE ['' + s.name + ''].['' + o.name + ''] REBUILD PARTITION = ALL WITH (DATA_COMPRESSION = ' + @compressiontype + ');'' AS command
         FROM  ' + @database + '.sys.objects o
                INNER JOIN  ' + @database + '.sys.partitions p
                  ON p.object_id = o.object_id
                INNER JOIN  ' + @database + '.sys.schemas s
                  ON s.schema_id = o.schema_id
         WHERE  TYPE = ''u''
                AND data_compression = 0
                AND Schema_name(o.schema_id) <> ''SYS''
         UNION
         SELECT ''Index'' AS objecttype,
                i.name AS objectname,
                ''ALTER INDEX ['' + i.name + ''] ON ['' + s.name + ''].['' + o.name + ''] REBUILD WITH ( DATA_COMPRESSION = ' + @compressiontype + ');'' AS command
         FROM   ' + @database + '.sys.dm_db_partition_stats ps
                INNER JOIN ' + @database + '.sys.indexes i
                  ON ps.[object_id] = i.[object_id]
                     AND ps.index_id = i.index_id
                     AND i.type_desc <> ''HEAP''
                INNER JOIN ' + @database + '.sys.objects o
                  ON o.[object_id] = ps.[object_id]
                INNER JOIN ' + @database + '.sys.schemas s
                  ON o.[schema_id] = s.[schema_id]
                     AND s.name <> ''SYS''
                INNER JOIN ' + @database + '.sys.partitions p
                  ON p.[object_id] = o.[object_id]
                     AND data_compression = 0)
                     
-- populate temporary table ''##MissingCompression''
INSERT INTO ##MissingCompression (objecttype, objectname, command)
SELECT objecttype, objectname, command FROM missingcompression ORDER BY objectname ASC, command DESC '
exec (@dynamicsql)

SET @dynamicsql =
'WITH changecompression
     AS (SELECT ''Table''  AS objecttype,
                s.name + ''.'' + o.name AS objectname,
                ''ALTER TABLE ['' + s.name + ''].['' + o.name + ''] REBUILD PARTITION = ALL WITH (DATA_COMPRESSION = ' + @compressiontype + ');'' AS command
         FROM  ' + @database + '.sys.objects o
                INNER JOIN  ' + @database + '.sys.partitions p
                  ON p.object_id = o.object_id
                INNER JOIN  ' + @database + '.sys.schemas s
                  ON s.schema_id = o.schema_id
         WHERE  TYPE = ''u''
                AND data_compression <> 0
                AND data_compression_desc <> ''' + @compressiontype + ''' 
                AND Schema_name(o.schema_id) <> ''SYS''
         UNION
         SELECT ''Index'' AS objecttype,
                i.name AS objectname,
                ''ALTER INDEX ['' + i.name + ''] ON ['' + s.name + ''].['' + o.name + ''] REBUILD WITH ( DATA_COMPRESSION = ' + @compressiontype + ');'' AS command
         FROM   ' + @database + '.sys.dm_db_partition_stats ps
                INNER JOIN ' + @database + '.sys.indexes i
                  ON ps.[object_id] = i.[object_id]
                     AND ps.index_id = i.index_id
                     AND i.type_desc <> ''HEAP''
                INNER JOIN ' + @database + '.sys.objects o
                  ON o.[object_id] = ps.[object_id]
                INNER JOIN ' + @database + '.sys.schemas s
                  ON o.[schema_id] = s.[schema_id]
                     AND s.name <> ''SYS''
                INNER JOIN ' + @database + '.sys.partitions p
                  ON p.[object_id] = o.[object_id]
                     AND data_compression <> 0
                     AND data_compression_desc <> ''' + @compressiontype + ''' )
                     
-- populate temporary table ''##ChangeCompression''
INSERT INTO ##ChangeCompression (objecttype, objectname, command)
SELECT objecttype, objectname, command FROM changecompression ORDER BY objectname ASC, command DESC '
exec (@dynamicsql)

-- We now have populated our temporary tables (##MissingCompression & ##ChangeCompression)

-- First, loop objects with no compression.
-- For each object >
--  1) increment the counter, 
--  2) add the object name to the list for display 
--  3) generate the tsql for compression commands

		-- set initial variables
		SET @missingindexcompressiontsql = ''
		SET @missingindextablelist = ''
		SET @missingindexindexlist = ''
		SET @missingcompressiontablecount = 0
		SET @missingcompressionindexcount = 0
		SELECT @TotalRows = Count(* ) FROM ##MissingCompression
		SELECT @CurrentRow = 1

		WHILE @CurrentRow <= @TotalRows
		  BEGIN
			SELECT @Objecttype = objecttype,
						@objectname = objectname,
						@command = command
			FROM   ##MissingCompression
			WHERE  uniquerowid = @CurrentRow
		    
			SET @missingindexcompressiontsql = @missingindexcompressiontsql + @command + Char(10) + Char(10) 
		   
			IF @Objecttype = 'table'
			  BEGIN
				SET @missingindextablelist = @missingindextablelist + @objectname + Char(10)     
				SET @missingcompressiontablecount = @missingcompressiontablecount + 1
			  END
		    
			IF @Objecttype = 'index'
			  BEGIN
				SET @missingindexindexlist = @missingindexindexlist + @objectname + Char(10)
				SET @missingcompressionindexcount = @missingcompressionindexcount + 1
			  END
		    
			SELECT @CurrentRow = @CurrentRow + 1
		  END
  
  
-- Now deal with Objects that need to change compression type
-- For each object >
--  1) increment the counter, 
--  2) add the object name to the list for display 
--  3) generate the tsql for compression commands

		  -- set initial variables
		SET @changeindexcompressiontsql = ''
		SET @changeindextablelist = ''
		SET @changeindexindexlist = ''
		SET @indexreport = ''
		SET @changecompressiontablecount = 0
		SET @changecompressionindexcount = 0
		SELECT @TotalRows = Count(* ) FROM ##ChangeCompression
		SELECT @CurrentRow = 1

		WHILE @CurrentRow <= @TotalRows
		  BEGIN
			SELECT @Objecttype = objecttype,
						@objectname = objectname,
						@command = command
			FROM   ##ChangeCompression
			WHERE  uniquerowid = @CurrentRow
		    
			SET @changeindexcompressiontsql = @changeindexcompressiontsql + @command + Char(10) + Char(10)
		   
			IF @Objecttype = 'table'
			  BEGIN
				SET @changeindextablelist = @changeindextablelist + @objectname + Char(10)     
				SET @changecompressiontablecount = @changecompressiontablecount + 1
			  END
		    
			IF @Objecttype = 'index'
			  BEGIN
				SET @changeindexindexlist = @changeindexindexlist + @objectname + Char(10)
				SET @changecompressionindexcount = @changecompressionindexcount + 1
			  END
		    
			SELECT @CurrentRow = @CurrentRow + 1
		  END

		 -- Build the text output for the report  >
		 -- First for objects missing compression >
		IF (@missingcompressionindexcount + @missingcompressiontablecount) > 0
		  BEGIN
			IF (@missingcompressiontablecount) > 0
			  BEGIN
				SET @indexreport = @indexreport + 'Tables not currently utilising ' + @compressiontype + ' compression >' + Char(10) +  '--------------------------------------------' + Char(10) + @missingindextablelist + Char(13) + Char(13)
			  END      
			IF (@missingcompressionindexcount) > 0
			  BEGIN
				SET @indexreport = @indexreport + 'Indexes not currently utilising ' + @compressiontype + ' compression >' + Char(10) +  '---------------------------------------------' + Char(10) + @missingindexindexlist + Char(13) + Char(13)
			  END
		  END
	
		-- Now for objects using the incorrect compression type >
		IF (@changecompressionindexcount + @changecompressiontablecount) > 0
		  BEGIN
			IF (@changecompressiontablecount) > 0
			  BEGIN
				SET @indexreport = @indexreport + 'Tables with incorrect compression type >' + Char(10) + '--------------------------------------------' + Char(13) + Char(10) + @changeindextablelist + Char(13) + Char(10)
			  END      
			IF (@changecompressionindexcount) > 0
			  BEGIN
				SET @indexreport = @indexreport + 'Indexes with incorrect compression type >' + Char(10) + '---------------------------------------------' + Char(13) + Char(10) + @changeindexindexlist + Char(13) + Char(10)
			  END
		  END
		IF (@missingcompressionindexcount + @missingcompressiontablecount) > 0
			BEGIN
				SET @indexreport = @indexreport + char(10) + '/* TSQL to implement ' + @compressiontype + ' compression */' + Char(10) + '-----------------------------------' + Char(10) + 'USE [' + @database + ']' + Char(10) + 'GO' + Char(10) + @missingindexcompressiontsql + Char(13) + Char(10)
			END
	IF (@changecompressionindexcount + @changecompressiontablecount) > 0
			BEGIN
				SET @indexreport = @indexreport + char(10) + '/* TSQL to change to ' + @compressiontype + ' compression type */' + Char(10)  + '-------------------------------------' + Char(10) + 'USE [' + @database + ']' + Char(10) + 'GO' + Char(10) + @changeindexcompressiontsql + Char(13) + Char(10)
			END	
-- Tidy up. Remove the temporary tables.
DROP TABLE ##MissingCompression
DROP TABLE ##ChangeCompression

-- Display report and email results if there are any required actions >
IF ( (@changecompressionindexcount + @changecompressiontablecount + @missingcompressionindexcount + @missingcompressiontablecount) > 0)
	BEGIN
		-- Compression changes recommended, display them
		PRINT @indexreport
		-- If email paramters supplied, email the results too.
		IF @emailrecipients <> '' AND @emailprofile <> '' 
			BEGIN
				SET @emailsubject =  @@SERVERNAME + ' : Uncompressed object report : ' + @database + ' (' + @compressiontype + ' compression)'
				-- send email
				EXEC msdb.dbo.sp_send_dbmail
					@recipients = @emailrecipients,
					@subject = @emailsubject,
					@body = @indexreport, 
					@profile_name = @emailprofile
			END		
		END
	ELSE
		BEGIN
			PRINT 'No database objects to compress'
		END
END








GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_085_read_tb_pages_save]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2011-03-24			*/
--Objetivo:  Restaura ou copia uma tabela direto das paginas de dados
/*
DECLARE @i Int
SET @i = Object_ID('wrx2_mapbin')
EXEC dbo.[prc1_Ase_085_read_tb_pages_save] @Object_ID = @i, @Qtde_Pages = 100
--truncate table xtb_save
select *  from wrx2_mapbin;
select * from dbo.xtb_save
*/
/********************************************************************************/
CREATE PROCEDURE [dbo].[prc1_Ase_085_read_tb_pages_save]
(@Object_ID Int,  @Qtde_Pages Int = 100)
AS
BEGIN

  BEGIN TRY
    SET NOCOUNT ON
      
    IF NOT EXISTS(SELECT 1 FROM sysobjects where id = @Object_ID)
    BEGIN
      print 'Specified object do not exists';
    END
    
    DECLARE @SQL VarChar(Max),
            @PageFID SmallInt, 
            @PagePID Integer
      
    CREATE TABLE #DBCC_IND_SQL2005_2008(ROWID           Integer IDENTITY(1,1) PRIMARY KEY, 
                                        PageFID         SmallInt, 
                                        PagePID         Integer, 
                                        IAMFID          Integer, 
                                        IAMPID          Integer, 
                                        ObjectID        Integer,
                                        IndexID         Integer,
                                        PartitionNumber BigInt,
                                        PartitionID     BigInt, 
                                        Iam_Chain_Type  VarChar(80), 
                                        PageType        Integer,
                                        IndexLevel      Integer,
                                        NexPageFID      Integer,
                                        NextPagePID     Integer,
                                        PrevPageFID     Integer,
                                        PrevPagePID     Integer)
       
    CREATE TABLE #DBCC_Page(ROWID        Integer IDENTITY(1,1) PRIMARY KEY, 
                            ParentObject VarChar(500),
                            Object       VarChar(500), 
                            Field        VarChar(500), 
                            Value        VarChar(Max))

    CREATE TABLE #Results(ROWID     Integer PRIMARY KEY, 
                            Page      VarChar(100), 
                            Slot      VarChar(300), 
                            Object    VarChar(300), 
                            FieldName VarChar(300), 
                            Value     VarChar(6000))

    CREATE TABLE #Columns(ColumnID Integer PRIMARY KEY, 
                          Name     VarChar(800))

    INSERT INTO #Columns
    SELECT ColID, 
           Name
      FROM syscolumns
     WHERE id = @Object_ID

    SELECT @SQL = 'DBCC IND(' + QUOTENAME(DB_NAME()) + 
                   ', ' + 
                   CONVERT(VarChar(20), @Object_ID) +
                   ', 1) WITH NO_INFOMSGS'

--    PRINT @SQL

    DBCC TRACEON(3604) WITH NO_INFOMSGS
  
    BEGIN
      INSERT INTO #DBCC_IND_SQL2005_2008
      EXEC (@SQL)
    END
    
    DECLARE cCursor CURSOR FOR
    SELECT TOP (@Qtde_Pages)
           PageFID, 
           PagePID 
      FROM #DBCC_IND_SQL2005_2008 
     WHERE PageType = 1

    OPEN cCursor

    FETCH NEXT FROM cCursor INTO @PageFID, @PagePID 

    WHILE @@FETCH_STATUS = 0
    BEGIN
      DELETE #DBCC_Page
      
      SELECT @SQL = 'DBCC PAGE ('  + 
                     QUOTENAME(DB_NAME()) + ',' + 
                     CONVERT(VarChar(20), @PageFID) + 
                     ',' + 
                     CONVERT(VarChar(20), @PagePID) + 
                     ', 3) WITH TABLERESULTS, NO_INFOMSGS '
--      PRINT @SQL
      
      INSERT INTO #DBCC_Page
      EXEC (@SQL)
      
      DELETE FROM #DBCC_Page 
       WHERE Object NOT LIKE 'Slot %' 
          OR Field = '' 
          OR Field IN ('Record Type', 'Record Attributes') 
          OR ParentObject in ('PAGE HEADER:')
      
      INSERT INTO #Results
      SELECT ROWID, cast(@PageFID as VarChar(20)) + ':' + CAST(@PagePID as VarChar(20)), ParentObject, Object, Field, Value FROM #DBCC_Page

      FETCH NEXT FROM cCursor INTO @PageFID, @PagePID 
    END
    
    CLOSE cCursor
    DEALLOCATE cCursor
    
   SELECT * FROM #Results

    SELECT @SQL = '
    SELECT ' + 
    STUFF(CAST((SELECT ',[' + Name + ']' 
                  FROM #Columns 
                 ORDER BY ColumnID FOR XML PATH('')) AS VarChar(MAX)), 1,1,'')+'
    FROM (SELECT CONVERT(VarChar(20), Page) + CONVERT(VarChar(500),Slot) p, FieldName x_FieldName_x, Value x_Value_x FROM #Results) Tab
    PIVOT(MAX(Tab.x_Value_x) FOR Tab.x_FieldName_x IN( ' 
          + STUFF((SELECT ',[' + Name + ']' FROM #Columns order by ColumnID for xml path('')), 1,1,'') + ' )
    ) AS pvt'
    
    exec(@SQL);
    select @SQL;
    insert into  dbo.xtb_save(xcod,xbase,xdescr)  
    exec(@SQL);
 


  END TRY
  BEGIN CATCH
    -- Execute error retrieval routine.
    SELECT ERROR_NUMBER()    AS ErrorNumber,
           ERROR_SEVERITY()  AS ErrorSeverity,
           ERROR_STATE()     AS ErrorState,
           ERROR_PROCEDURE() AS ErrorProcedure,
           ERROR_LINE()      AS ErrorLine,
           ERROR_MESSAGE()   AS ErrorMessage;
  END CATCH;
END
     ------------------------------------------------









GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_086_compress_tables]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2011-05-04						*/
--Objetivo:
--------------------------------------------------
--alter table object compression 
--------------------------------------------------
--exec dbo.[prc1_Ase_086_compress_tables]  'PAGE','dbo','wrx2_mapbin','PK_wrx2_mapbin'
--ALTER INDEX PK_wrx2_mapbin ON [dbo].[wrx2_mapbin] REBUILD PARTITION = ALL WITH (DATA_COMPRESSION = PAGE)

/********************************************************************************/
CREATE proc [dbo].[prc1_Ase_086_compress_tables] 
(
    @compression_type varchar(30) = 'PAGE', --(NONE, ROW, PAGE)
    @schema_name sysname = null,
    @table_name sysname = null,
    @index_name sysname = null
)
as
declare
    @sql_string nvarchar(4000),
    @edition varchar(30),
    @version varchar(10);

set @table_name = coalesce(quotename(@schema_name) + '.' + quotename(@table_name), null);


;with a as (
	select
        edition = convert(varchar, SERVERPROPERTY ('Edition')),
        version = convert(varchar, SERVERPROPERTY('ProductVersion'))
)
select 
	@edition = edition, 
	@version = left(version, charindex('.', version)-1) 
from a;


if @edition like 'Enterprise Edition%' or @edition like 'Developer Edition%' and @version >= 10
begin
    ;with cte as
    (
        select
			table_name = quotename(schema_name(tbl.schema_id)) + '.' + quotename (tbl.name),
            index_name = idx.name
        from
            sys.tables as tbl
        inner join
            sys.indexes as idx on idx.object_id = tbl.object_id
        inner join
            sys.partitions as p on p.object_id=cast(tbl.object_id as int) and p.index_id=idx.index_id
        where
            @compression_type <> (case p.data_compression
                                    when 0 then 'none'
                                    when 1 then 'row'
                                    when 2 then 'page'
                                end)
    )
    select table_name, index_name
        into #t1
    from cte
    where (@table_name is null or @table_name = table_name)
		and (@index_name is null or @index_name = index_name)
   
	set @table_name = '';
	set @index_name = '';
 
    declare c cursor static
    for
        select table_name, index_name from #t1;
           
    open c;
    fetch next from c into @table_name, @index_name;
    while @@FETCH_STATUS = 0
    begin
      
	if @index_name is null --it's a Heap  
		set @sql_string = 'ALTER TABLE @table_name REBUILD PARTITION = ALL WITH (DATA_COMPRESSION = @compression_type)';   
	else --it's an Clustered or Non-Clustered index
		set @sql_string = 'ALTER INDEX @index_name ON @table_name REBUILD PARTITION = ALL WITH (DATA_COMPRESSION = @compression_type)'; 
  
        set @sql_string = REPLACE(@sql_string, '@table_name', @table_name)
        set @sql_string = REPLACE(@sql_string, '@index_name', coalesce(@index_name,''))
        set @sql_string = REPLACE(@sql_string, '@compression_type', @compression_type)
      
        print @sql_string;
        exec sp_executesql @sql_string;
      
        fetch next from c into @table_name, @index_name;  
    end
    close c;
    deallocate c;
    
end
else
begin
	
	select 'This sql server edition/version isn''t compatible with data compressione feature.' as Warning, @edition as Edition, @version as Version;  

end;




GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_087_read_sysindexes]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-07-11					*/
--Objetivo:
--------------------------------------------------
--Retrieving Index Properties by Using the Bitwise AND Operator
--------------------------------------------------
--exec dbo.[prc1_Ase_087_read_sysindexes]
/********************************************************************************/
CREATE proc [dbo].[prc1_Ase_087_read_sysindexes] 
as
set nocount on
SELECT
  OBJECT_NAME([id]) AS table_name,
  [indid] AS index_id,
  [name] AS index_name,
  status,
  CASE
    WHEN status & 2 = 2 THEN 'Yes'
    ELSE 'No'
  END AS is_unique,
  CASE
    WHEN status & 16 = 16 THEN 'Yes'
    ELSE 'No'
  END AS is_clustered,
  CASE
    WHEN status & 2048 = 2048 THEN 'Yes'
    ELSE 'No'
  END AS is_PK_CNS,
  CASE
    WHEN status & 4096 = 4096 THEN 'Yes'
    ELSE 'No'
  END AS is_UNQ_CNS
FROM sysindexes
WHERE indid BETWEEN 1 AND 254 --clustered and nonclustered
and substring(OBJECT_NAME(id),1,3) not in('sys','sql','que','pla','fil')
and substring(name,1,3) <> '_WA' 
ORDER BY table_name, index_id

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_088_lst_datatype]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2012/11/09	*/
--Objetivo:
--list tables datatypes numbers      
--exec dbo.[prc1_Ase_088_lst_datatype] 167
/********************************************************************************/
CREATE procedure [dbo].[prc1_Ase_088_lst_datatype]@tp int
as
set nocount on

SET ANSI_WARNINGS On
SET ARITHABORT OFF
SET CURSOR_CLOSE_ON_COMMIT OFF

DECLARE @run INT

	IF(SELECT OBJECT_ID('xtb_columns')) IS NULL   
        CREATE TABLE xtb_columns (
	  	    colrow INT IDENTITY (1,1),
			object_id INTEGER, 
			column_id INTEGER, 
			tbl VARCHAR(500), 
			clm VARCHAR(500),
			run INT
			)
			else truncate table xtb_columns;
	
	    SET @run = 1

    INSERT INTO xtb_columns( object_id, column_id, tbl, clm, run )
	SELECT c.object_id, c.column_id, tb.name, c.name,@run
	  FROM sys.all_columns c	   
	  JOIN sys.tables tb on c.object_id = tb.object_id
	  JOIN sys.objects o on c.object_id = o.object_id
	 WHERE c.user_type_id = @tp           -- varchar() 
       and o.name NOT LIKE '%backup%'
       AND o.name NOT LIKE '%AdHoc%'
select * from xtb_columns;

select NAME,system_type_id,max_length,PRECISION,SCALE from sys.types

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_089_sql_server_mem]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2013-02-27				*/
--Sql Server memory
--exec dbo.[prc1_Ase_089_sql_server_mem]
/********************************************************************************/
/********************************************************************************/
create proc [dbo].[prc1_Ase_089_sql_server_mem]
as
set nocount on

-- Quanto de memória tem o servidor e o SQL Server!
select 
    (mem.total_physical_memory_kb / 1024) as total_physical_memory_MB,
    (available_physical_memory_kb / 1024) as available_physical_memory_MB,
    system_memory_state_desc
from sys.dm_os_sys_memory mem






GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_090_opt_Ad_hoc_workloads]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2013-02-02					*/
-- Descr:sp_configure'Optimize for Ad hoc Workloads',1 reconfigure with override
--exec dbo.[prc1_Ase_090_opt_Ad_hoc_workloads]
/********************************************************************************/
/********************************************************************************/
create proc [dbo].[prc1_Ase_090_opt_Ad_hoc_workloads]
as
set nocount on

select b.TEXT, a.usecounts, a.size_in_bytes, a.cacheobjtype,objtype 
from sys.dm_exec_cached_plans as a
cross apply sys.dm_exec_sql_text(plan_handle) as b
where text NOT like '%sys.dm%' and objtype = 'adhoc'



GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_091_alter_merge_range]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2013-02-02					*/
-- Descr:Merge do intervalo da partition function  func_range ()
--exec dbo.[prc1_Ase_091_alter_merge_range] 4800000
/********************************************************************************/
/********************************************************************************/
create proc [dbo].[prc1_Ase_091_alter_merge_range]@val int
as
set nocount on

ALTER PARTITION FUNCTION func_range ()
MERGE RANGE (@val);


GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_092_alter_split_func_range]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-11-13					*/
-- Descr:Split criando um intervalo func_range () SPLIT RANGE (3800000);
--exec dbo.[prc1_Ase_092_alter_split_func_range] 'fgrp2','fgrpix2',4800000
/********************************************************************************/
/********************************************************************************/
create proc [dbo].[prc1_Ase_092_alter_split_func_range] 
@fgrp char(10),@fgri char(10),@val int
as
set nocount on
declare @sql varchar(100);

-- Adidionando um Filegroup para a Partition Scheme
set @sql = '
ALTER PARTITION SCHEME [scheme_range]
NEXT USED' + @fgrp;

exec(@sql);

set @sql = '
ALTER PARTITION SCHEME [scheme_range_PK]
NEXT USED' + @fgri;

exec(@sql);

-- Adicionando um Intervalo 3800000
ALTER PARTITION FUNCTION func_range ()
SPLIT RANGE (@val);

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_093_plan_cache_allocated]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-11-27					*/
-- Descr:check to see how your plan cache is currently allocated
--exec dbo.[prc1_Ase_093_plan_cache_allocated]
/********************************************************************************/
/********************************************************************************/
create proc [dbo].[prc1_Ase_093_plan_cache_allocated]
as
set nocount on

SELECT objtype AS [CacheType],
    COUNT_BIG(*) AS [Total Plans],
    SUM(CAST(size_in_bytes AS DECIMAL(18, 2))) / 1024 / 1024 AS [Total MBs],
    AVG(usecounts) AS [Avg Use Count],
    SUM(CAST((CASE WHEN usecounts = 1 THEN size_in_bytes
        ELSE 0
        END) AS DECIMAL(18, 2))) / 1024 / 1024 AS [Total MBs – USE Count 1],
    SUM(CASE WHEN usecounts = 1 THEN 1
        ELSE 0
        END) AS [Total Plans – USE Count 1]
FROM sys.dm_exec_cached_plans
GROUP BY objtype
ORDER BY [Total MBs – USE Count 1] DESC


GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_094_plan_cache_cleared]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-11-27					*/
-- Descr:Clearing *JUST* the 'SQL Plans' based on *just* the amount of
--       Adhoc/Prepared single-use plans 
--exec dbo.[prc1_Ase_094_plan_cache_cleared]
/********************************************************************************/
/********************************************************************************/
CREATE proc [dbo].[prc1_Ase_094_plan_cache_cleared]
as
set nocount on

DECLARE @MB decimal(19,3)
        , @Count bigint
        , @StrMB nvarchar(20) 



SELECT @MB = sum(cast((CASE WHEN usecounts = 1 AND objtype IN ('Adhoc', 'Prepared') THEN size_in_bytes ELSE 0 END) as decimal(12,2)))/1024/1024 
        , @Count = sum(CASE WHEN usecounts = 1 AND objtype IN ('Adhoc', 'Prepared') THEN 1 ELSE 0 END)
        , @StrMB = convert(nvarchar(20), @MB)
FROM sys.dm_exec_cached_plans 

IF @MB > 10
        BEGIN
                DBCC FREESYSTEMCACHE('SQL Plans') 
                RAISERROR ('%s MB was allocated to single-use plan cache. Single-use plans have been cleared.', 10, 1, @StrMB)
         END
 ELSE
        BEGIN
                RAISERROR ('Only %s MB is allocated to single-use plan cache – no need to clear cache now.', 10, 1, @StrMB)
                 -- Note: this is only a warning message and not an actual error.
        END



GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_095_lst_physical_name]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-11-27					*/
-- Descr:list physical_name,the_file_path,the_file_name
--       Adhoc/Prepared single-use plans 
--exec dbo.[prc1_Ase_095_lst_physical_name]
/********************************************************************************/
/********************************************************************************/
create proc [dbo].[prc1_Ase_095_lst_physical_name]
as
set nocount on
SELECT physical_name
                               , LEFT(physical_name, LEN(physical_name) - (CHARINDEX('\',REVERSE(physical_name), 1))) AS the_file_path
                               , RIGHT(physical_name, CHARINDEX('\',REVERSE(physical_name)) - 1)AS the_file_name
                              FROM sys.[database_files] 
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_096_lst_memory_consumed]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-11-28					
This procedure looks at cache and totals the single-use plans
			to report the percentage of memory consumed (and therefore wasted)
			from single-use plans.*/
--exec dbo.[prc1_Ase_096_lst_memory_consumed] 10,10
/********************************************************************************/
/********************************************************************************/
create proc [dbo].[prc1_Ase_096_lst_memory_consumed]
(@Percent	decimal(6,3) OUTPUT,
 @WastedMB	decimal(19,3) OUTPUT)
as
set nocount on
DECLARE @ConfiguredMemory	decimal(19,3)
	, @PhysicalMemory		decimal(19,3)
	, @MemoryInUse			decimal(19,3)
	, @SingleUsePlanCount	bigint

CREATE TABLE #ConfigurationOptions
(
	[name]				nvarchar(35)
	, [minimum]			int
	, [maximum]			int
	, [config_value]	int				-- in bytes
	, [run_value]		int				-- in bytes
);
INSERT #ConfigurationOptions EXEC ('sp_configure ''max server memory''');

SELECT @ConfiguredMemory = run_value/1024/1024 
FROM #ConfigurationOptions 
WHERE name = 'max server memory (MB)'

SELECT @PhysicalMemory = total_physical_memory_kb/1024 
FROM sys.dm_os_sys_memory

SELECT @MemoryInUse = physical_memory_in_use_kb/1024 
FROM sys.dm_os_process_memory

SELECT @WastedMB = sum(cast((CASE WHEN usecounts = 1 AND objtype IN ('Adhoc', 'Prepared') 
								THEN size_in_bytes ELSE 0 END) AS DECIMAL(12,2)))/1024/1024 
	, @SingleUsePlanCount = sum(CASE WHEN usecounts = 1 AND objtype IN ('Adhoc', 'Prepared') 
								THEN 1 ELSE 0 END)
	, @Percent = @WastedMB/@MemoryInUse * 100
FROM sys.dm_exec_cached_plans

SELECT	[TotalPhysicalMemory (MB)] = @PhysicalMemory
	, [TotalConfiguredMemory (MB)] = @ConfiguredMemory
	, [MaxMemoryAvailableToSQLServer (%)] = @ConfiguredMemory/@PhysicalMemory * 100
	, [MemoryInUseBySQLServer (MB)] = @MemoryInUse
	, [TotalSingleUsePlanCache (MB)] = @WastedMB
	, TotalNumberOfSingleUsePlans = @SingleUsePlanCount
	, [PercentOfConfiguredCacheWastedForSingleUsePlans (%)] = @Percent
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_097_choose_clustered]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-11-28					
Finding a better candidate for your clustered indexes*/
--exec dbo.[prc1_Ase_097_choose_clustered] xtbl_Partition
/********************************************************************************/
/********************************************************************************/
CREATE proc [dbo].[prc1_Ase_097_choose_clustered]
@tb sysname
as
set nocount on
SELECT   OBJECT_NAME(S.[OBJECT_ID]) AS [OBJECT NAME],  
         I.[NAME] AS [INDEX NAME],  
         USER_SEEKS,  
         USER_SCANS,  
         USER_LOOKUPS,  
         USER_UPDATES  
FROM     sys.dm_db_index_usage_stats AS S  
         INNER JOIN sys.indexes AS I  
           ON I.[OBJECT_ID] = S.[OBJECT_ID]  
              AND I.INDEX_ID = S.INDEX_ID  
WHERE    OBJECT_NAME(S.[OBJECT_ID]) = @tb

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_098_lst_ix_non_used]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-12-14					
Finding table and all of the tables indexes that have not been used */
--exec dbo.[prc1_Ase_098_lst_ix_non_used]
/********************************************************************************/
/********************************************************************************/
CREATE proc [dbo].[prc1_Ase_098_lst_ix_non_used]
as
set nocount on
SELECT   DB_NAME() AS DATABASENAME, 
         OBJECT_NAME(B.OBJECT_ID) AS TABLENAME, 
         B.NAME AS INDEXNAME, 
         B.INDEX_ID 
FROM     SYS.OBJECTS A 
         INNER JOIN SYS.INDEXES B 
           ON A.OBJECT_ID = B.OBJECT_ID 
WHERE    NOT EXISTS (SELECT * 
                     FROM   SYS.DM_DB_INDEX_USAGE_STATS C 
                     WHERE  B.OBJECT_ID = C.OBJECT_ID 
                            AND B.INDEX_ID = C.INDEX_ID) 
         AND A.TYPE = 'U' 
ORDER BY 1, 2, 3 
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_099_lst_ix_inone_row]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-12-14					
Finding the index and the index columns in one row */
--exec dbo.[prc1_Ase_099_lst_ix_inone_row]
/********************************************************************************/
/********************************************************************************/
create proc [dbo].[prc1_Ase_099_lst_ix_inone_row]
as
set nocount on
SELECT   TABLENAME, INDEXNAME, INDEXID, [1] AS COL1, [2] AS COL2, [3] AS COL3, 
         [4] AS COL4
FROM     (SELECT A.NAME AS TABLENAME, 
                 B.NAME AS INDEXNAME, 
                 B.INDEX_ID AS INDEXID, 
                 D.NAME AS COLUMNNAME, 
                 C.KEY_ORDINAL 
          FROM   SYS.OBJECTS A 
                 INNER JOIN SYS.INDEXES B 
                   ON A.OBJECT_ID = B.OBJECT_ID 
                 INNER JOIN SYS.INDEX_COLUMNS C 
                   ON B.OBJECT_ID = C.OBJECT_ID 
                      AND B.INDEX_ID = C.INDEX_ID 
                 INNER JOIN SYS.COLUMNS D 
                   ON C.OBJECT_ID = D.OBJECT_ID 
                      AND C.COLUMN_ID = D.COLUMN_ID 
          WHERE  A.TYPE = 'u') P 
         PIVOT 
         (MIN(COLUMNNAME) 
          FOR KEY_ORDINAL IN ( [1],[2],[3],[4] ) ) AS PVT 
ORDER BY TABLENAME, INDEXNAME; 
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_100_lst_ix_used_row]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-12-14					
 index USER_SEEKS,USER_SCAN and USER_LOOKUP in one row */
--exec dbo.[prc1_Ase_100_lst_ix_used_row]
/********************************************************************************/
/********************************************************************************/
CREATE proc [dbo].[prc1_Ase_100_lst_ix_used_row]
as
set nocount on
SELECT   PVT.TABLENAME, PVT.INDEXNAME, [1] AS COL1, [2] AS COL2, [3] AS COL3, 
         [4] AS COL4, B.USER_SEEKS, 
         B.USER_SCANS, B.USER_LOOKUPS 
FROM     (SELECT A.NAME AS TABLENAME, 
                 A.OBJECT_ID, 
                 B.NAME AS INDEXNAME, 
                 B.INDEX_ID, 
                 D.NAME AS COLUMNNAME, 
                 C.KEY_ORDINAL 
          FROM   SYS.OBJECTS A 
                 INNER JOIN SYS.INDEXES B 
                   ON A.OBJECT_ID = B.OBJECT_ID 
                 INNER JOIN SYS.INDEX_COLUMNS C 
                   ON B.OBJECT_ID = C.OBJECT_ID 
                      AND B.INDEX_ID = C.INDEX_ID 
                 INNER JOIN SYS.COLUMNS D 
                   ON C.OBJECT_ID = D.OBJECT_ID 
                      AND C.COLUMN_ID = D.COLUMN_ID 
          WHERE  A.TYPE <> 'S') P 
         PIVOT 
         (MIN(COLUMNNAME) 
          FOR KEY_ORDINAL IN ( [1],[2],[3],[4] ) ) AS PVT 
         INNER JOIN SYS.DM_DB_INDEX_USAGE_STATS B 
           ON PVT.OBJECT_ID = B.OBJECT_ID 
              AND PVT.INDEX_ID = B.INDEX_ID 
              AND B.DATABASE_ID = DB_ID() 
ORDER BY TABLENAME, INDEXNAME; 

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_101_lst_ix_used_noused]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-12-14					
Finding the index INFORMATIONS in one row */
--exec dbo.[prc1_Ase_101_lst_ix_used_noused]
/********************************************************************************/
/********************************************************************************/
CREATE proc [dbo].[prc1_Ase_101_lst_ix_used_noused]
as
set nocount on
SELECT PVT.TABLENAME, PVT.INDEXNAME, PVT.INDEX_ID, [1] AS COL1, [2] AS COL2, [3] AS COL3, 
       [4] AS COL4,  [5] AS COL5, [6] AS COL6, [7] AS COL7, B.USER_SEEKS, 
       B.USER_SCANS, B.USER_LOOKUPS 
FROM   (SELECT A.NAME AS TABLENAME, 
               A.OBJECT_ID, 
               B.NAME AS INDEXNAME, 
               B.INDEX_ID, 
               D.NAME AS COLUMNNAME, 
               C.KEY_ORDINAL 
        FROM   SYS.OBJECTS A 
               INNER JOIN SYS.INDEXES B 
                 ON A.OBJECT_ID = B.OBJECT_ID 
               INNER JOIN SYS.INDEX_COLUMNS C 
                 ON B.OBJECT_ID = C.OBJECT_ID 
                    AND B.INDEX_ID = C.INDEX_ID 
               INNER JOIN SYS.COLUMNS D 
                 ON C.OBJECT_ID = D.OBJECT_ID 
                    AND C.COLUMN_ID = D.COLUMN_ID 
        WHERE  A.TYPE <> 'S') P 
       PIVOT 
       (MIN(COLUMNNAME) 
        FOR KEY_ORDINAL IN ( [1],[2],[3],[4],[5],[6],[7] ) ) AS PVT 
       INNER JOIN SYS.DM_DB_INDEX_USAGE_STATS B 
         ON PVT.OBJECT_ID = B.OBJECT_ID 
            AND PVT.INDEX_ID = B.INDEX_ID 
            AND B.DATABASE_ID = DB_ID() 
UNION  
SELECT TABLENAME, INDEXNAME, INDEX_ID, [1] AS COL1, [2] AS COL2, [3] AS COL3, 
       [4] AS COL4, [5] AS COL5, [6] AS COL6, [7] AS COL7, 0, 0, 0 
FROM   (SELECT A.NAME AS TABLENAME, 
               A.OBJECT_ID, 
               B.NAME AS INDEXNAME, 
               B.INDEX_ID, 
               D.NAME AS COLUMNNAME, 
               C.KEY_ORDINAL 
        FROM   SYS.OBJECTS A 
               INNER JOIN SYS.INDEXES B 
                 ON A.OBJECT_ID = B.OBJECT_ID 
               INNER JOIN SYS.INDEX_COLUMNS C 
                 ON B.OBJECT_ID = C.OBJECT_ID 
                    AND B.INDEX_ID = C.INDEX_ID 
               INNER JOIN SYS.COLUMNS D 
                 ON C.OBJECT_ID = D.OBJECT_ID 
                    AND C.COLUMN_ID = D.COLUMN_ID 
        WHERE  A.TYPE <> 'S') P 
       PIVOT 
       (MIN(COLUMNNAME) 
        FOR KEY_ORDINAL IN ( [1],[2],[3],[4],[5],[6],[7] ) ) AS PVT 
WHERE  NOT EXISTS (SELECT OBJECT_ID, 
                          INDEX_ID 
                   FROM   SYS.DM_DB_INDEX_USAGE_STATS B 
                   WHERE  DATABASE_ID = DB_ID(DB_NAME()) 
                          AND PVT.OBJECT_ID = B.OBJECT_ID 
                          AND PVT.INDEX_ID = B.INDEX_ID) 
ORDER BY TABLENAME, INDEX_ID; 

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_102_sp_hexadecimal]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2011-04-09					*/
--Objetivo:   Gera script dos logins para transferencia de servidor
--            exec [dbo].[prc1_Ase_102_sp_hexadecimal]
/********************************************************************************/
CREATE PROCEDURE [dbo].[prc1_Ase_102_sp_hexadecimal]
    @binvalue varbinary(256),
    @hexvalue varchar (514) OUTPUT
AS

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_103_sp_help_revlogin]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2011-04-09					*/
--Objetivo:   Gera script dos logins para transferencia de servidor
--            exec [dbo].[prc1_Ase_103_sp_help_revlogin]
/********************************************************************************/
CREATE PROCEDURE [dbo].[prc1_Ase_103_sp_help_revlogin]
@login_name sysname = NULL 
AS
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_104_lst_qry_cpu]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-12-21				*/
--Objetivo:   Lista as 30 queries mais usadas pela cpu 
--            exec [dbo].[prc1_Ase_104_lst_qry_cpu]
/********************************************************************************/
CREATE PROCEDURE [dbo].[prc1_Ase_104_lst_qry_cpu]
as

set nocount on

delete from x2tb_obj_Auditqry;

insert into x1dbsql.[dbo].[x2tb_obj_Auditqry]

SELECT TOP 30
 GETDATE() AS [Collection Date],
qs.execution_count AS Execution_Count,
 SUBSTRING(qt.text,qs.statement_start_offset/2 +1,
 (CASE WHEN qs.statement_end_offset = -1
 THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2
 ELSE qs.statement_end_offset END - qs.statement_start_offset
 )/2
 ) AS Query_Text,
 DB_NAME(qt.dbid) AS 'DB Name',
qs.total_worker_time AS 'Total CPU Time',
qs.total_worker_time/qs.execution_count AS 'Avg CPU Time (ms)',
qs.total_physical_reads AS 'Total Physical Reads',
qs.total_physical_reads/qs.execution_count AS 'Avg Physical Reads',
qs.total_logical_reads AS 'Total Logical Reads',
qs.total_logical_reads/qs.execution_count AS 'Avg Logical Reads',
qs.total_logical_writes AS 'Total Logical Writes',
qs.total_logical_writes/qs.execution_count AS 'Avg Logical Writes',
qs.total_elapsed_time AS 'Total Duration',
qs.total_elapsed_time/qs.execution_count AS 'Avg Duration (ms)',
qp.query_plan AS 'Plan' 
FROM sys.dm_exec_query_stats AS qs
 CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS qt
 CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) AS qp
 WHERE
 qs.execution_count > 50 OR
 qs.total_worker_time/qs.execution_count > 100 OR
 qs.total_physical_reads/qs.execution_count > 1000 OR
 qs.total_logical_reads/qs.execution_count > 1000 OR
 qs.total_logical_writes/qs.execution_count > 1000 OR
 qs.total_elapsed_time/qs.execution_count > 1000
 ORDER BY
 qs.execution_count DESC,
 qs.total_elapsed_time/qs.execution_count DESC,
 qs.total_worker_time/qs.execution_count DESC,
 qs.total_physical_reads/qs.execution_count DESC,
 qs.total_logical_reads/qs.execution_count DESC,
 qs.total_logical_writes/qs.execution_count DESC

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_105_lst_db_buffer_pages]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-12-21				*/
--Objetivo:   Lista (db_buffer_pages) de cada banco
--            exec [dbo].[prc1_Ase_105_lst_db_buffer_pages]
/********************************************************************************/
CREATE PROCEDURE [dbo].[prc1_Ase_105_lst_db_buffer_pages]
as

set nocount on

;WITH src AS

(
SELECT
database_id, db_buffer_pages = COUNT_BIG(*)
FROM sys.dm_os_buffer_descriptors
GROUP BY database_id
)
SELECT
[db_name] = CASE [database_id] WHEN 32767
THEN 'Resource DB'
ELSE DB_NAME([database_id]) END,
db_buffer_pages,
db_buffer_MB = db_buffer_pages / 128
FROM src
ORDER BY db_buffer_pages DESC;
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_106_lst_tot_server_mdf]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-12-21				*/
--Objetivo:   Lista o total de dados mdf NDF POR BANCO 
--            exec [dbo].[prc1_Ase_106_lst_tot_server_mdf]
/********************************************************************************/
CREATE PROCEDURE [dbo].[prc1_Ase_106_lst_tot_server_mdf]
as

set nocount on

Create Table ##temp
(
    DatabaseName sysname,
    Name sysname,
    physical_name nvarchar(500),
    size decimal (18,2),
    FreeSpace decimal (18,2)
)   
Exec sp_msforeachdb '
Use [?];
Insert Into ##temp (DatabaseName, Name, physical_name, Size, FreeSpace)
    Select DB_NAME() AS [DatabaseName], Name,  physical_name,
    Cast(Cast(Round(cast(size as decimal) * 8.0/1024.0,2) as decimal(18,2)) as nvarchar) Size,
    Cast(Cast(Round(cast(size as decimal) * 8.0/1024.0,2) as decimal(18,2)) -
        Cast(FILEPROPERTY(name, ''SpaceUsed'') * 8.0/1024.0 as decimal(18,2)) as nvarchar) As FreeSpace
    From sys.database_files
	where type <> 1
'
---------------------------
------------------------------------------------
Select databasename,physical_name,sum(size) area_mdf From ##temp
group by physical_name,databasename;
-----------------------------------------------------------------
Select convert(char(30),databasename) as bancos,sum(size) area_mdf_MB From ##temp
group by rollup (databasename) 
-----------------------------------------------------------------
drop table ##temp
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_107_lst_heap_tables]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-12-21				*/
--Objetivo:   Lista Heap Tables no indexes
--            exec [dbo].[prc1_Ase_107_lst_heap_tables]
/********************************************************************************/
create PROCEDURE [dbo].[prc1_Ase_107_lst_heap_tables]
as

set nocount on

 SELECT   OBJECT_NAME(IPS.OBJECT_ID)       AS TableName
         , CASE WHEN i.name IS NULL THEN
              'HEAP TABLE, NO INDEXES'
           ELSE
              i.name
           END                              AS IndexName
         , index_type_desc                  AS IndexType
         , index_depth
         , avg_fragmentation_in_percent
         , page_count
    FROM sys.dm_db_index_physical_stats(DB_ID(),NULL,NULL,NULL,'LIMITED') IPS
    JOIN sys.indexes I ON IPS.OBJECT_ID = I.OBJECT_ID AND IPS.index_id = I.index_id
ORDER BY avg_fragmentation_in_percent desc
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_108_cachestore]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-12-21	*/
--Objetivo:Diagnostic Information Queries
-- Memory Clerk Usage for instance 
--------------------------------------------------------------------
-- CACHESTORE_SQLCP  (SQL Plans)         
-- These are cached SQL statements or batches that 
-- Look for high value for CACHESTORE_SQLCP (Ad-hoc query plans)
--
-- CACHESTORE_OBJCP (Object Plans)      
-- These are compiled plans for 
-- stored procedures, functions and triggers
--
-- CACHESTORE_PHDR   (Bound Trees)  
-- An algebrizer trees for views, constraints and defaults.
--------------------------------------------------------------------
/*
exec [dbo].[prc1_Ase_108_cachestore]
 */ 
/********************************************************************************/
create  PROCEDURE [dbo].[prc1_Ase_108_cachestore] 
as
set nocount on
----------------------------------------------------------------------------------------------
--CACHESTORE_OBJCP. These are compiled plans for stored procedures, functions and triggers.
--CACHESTORE_SQLCP. This includes CACHESTORE_SQLCP (Ad-hoc query plans).
--CACHESTORE_PHDR.  These are algebrizer trees for views, constraints and defaults. 
----------------------------------------------------------------------------------------------
SELECT 
	LEFT([name], 20) as [name],
	LEFT([type], 20) as [type],
	pages_kb  AS cache_kb,
	[entries_count]
FROM sys.dm_os_memory_cache_counters 
where type in('CACHESTORE_SQLCP','CACHESTORE_PHDR','CACHESTORE_OBJCP')
order by pages_kb  DESC
--------------------------
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_109_buffer_cache_total]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-12-21	*/
--Objetivo:
------------------------------------------
--Obtendo Buffer Cache por Banco de Dados 
------------------------------------------
/*
exec [dbo].[prc1_Ase_109_buffer_cache_total]
 */ 
/********************************************************************************/
create  PROCEDURE [dbo].[prc1_Ase_109_buffer_cache_total] 
as
set nocount on
------------------------------------------
--Obtendo Buffer Cache por Banco de Dados 
------------------------------------------
Select CONVERT(CHAR(30),DB_NAME(database_id)) As 'Database',

COUNT(*) * 8 / 1024.0 As 'Cached_Size_MB'
INTO #TABDB

From sys.dm_os_buffer_descriptors

Where database_id <> 32767

Group By DB_NAME(database_id)

Order By 'Cached_Size_MB' Desc
----------------------------------------------
SELECT  * FROM #TABDB 
Order By 'Cached_Size_MB' Desc
----------------------------------------------
SELECT  SUM(Cached_Size_MB)as total_geral_MB FROM #TABDB --
----------------------------------------------
drop table #TABDB
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_110_lst_total_logdataAlloc_MB]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-12-21				*/
--Objetivo:   Lista total de espaco data/log por banco
--            exec [dbo].[prc1_Ase_110_lst_total_logdataAlloc_MB]
/********************************************************************************/
CREATE PROCEDURE [dbo].[prc1_Ase_110_lst_total_logdataAlloc_MB]
as

set nocount on
-- create temporary table that will store data space used information
CREATE TABLE ##tmp_sfs (
fileid int,
filegroup int,
totalextents int,
usedextents int,
name varchar(1024),
filename varchar(1024) ,
DBName varchar(128)
);
-- Declare variables
DECLARE @CMD varchar(2000);
-- Command to gather space for each database
SET @CMD = 'DECLARE @DBName varchar(128);
SET @DBName = ''?'';
INSERT INTO ##tmp_sfs (fileid,filegroup,totalextents,
usedextents,name,filename)
EXEC (''USE ['' + @DBName + '']
DBCC SHOWFILESTATS WITH NO_INFOMSGS'');
UPDATE ##tmp_sfs SET DBName = @DBName WHERE DBName is NULL';
-- Run command against each database
EXEC master.sys.sp_MSforeachdb @CMD ;
SELECT DBName,
[LOG File(s) Size (KB)] / 1024.0 AS [LogAllocMB],
[DataAllocMB],
[DataUsedMB]
into xtb3_log
FROM
(
SELECT instance_name as DBName, cntr_value, counter_name
FROM sys.dm_os_performance_counters
WHERE counter_name IN
(
'Log File(s) Size (KB)'
)
AND instance_name not in ('_Total','mssqlsystemresource')
UNION ALL
SELECT DBname
,totalextents * 8 / 128.0 AS cntr_value
, 'DataAllocMB' AS counter_name
FROM ##tmp_sfs
UNION ALL
SELECT DBname
,usedextents * 8 / 128.0 AS cntr_value
, 'DataUsedMB' AS counter_name
FROM ##tmp_sfs
) AS PerfCounters
PIVOT
(
SUM(cntr_value)
FOR counter_name IN
(
[LOG File(s) Size (KB)],
--Listing 1 Code that returns disk space usage information
--90 CHAPTER 9 Capacity planning
[DataAllocMB],
[DataUsedMB]
)
) AS pvt;
DROP TABLE ##tmp_sfs;
SELECT CASE 

                 WHEN (GROUPING(dbname) = 1) THEN 'Total_Geral'

                     ELSE ISNULL(dbname, 'NÃO INFORMADO')

               END AS dbname,sum(LogAllocMB)as LogAllocMB,SUM(DataAllocMB)as DataAllocMB,sum(DataUsedMB) as DataUsedMB
			   into #TB_REL
from [dbo].[xtb3_log]
group by rollup(dbname)

select * from #TB_REL;
drop table xtb3_log;
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_111_lst_dmv_db_index_stats]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-12-22				*/
--Objetivo:   Lista estatistica de oprecionalização dos indices na tabela
-- exec [dbo].[prc1_Ase_111_lst_dm_db_index_stats] 'x1dbsql','dbo.xtb_save'
/********************************************************************************/
create PROCEDURE [dbo].[prc1_Ase_111_lst_dmv_db_index_stats]
@db sysname, @tb sysname
as

set nocount on

 SELECT i.name,a.leaf_insert_count,a.nonleaf_insert_count
 ,a.leaf_delete_count,a.nonleaf_delete_count
 ,a.leaf_update_count,a.nonleaf_update_count
 ,a.leaf_allocation_count,a.page_lock_count
 FROM sys.dm_db_index_operational_stats(DB_ID(@db),OBJECT_ID(@tb),NULL,NULL) as a
 join sys.indexes i
 on i.index_id = a.index_id
 and i.object_id = a.object_id
 ---------------------------------

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_112_lst_dmv_executing]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-12-23				*/
--Purpose: Shows what individual SQL statements are running.
-- exec [dbo].[prc1_Ase_112_lst_dmv_executing]
/********************************************************************************/
CREATE proc [dbo].[prc1_Ase_112_lst_dmv_executing]

as

set nocount on

BEGIN

	-- Do not lock anything, and do not get held up by any locks. 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	-- What SQL Statements Are Currently Running?
	SELECT [Spid] = session_Id
		,ecid
		, [Database] = DB_NAME(sp.dbid)
		, [User] = nt_username
		, [Status] = er.status
		, [Wait] = wait_type
		, [Individual Query] = SUBSTRING (qt.text, er.statement_start_offset/2, 
			 (CASE WHEN er.statement_end_offset = -1 
				THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2 
			  ELSE er.statement_end_offset END - er.statement_start_offset)/2)
		,[Parent Query] = qt.text
		, Program = program_name
		, Hostname
		, nt_domain
		, start_time
	FROM sys.dm_exec_requests er 
	INNER JOIN sys.sysprocesses sp ON er.session_id = sp.spid
	CROSS APPLY sys.dm_exec_sql_text(er.sql_handle) as qt
	WHERE session_Id > 50			-- Ignore system spids. 
	AND session_Id NOT IN (@@SPID)	-- Ignore this current statement.
	ORDER BY 1, 2

END
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_113_defrag_extentinfo]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2013-02-27				*/
--dbcc extentinfo('x1dbsql','x1tb_obj_ChangeLog');
--exec dbo.[prc1_Ase_113_defrag_extentinfo]
/********************************************************************************/
/********************************************************************************/
CREATE proc [dbo].[prc1_Ase_113_defrag_extentinfo]
as
set nocount on

select avg_fragmentation_in_percent,avg_record_size_in_bytes,index_level,
	   page_count,database_id,avg_page_space_used_in_percent
from sys.dm_db_index_physical_stats(DB_ID('x1dbsql'),OBJECT_ID('xtbl_Partition'),1,NULL,'DETAILED');

dbcc traceon (3604);
dbcc extentinfo('x1dbsql','xtbl_Partition');

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_114_lst_BPE_usage]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-12-28			*/
--lista configuração Buffer Pool Extension (BPE) in SQL 2016
--exec dbo.[prc1_Ase_114_lst_BPE_usage]
/********************************************************************************/
/********************************************************************************/
CREATE proc [dbo].[prc1_Ase_114_lst_BPE_usage]
as
set nocount on
/*
sp_configure 'show advanced options',1  reconfigure with override
--------------------------------------------------------------------------
--Set the “max server memory” to 4GB:
--------------------------------------------------------------------------
EXEC sp_configure 'max server memory (MB)', 4096 reconfigure with override
--------------------------------------------------------------------------
--Configure the Buffer Pool Extention to 8 GB:
--------------------------------------------------------------------------
ALTER SERVER CONFIGURATION
SET BUFFER POOL EXTENSION ON
    (FILENAME = 'h:\SQLBuffer_bpe\ExtendedBuffer.BUF', SIZE = 8 GB);
--------------------------------------------------------------------------
--To see the configuration
--------------------------------------------------------------------------
SELECT * FROM   sys.dm_os_buffer_pool_extension_configuration
--------------------------------------------------------------------------
---------------------------------------------------------------------------------
--Querying BPE utilization
---------------------------------------------------------------------------------
SELECT CASE 
            WHEN database_id = 32767 THEN 'ms_resource_db'
            ELSE DB_NAME(database_id)
       END       AS database_name,
       COUNT(*)  AS cached_pages_count,
       CONVERT(NUMERIC(25, 4), COUNT(row_count) * 8.00 / 1024.00) AS size_mb,
       CONVERT(
           NUMERIC(25, 4),
           COUNT(row_count) * 8.00 / 1024.00 / 1024.00
       )         AS size_gb,is_in_bpool_extension
FROM   sys.dm_os_buffer_descriptors
GROUP BY database_id,is_in_bpool_extension 
---------------------------------------------------------------------------------
--Performance measurement of BPE:
---------------------------------------------------------------------------------
SELECT [object_name], counter_name, instance_name, cntr_value
FROM   sys.dm_os_performance_counters
WHERE  [object_name] LIKE '%Buffer Manager%'
       AND [counter_name] LIKE '%Extension%'
---------------------------------------------------------------------------------
--To turn off the BPE feature
---------------------------------------------------------------------------------
ALTER SERVER CONFIGURATION 
SET BUFFER POOL EXTENSION OFF
------------------------------------------------------
*/
print 'Como configurar o uso da extensão de memoria BPE';
print 'Buffer Pool Extension (BPE) in SQL 2016 ';

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_115_lst_ix_frag_status]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2016-01-24			*/
/*********************************************************************************
Script: Index Fragmentation Status (includes Partitioned)
**********************************************************************************/
--exec dbo.[prc1_Ase_115_lst_ix_frag_status]
/********************************************************************************/
/********************************************************************************/
CREATE proc [dbo].[prc1_Ase_115_lst_ix_frag_status]
as
set nocount on
select  schema_name(o.schema_id) as [schema_name] ,

        object_name(o.object_id) as [table_name] ,

        i.name as [index_name] ,

        i.type_desc as [index_type] ,

        dmv.page_count ,

        dmv.fragment_count ,

        round(dmv.avg_fragment_size_in_pages, 2, 2) [avg_fragment_size_in_pages] ,

        round(dmv.avg_fragmentation_in_percent, 2, 2) [avg_fragmentation_in_percent] ,

        case when dmv.avg_fragmentation_in_percent <= 5 then 'RELAX'

             when dmv.avg_fragmentation_in_percent <= 30 then 'REORGANIZE'

             when dmv.avg_fragmentation_in_percent > 30 then 'REBUILD'

        end as [action] ,

        stats_date(dmv.object_id, i.index_id) as stats_update_date ,

        case when isnull(ps.function_id, 1) = 1 then 'NO'

             else 'YES'

        end as partitioned ,

        coalesce(fg.name, fgp.name) as [file_group_name] ,

        p.partition_number as [partition_number] ,

        p.rows as [partition_rows] ,

        prv_left.value as [partition_lower_boundary_value] ,

        prv_right.value as [partition_upper_boundary_value] ,

        case when pf.boundary_value_on_right = 1 then 'RIGHT'

             when pf.boundary_value_on_right = 0 then 'LEFT'

             else 'NONE'

        end as [partition_range] ,

        pf.name as [partition_function] ,

        ds.name as [partition_scheme]

from    sys.partitions as p with ( readpast )

        inner join sys.indexes as i with ( readpast ) on i.object_id = p.object_id

                                                         and i.index_id = p.index_id

        inner join sys.objects as o with ( readpast ) on o.object_id = i.object_id

        inner join sys.dm_db_index_physical_stats(db_id(), null, null, null,

                                                  N'LIMITED') dmv on dmv.OBJECT_ID = i.object_id

                                                              and dmv.index_id = i.index_id

                                                              and dmv.partition_number = p.partition_number

        left join sys.data_spaces as ds with ( readpast ) on ds.data_space_id = i.data_space_id

        left join sys.partition_schemes as ps with ( readpast ) on ps.data_space_id = ds.data_space_id

        left join sys.partition_functions as pf with ( readpast ) on pf.function_id = ps.function_id

        left join sys.destination_data_spaces as dds with ( readpast ) on dds.partition_scheme_id = ps.data_space_id

                                                              and dds.destination_id = p.partition_number

        left join sys.filegroups as fg with ( readpast ) on fg.data_space_id = i.data_space_id

        left join sys.filegroups as fgp with ( readpast ) on fgp.data_space_id = dds.data_space_id

        left join sys.partition_range_values as prv_left with ( readpast ) on ps.function_id = prv_left.function_id

                                                              and prv_left.boundary_id = p.partition_number

                                                              - 1

        left join sys.partition_range_values as prv_right with ( readpast ) on ps.function_id = prv_right.function_id

                                                              and prv_right.boundary_id = p.partition_number

where   objectproperty(p.object_id, 'ISMSShipped') = 0

order by [avg_fragmentation_in_percent] DESC,

        [table_name] ,

        [index_name]	

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_116_lst_user_seeks_lookups]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2017-03-14		*/
/*********************************************************************************
objetivo: Lista  User_Seeks,User_Scans,User_Lookups,User_Updates
**********************************************************************************/
--exec dbo.[prc1_Ase_116_lst_user_seeks_lookups]
/********************************************************************************/
/********************************************************************************/
create proc [dbo].[prc1_Ase_116_lst_user_seeks_lookups]
as
set nocount on
SELECT
    ObjectName = OBJECT_SCHEMA_NAME(idx.object_id) + '.' + OBJECT_NAME(idx.object_id),
    IndexName = idx.name,
    IndexType = CASE WHEN is_unique = 1 THEN 'UNIQUE ' ELSE '' END + idx.type_desc,
    User_Seeks = us.user_seeks,
    User_Scans = us.user_scans,
    User_Lookups = us.user_lookups,
    User_Updates = us.user_updates
FROM
    sys.indexes idx
    LEFT JOIN sys.dm_db_index_usage_stats us ON idx.object_id = us.object_id AND idx.index_id = us.index_id AND us.database_id = DB_ID()
WHERE
    OBJECT_SCHEMA_NAME(idx.object_id) != 'sys' 
	and us.user_seeks is not null
ORDER BY
    us.user_seeks + us.user_scans + us.user_lookups DESC

GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_117_loadtrace]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2017-03-19	*/
---------------------------------------------------------------------------------------
--objetivo: Lê e cria tabela (xtb_tracelog) trace blackbox.trc oculto ou corrente log.trc
/*
 exec dbo.[prc1_Ase_117_loadtrace]
'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLWSRV14\MSSQL\data\blackbox.trc',xtb_blackbox
-------------------------------------------------------------------------------------------------
 exec dbo.[prc1_Ase_117_loadtrace]
'C:\Program Files\Microsoft SQL Server\MSSQL13.WSRV16\MSSQL\Log\log_87.trc',xtb_tracelog
*/
-------------------------------------------------------------------------------------------------
CREATE proc [dbo].[prc1_Ase_117_loadtrace] 
(@traceFileName VARCHAR(200), 
 @newTraceTableName sysname)                     

as
set nocount on
IF EXISTS (select name from sys.sysobjects where name = 'xtb_tracelog')
DROP TABLE [dbo].[xtb_tracelog];

IF EXISTS (select name from sys.sysobjects where name = 'xtb_blackbox')
DROP TABLE [dbo].[xtb_blackbox];

BEGIN 
                                DECLARE @tsqlStmt VARCHAR(400)
                                SET NOCOUNT ON
                                SET @tsqlStmt = 

-- BEGIN CALLOUT A
                                'SELECT IDENTITY(bigInt,1,1) AS Row_Number,' +
                                '* ' + ' INTO ' + RTRIM(LTRIM(@newTraceTableName)) +
                                ' FROM ::fn_trace_gettable ( ' + '''' + 
                                @traceFileName + '''' + ',default)'
-- END CALLOUT A

                                PRINT @tsqlStmt
                                EXEC (@tsqlStmt)
                                SET NOCOUNT OFF
END
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_118_qry_default_trace]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2011-04-10	alt:2017-03-19				*/
--Objetivo: -- Query the default trace file for Altered,Created,deleted objects
-- exec dbo.[prc1_Ase_118_qry_default_trace]'x1dbsql' 
/********************************************************************************/
CREATE proc [dbo].[prc1_Ase_118_qry_default_trace] @db sysname
as
DECLARE @Path varchar(256) = (
SELECT CONVERT(varchar(256),VALUE )
FROM   ::fn_trace_getinfo(1) 
WHERE  property = 2 ); SELECT @Path
-- 'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLWSRV14\MSSQL\Log\log_56.trc'

-- Query the default trace rollover file for altered objects
SELECT         
  e.name,objectName,DatabaseName,ServerName,LoginName,StartTime
FROM   ::fn_trace_gettable(@Path, 0) f
        INNER JOIN sys.trace_events e 
           ON eventclass = trace_event_id 
        INNER JOIN sys.trace_categories AS cat 
           ON e.category_id = cat.category_id 
WHERE  databasename = @db
       and  e.name in('Object:Altered','Object:Created','Object:deleted')
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_120_stop_trace_default]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2008-03-27		alt:2017-03-20				*/
--Objetivo: Stop and Run sql trace default 1 
--Exemplo:
/*
exec [dbo].[prc1_Ase_120_stop_trace_default]  0
exec [dbo].[prc1_Ase_120_stop_trace_default]  1
exec [dbo].[prc1_Ase_120_stop_trace_default] -1
*/                         
/********************************************************************************/
 create proc [dbo].[prc1_Ase_120_stop_trace_default]  @traceid int = 0
 as 
set nocount on

if @traceid = 0
   exec sp_configure 'default trace enabled', 0
   reconfigure; 
if @traceid = 1
   exec sp_configure 'default trace enabled', 1
   reconfigure; 
if @traceid < 0
begin
select 'Informe 0 para Stop trace default.'
select 'Informe 1 para Start trace default';
end
select * from sys.traces







GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_121_lst_trace_status]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2007-10-27		alt:2017-03-20				*/
--Objetivo: Monitora todos os traces existentes no banco 
/*
------------------------------------------------------------
exec dbo.prc1_Ase_121_lst_trace_status 0,0 -- 0,0		stop one trace
exec dbo.prc1_Ase_121_lst_trace_status 0,1 -- 0,1      start one trace
exec dbo.prc1_Ase_121_lst_trace_status 0,2 -- 0,2      stop and delete all traces
exec dbo.prc1_Ase_121_lst_trace_status                 list information all traces
exec dbo.prc1_Ase_121_lst_trace_status 0,-1 --0-1      list information all traces
exec dbo.prc1_Ase_121_lst_trace_status 2,-1 --2,-1     list blackbox 
exec dbo.prc1_Ase_121_lst_trace_status 1,-1 --1,-1     list trace default 
exec dbo.prc1_Ase_121_lst_trace_status-1,-1  -1,-1     list examples 
*/                         
/********************************************************************************/
  
CREATE proc [dbo].[prc1_Ase_121_lst_trace_status]  @traceid int = 0, @setstatus int = -1 as 
declare @events table (eventid int, [event] varchar(100))
declare @columns table (columnid int, [column] varchar(100))
declare @traces table (traceid int, [property] int, [tpdesc] nvarchar(245), check1 bit)
set nocount on

if @traceid < 0
begin
print 'Syntax for trace stored procedure.'
print 'trace [@traceid], [@setstatus]'
print 'The default for @traceid is 0.'
print 'The default for @setstatus is -1.'
print '@traceid	@setstatus		Operation'
print 
'exec dbo.prc1_Ase_121_lst_trace_status 0,0 -- 0,0		stop one trace
exec dbo.prc1_Ase_121_lst_trace_status 0,1 -- 0,1      start one trace
exec dbo.prc1_Ase_121_lst_trace_status 0,2 -- 0,2      stop and delete all traces
exec dbo.prc1_Ase_121_lst_trace_status                 list information all traces
exec dbo.prc1_Ase_121_lst_trace_status 0,-1 --0-1      list information all traces
exec dbo.prc1_Ase_121_lst_trace_status 2,-1 --2,-1     list blackbox 
exec dbo.prc1_Ase_121_lst_trace_status 1,-1 --1,-1     list trace default 
exec dbo.prc1_Ase_121_lst_trace_status-1,-1  -1,-1     list examples'

goto finish
end
Insert @events values (10,'RPC:Completed')
Insert @events values (11,'RPC:Starting')
Insert @events values (12,'SQL:BatchCompleted')
Insert @events values (13,'SQL:BatchStarting')
Insert @events values (14,'Audit Login')
Insert @events values (15,'Audit Logout')
Insert @events values (16,'Attention')
Insert @events values (17,'ExistingConnection')
Insert @events values (18,'Audit Server Starts and Stops')
Insert @events values (19,'DTCTransaction')
Insert @events values (20,'Audit Login Failed')
Insert @events values (21,'EventLog')
Insert @events values (22,'ErrorLog')
Insert @events values (23,'Lock:Released')
Insert @events values (24,'Lock:Acquired')
Insert @events values (25,'Lock:Deadlock')
Insert @events values (26,'Lock:Cancel')
Insert @events values (27,'Lock:Timeout')
Insert @events values (28,'Degree of Parallelism Event (7.0 Insert)')
Insert @events values (33,'Exception')
Insert @events values (34,'SP:CacheMiss')
Insert @events values (35,'SP:CacheInsert')
Insert @events values (36,'SP:CacheRemove')
Insert @events values (37,'SP:Recompile')
Insert @events values (38,'SP:CacheHit')
Insert @events values (39,'Deprecated')
Insert @events values (40,'SQL:StmtStarting')
Insert @events values (41,'SQL:StmtCompleted')
Insert @events values (42,'SP:Starting')
Insert @events values (43,'SP:Completed')
Insert @events values (44,'SP:StmtStarting')
Insert @events values (45,'SP:StmtCompleted')
Insert @events values (46,'Object:Created')
Insert @events values (47,'Object:Deleted')
Insert @events values (50,'SQL Transaction')
Insert @events values (51,'Scan:Started')
Insert @events values (52,'Scan:Stopped')
Insert @events values (53,'CursorOpen')
Insert @events values (54,'TransactionLog')
Insert @events values (55,'Hash Warning')
Insert @events values (58,'Auto Stats')
Insert @events values (59,'Lock:Deadlock Chain')
Insert @events values (60,'Lock:Escalation')
Insert @events values (61,'OLE DB Errors')
Insert @events values (67,'Execution Warnings')
Insert @events values (68,'Showplan Text (Unencoded)')
Insert @events values (69,'Sort Warnings')
Insert @events values (70,'CursorPrepare')
Insert @events values (71,'Prepare SQL')
Insert @events values (72,'Exec Prepared SQL')
Insert @events values (73,'Unprepare SQL')
Insert @events values (74,'CursorExecute')
Insert @events values (75,'CursorRecompile')
Insert @events values (76,'CursorImplicitConversion')
Insert @events values (77,'CursorUnprepare')
Insert @events values (78,'CursorClose')
Insert @events values (79,'Missing Column Statistics')
Insert @events values (80,'Missing Join Predicate')
Insert @events values (81,'Server Memory Change')
Insert @events values (82,'User Configurable (0-9)')
Insert @events values (83,'User Configurable (0-9)')
Insert @events values (84,'User Configurable (0-9)')
Insert @events values (85,'User Configurable (0-9)')
Insert @events values (86,'User Configurable (0-9)')
Insert @events values (87,'User Configurable (0-9)')
Insert @events values (88,'User Configurable (0-9)')
Insert @events values (89,'User Configurable (0-9)')
Insert @events values (90,'User Configurable (0-9)')
Insert @events values (91,'User Configurable (0-9)')
Insert @events values (92,'Data File Auto Grow')
Insert @events values (93,'Log File Auto Grow')
Insert @events values (94,'Data File Auto Shrink')
Insert @events values (95,'Log File Auto Shrink')
Insert @events values (96,'Showplan Text')
Insert @events values (97,'Showplan All')
Insert @events values (98,'Showplan Statistics Profile')
Insert @events values (100,'RPC Output Parameter')
Insert @events values (102,'Audit Statement GDR Event')
Insert @events values (103,'Audit Object GDR Event')
Insert @events values (104,'Audit AddLogin Event')
Insert @events values (105,'Audit Login GDR Event')
Insert @events values (106,'Audit Login Change Property Event')
Insert @events values (107,'Audit Login Change Password Event')
Insert @events values (108,'Audit Add Login to Server Role Event')
Insert @events values (109,'Audit Add DB User Event')
Insert @events values (110,'Audit Add Member to DB Role Event')
Insert @events values (111,'Audit Add Role Event')
Insert @events values (112,'Audit App Role Change Password Event')
Insert @events values (113,'Audit Statement Permission Event')
Insert @events values (114,'Audit Schema Object Access Event')
Insert @events values (115,'Audit Backup/Restore Event')
Insert @events values (116,'Audit DBCC Event')
Insert @events values (117,'Audit Change Audit Event')
Insert @events values (118,'Audit Object Derived Permission Event')
Insert @events values (119,'OLEDB Call Event')
Insert @events values (120,'OLEDB QueryInterface Event')
Insert @events values (121,'OLEDB DataRead Event')
Insert @events values (122,'Showplan XML')
Insert @events values (123,'SQL:FullTextQuery')
Insert @events values (124,'Broker:Conversation')
Insert @events values (125,'Deprecation Announcement')
Insert @events values (126,'Deprecation Final Support')
Insert @events values (127,'Exchange Spill Event')
Insert @events values (128,'Audit Database Management Event')
Insert @events values (129,'Audit Database Object Management Event')
Insert @events values (130,'Audit Database Principal Management Event')
Insert @events values (131,'Audit Schema Object Management Event')
Insert @events values (132,'Audit Server Principal Impersonation Event')
Insert @events values (133,'Audit Database Principal Impersonation Event')
Insert @events values (134,'Audit Server Object Take Ownership Event')
Insert @events values (135,'Audit Database Object Take Ownership Event')
Insert @events values (136,'Broker:Conversation Group')
Insert @events values (137,'Blocked Process Report')
Insert @events values (138,'Broker:Connection')
Insert @events values (139,'Broker:Forwarded Message Sent')
Insert @events values (140,'Broker:Forwarded Message Dropped')
Insert @events values (141,'Broker:Message Classify')
Insert @events values (142,'Broker:Transmission')
Insert @events values (143,'Broker:Queue Disabled')
Insert @events values (146,'Showplan XML Statistics Profile')
Insert @events values (148,'Deadlock Graph')
Insert @events values (149,'Broker:Remote Message Acknowledgement')
Insert @events values (150,'Trace File Close')
Insert @events values (152,'Audit Change Database Owner')
Insert @events values (153,'Audit Schema Object Take Ownership Event')
Insert @events values (155,'FT:Crawl Started')
Insert @events values (156,'FT:Crawl Stopped')
Insert @events values (157,'FT:Crawl Aborted')
Insert @events values (158,'Audit Broker Conversation')
Insert @events values (159,'Audit Broker Login')
Insert @events values (160,'Broker:Message Undeliverable')
Insert @events values (161,'Broker:Corrupted Message')
Insert @events values (162,'User Error Message')
Insert @events values (163,'Broker:Activation')
Insert @events values (164,'Object:Altered')
Insert @events values (165,'Performance statistics')
Insert @events values (166,'SQL:StmtRecompile')
Insert @events values (167,'Database Mirroring State Change')
Insert @events values (168,'Showplan XML For Query Compile')
Insert @events values (169,'Showplan All For Query Compile')
Insert @events values (170,'Audit Server Scope GDR Event')
Insert @events values (171,'Audit Server Object GDR Event')
Insert @events values (172,'Audit Database Object GDR Event')
Insert @events values (173,'Audit Server Operation Event')
Insert @events values (175,'Audit Server Alter Trace Event')
Insert @events values (176,'Audit Server Object Management Event')
Insert @events values (177,'Audit Server Principal Management Event')
Insert @events values (178,'Audit Database Operation Event')
Insert @events values (180,'Audit Database Object Access Event')
Insert @events values (181,'TM: Begin Tran starting')
Insert @events values (182,'TM: Begin Tran completed')
Insert @events values (183,'TM: Promote Tran starting')
Insert @events values (184,'TM: Promote Tran completed')
Insert @events values (185,'TM: Commit Tran starting')
Insert @events values (186,'TM: Commit Tran completed')
Insert @events values (187,'TM: Rollback Tran starting')
Insert @events values (188,'TM: Rollback Tran completed')
Insert @events values (189,'Lock:Timeout (timeout > 0)')
Insert @events values (190,'Progress Report: Online Index Operation')
Insert @events values (191,'TM: Save Tran starting')
Insert @events values (192,'TM: Save Tran completed')
Insert @events values (193,'Background Job Error')
Insert @events values (194,'OLEDB Provider Information')
Insert @events values (195,'Mount Tape')
Insert @events values (196,'Assembly Load')
Insert @events values (198,'XQuery Static Type')
Insert @events values (199,'QN: subscription')
Insert @events values (200,'QN: parameter table')
Insert @events values (201,'QN: template')
Insert @events values (202,'QN: dynamics')

Insert @columns values (1,'TextData')
Insert @columns values (2,'BinaryData')
Insert @columns values (3,'DatabaseID')
Insert @columns values (4,'TransactionID')
Insert @columns values (5,'LineNumber')
Insert @columns values (6,'NTUserName')
Insert @columns values (7,'NTDomainName')
Insert @columns values (8,'HostName')
Insert @columns values (9,'ClientProcessID')
Insert @columns values (10,'ApplicationName')
Insert @columns values (11,'LoginName')
Insert @columns values (12,'SPID')
Insert @columns values (13,'Duration')
Insert @columns values (14,'StartTime')
Insert @columns values (15,'EndTime')
Insert @columns values (16,'Reads')
Insert @columns values (17,'Writes')
Insert @columns values (18,'CPU')
Insert @columns values (19,'Permissions')
Insert @columns values (20,'Severity')
Insert @columns values (21,'EventSubClass')
Insert @columns values (22,'ObjectID')
Insert @columns values (23,'Success')
Insert @columns values (24,'IndexID')
Insert @columns values (25,'IntegerData')
Insert @columns values (26,'ServerName')
Insert @columns values (27,'EventClass')
Insert @columns values (28,'ObjectType')
Insert @columns values (29,'NestLevel')
Insert @columns values (30,'State')
Insert @columns values (31,'Error')
Insert @columns values (32,'Mode')
Insert @columns values (33,'Handle')
Insert @columns values (34,'ObjectName')
Insert @columns values (35,'DatabaseName')
Insert @columns values (36,'FileName')
Insert @columns values (37,'OwnerName')
Insert @columns values (38,'RoleName')
Insert @columns values (39,'TargetUserName')
Insert @columns values (40,'DBUserName')
Insert @columns values (41,'LoginSid')
Insert @columns values (42,'TargetLoginName')
Insert @columns values (43,'TargetLoginSid')
Insert @columns values (44,'ColumnPermissions')
Insert @columns values (45,'LinkedServerName')
Insert @columns values (46,'ProviderName')
Insert @columns values (47,'MethodName')
Insert @columns values (48,'RowCounts')
Insert @columns values (49,'RequestID')
Insert @columns values (50,'XactSequence')
Insert @columns values (51,'EventSequence')
Insert @columns values (52,'BigintData1')
Insert @columns values (53,'BigintData2')
Insert @columns values (54,'GUID')
Insert @columns values (55,'IntegerData2')
Insert @columns values (56,'ObjectID2')
Insert @columns values (57,'Type')
Insert @columns values (58,'OwnerID')
Insert @columns values (59,'ParentName')
Insert @columns values (60,'IsSystem')
Insert @columns values (61,'Offset')
Insert @columns values (62,'SourceDatabaseID')
Insert @columns values (63,'SqlHandle')
Insert @columns values (64,'SessionLoginName')

Insert into @traces 
 select [traceid], [property]
      , [tpdesc]  = 
	case
	when [property] = 1 and [value] = 1 then N' produces a rowset.'
	when [property] = 1 and [value] = 2 then
    N' creates a new file when max file size is reached.'
	when [property] = 1 and [value] = 3 then
    N' create a new file when max file size is reached and produce a rowset.'
	when [property] = 1 and [value] = 4 then N' shuts down the trace on an error.'
	when [property] = 1 and [value] = 5 then N' produces a rowset and shutdown on error.'
	when [property] = 1 and [value] = 6 then
    N' creates a new file when max file size is reached and shuts down on an error.'
	when [property] = 1 and [value] = 7 then
    N' creates a new file when max file size is reached, produces a rowset and shuts down on an error.'
	when [property] = 1 and [value] = 8 then N' is a Blackbox trace.'
	when [property] = 2 then N' results are in file ' + cast([value] as nvarchar(245)) + N'.'
	when [property] = 3 then N' max file size is ' + cast([value] as nvarchar(5)) + N' megabytes.'
	when [property] = 4 and [value] is not null then
    N' automatically stops on ' + cast([value] as nvarchar(25)) + '.'
	when [property] = 4 and [value] is null then N' does not automatically stop on any date and time.'
	when [property] = 5 and [value] = 0 then N' is stopped.'
	when [property] = 5 and [value] = 1 then N' is running.'
	end
       ,0
	from :: fn_trace_getinfo(0) order by [property] desc

if (select count(*) from @traces) < 1
	begin
		select 'No traces exist.' as [Trace Information]
		goto finish
	end

if @traceid > 0
	begin
	update @traces set check1 = 1 where [traceid] != @traceid
	if (select count(*) from @traces where [traceid] = @traceid) < 1
		begin
			select 'Trace number ' + cast(@traceid as varchar(3)) + ' does not exist.' as [Trace Information]
			goto finish
		end
	end

if (@setstatus = 0 or @setstatus = 1 or @setstatus = 2) goto changestatus

if @traceid < 1 select 'Trace number '  + cast([traceid] as nvarchar(3)) + [tpdesc]
                    as 'TRACE STATUS' from @traces where [property] = 5

while (select count(*) from @traces where check1 = 0) > 0
	begin
		select top 1 @traceid = traceid from @traces where check1 = 0
		select N'Trace number ' + cast(traceid as nvarchar(3)) + [tpdesc] as 'PROPERTY'
	    from @traces where traceid = @traceid order by [property] DESC
		select 'Trace number '  + cast(@traceid as nvarchar(3)) + ' is tracing event '
         + cast(a.eventid as nvarchar(3)) + ', ' + b.[event] + '.' as 'EVENT'
		  from ::fn_trace_geteventinfo(@traceid) a
		  left join @events b on a.eventid = b.eventid
		 group by a.eventid, b.[event]
		select 'Trace number '  + cast(@traceid as nvarchar(3)) + ' is tracing column '
         + cast(a.columnid as nvarchar(3)) + ', ' + b.[column] + '.' as 'COLUMN'
		  from ::fn_trace_geteventinfo(@traceid) a
		  left join @columns b on a.columnid = b.columnid
		 group by a.columnid, b.[column]
    if (select count(*) from ::fn_trace_getfilterinfo(@traceid)) > 0
		  select 'Trace number '  + cast(@traceid as nvarchar(3)) + ' filters on column '
  	 	 	   + cast(b.columnid as varchar(3)) +', ' + b.[column] + ', '
  		     + case a.comparison_operator
  					 when 0 then ' Equal '
  					 when 1 then ' Not Equal '
  					 when 2 then ' Greater Than '
  					 when 3 then ' Less Than '
  					 when 4 then ' Greater Than Or Equal '
  					 when 5 then ' Less Than Or Equal '
  					 when 6 then ' LIKE '
  					 when 7 then ' NOT LIKE '
  					 end
  				 + cast(value as varchar(50)) + ' '
		       + case a.logical_operator
		         when 0 then 'AND '
  		       when 1 then 'OR '
  		       end
          as 'FILTER'
  		  from ::fn_trace_getfilterinfo(@traceid) a
  		  left join @columns b on a.columnid = b.columnid
    else
      begin
        print 'Trace number '  + cast(@traceid as nvarchar(3)) + ' has no filters.'
        print ''
      end
		update @traces set check1 = 1 where traceid = @traceid
	end
goto finish
changestatus:
while (select count(*) from @traces where check1 = 0) > 0
  begin
		select top 1 @traceid = traceid from @traces where check1 = 0
		update @traces set check1 = 1 where [traceid] = @traceid
    if @setstatus = 0 and @traceid <> 1
     	begin
	     	exec sp_trace_setstatus @traceid, 0
       	select 'Trace number ' + cast(@traceid as varchar(3)) + ' is stopped.' as [Trace Information]
     	end
    if @setstatus = 1 and @traceid <> 1
     	begin
       	exec sp_trace_setstatus @traceid, 1
       	select 'Trace number ' + cast(@traceid as varchar(3)) + ' is running.' as [Trace Information]
     	end
		if @setstatus = 2 and @traceid <> 1
			begin
       	exec sp_trace_setstatus @traceid, 0
       	exec sp_trace_setstatus @traceid, 2
       	select 'Trace number ' + cast(@traceid as varchar(3)) + ' was stopped and deleted.' as [Trace Information]
			end
	end
finish:
set nocount off






GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_122_st_boot_page]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2007-03-27		alt:2017-03-20			*/
--Look at :
--dbi_dbccLastKnownGood = --the last time that DBCC CHECKDB ran without finding any corruptions.
--dbi_LastLogBackupTime = --the last backup time

--Parameter: database name
/*
exec dbo.[prc1_Ase_122_st_boot_page] x1dbsql
*/
/********************************************************************************/
CREATE proc [dbo].[prc1_Ase_122_st_boot_page] @db sysname
as
	set nocount on
declare @sql varchar(max)

set @sql =
 ' --One of the new features put into SQL Server was storing the last time
 --that DBCC CHECKDB completed successfully (called the last-known good time).
 --if DBCC CHECKDB runs to completion then it considers that a successful run 
 --even if it found some corruptions.
 --However, the last-known good time is ONLY updated if there were NO corruptions found. 
 --The last-known good time is stored in the boot page of the database - page 9.

--Look at :
--dbi_dbccLastKnownGood = --the last time that DBCC CHECKDB ran without finding any corruptions.
--dbi_LastLogBackupTime = --the last backup time'
print @sql

--set trace flag 3604
DBCC TRACEON (3604); 

--page 9 is the boot page
set @sql = 'DBCC PAGE ('+ @db + ', 1, 9, 3) with tableresults';
exec(@sql)







GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_123_xp_readerrorlog]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2010-09-13	alt:2017-03-27				*/
--Objetivo: Le errorlog com parametros:1-2-3-4
--1 Value of error log file : 0 = current, 1 = Archive #1, 2 = Archive #2, etc... 
--2 Log file type: 1 or NULL = error log, 2 = SQL Agent log 
--3 Search string 1: String one you want to search for 
--4 Search string 2: String two you want to search for to further refine the results
/*
exec [prc1_Ase_123_xp_readerrorlog] 0,2
exec [prc1_Ase_123_xp_readerrorlog] 0,1 
exec [prc1_Ase_123_xp_readerrorlog] 0, 2, Null, Null  
exec [prc1_Ase_123_xp_readerrorlog] 0,1,N'x1dbsql',N'starting' 
*/                         
/********************************************************************************/
  
create procedure [dbo].[prc1_Ase_123_xp_readerrorlog]  
   @p1     INT = 0, 
   @p2     INT = NULL, 
   @p3     NVARCHAR(255) = NULL, 
   @p4     NVARCHAR(255) = NULL 
as
set nocount on 
/*
	EXEC xp_readerrorlog 0, 1, NULL, NULL, NULL, NULL, N'desc'
-- Reads SQL Server error log from ERRORLOG.1 file
	EXEC xp_ReadErrorLog 1   
-- Reads current SQL Server error log	  
    EXEC xp_ReadErrorLog 0, 1  
 -- Reads current SQL Server Agent error log
    EXEC xp_ReadErrorLog 0, 2 
--Reads current SQL Server error log with text N'DBDNIT'
	EXEC xp_ReadErrorLog 0, 1,N'DBDNIT' 
--Reads current SQL Server error log with text  N'trace', N'Login'
    EXEC xp_ReadErrorLog 0, 1, N'trace', N'Login'
--Reads current SQL Server error log with text  N'trace', N'Login' from 27-03-2017
	EXEC xp_ReadErrorLog 0, 1, N'trace', N'Login','2017-03-27'
	*/
BEGIN 

   IF (NOT IS_SRVROLEMEMBER(N'securityadmin') = 1) 
   BEGIN 
      RAISERROR(15003,-1,-1, N'securityadmin') 
      RETURN (1) 
   END 
    
   IF (@p2 IS NULL) 
       EXEC sys.xp_readerrorlog @p1 
   ELSE 
       EXEC sys.xp_readerrorlog @p1,@p2,@p3,@p4 
END 






GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_124_load_errorlog]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2010-09-01   alt:2017-03-27					*/
--Objetivo: Le o errorlog carregando na tabela xtb3_errorlog 
--  
--exec [dbo].[prc1_Ase_124_load_errorlog]
/********************************************************************************/
/********************************************************************************/
CREATE PROC [dbo].[prc1_Ase_124_load_errorlog]
         --   @checkdate smalldatetime
AS 
 
SET NOCOUNT ON

DECLARE @no tinyint
DECLARE @filesize bigint
DECLARE @db_version char(1)
DECLARE @seq int

--IF @checkdate is null or @checkdate = ''
 --set @checkdate = convert(smalldatetime,convert(varchar(10),GETDATE(),120))

set @db_version = REPLACE(SUBSTRING(@@version, charindex('.0',@@version) -2, 2),SPACE(1),space(0))

CREATE TABLE t#errorlogno
( no tinyint
, date smalldatetime
, filesize bigint
)

CREATE TABLE t#errorlog
(
 seq  int identity(1,1) primary key
, logDate datetime
, processinfo varchar(100)
, error_txt varchar(4000)
)

CREATE TABLE t#errorlog_staging
(
 seq int identity
, errlog varchar(4000)
, cr tinyint
)

INSERT INTO t#errorlogno
EXEC master.dbo.xp_enumerrorlogs  

--declare  @checkdate smalldatetime
--set  @checkdate = '2010-09-01'

DECLARE crErrorLog CURSOR FOR
SELECT no, filesize FROM t#errorlogno WHERE no  >= 0
--(SELECT isnull(min(no),6) FROM t#errorlogno)  --WHERE date < @checkdate)
ORDER BY no DESC

OPEN crErrorLog 
FETCH NEXT FROM crErrorLog INTO @no, @filesize ;

WHILE (@@FETCH_STATUS = 0)
BEGIN
 
 If @filesize > 10485760 -- 10MB 
 BEGIN
  CLOSE crErrorLog;
  DEALLOCATE crErrorLog;
    
  DROP TABLE t#errorlogno
  DROP TABLE t#errorlog
  DROP TABLE t#errorlog_staging
  
  SELECT '2' -- SIZE 
  RETURN
 END

 if @db_version = '8'  -- SQL Server 2000 
 begin

  if @no = 0
   INSERT INTO t#errorlog_staging (errlog, cr)
              EXEC master.dbo.xp_readerrorlog -- SQL Server 2000 xp_readerrorlog 
  else  
   INSERT INTO t#errorlog_staging (errlog, cr)
              EXEC master.dbo.xp_readerrorlog @no
  
  insert into t#errorlog (logDate, processinfo, error_txt)
  select
              case when isdate(left(errlog,22)) = 1 then convert(smalldatetime,left(errlog,22)) else null end
             , case when isdate(left(errlog,22)) = 1 then substring(errlog, 24, charindex(space(1),errlog,24) - 24) else null end
             , case when isdate(left(errlog,22)) = 1 then substring (errlog, charindex(space(2),errlog) + 3, len(errlog)) else errlog end
             from t#errorlog_staging 

             truncate table t#errorlog_staging

 end
 else 

 begin
             insert into t#errorlog (logDate, processinfo, error_txt)
             EXEC master.dbo.xp_readerrorlog 
             @no
 end

           FETCH NEXT FROM crErrorLog INTO  @no, @filesize ;
END

 

CLOSE crErrorLog;
DEALLOCATE crErrorLog;

 
delete from t#errorlog where logdate is null
truncate table xtb3_errorlog;

insert into xtb3_errorlog
SELECT logDate, processinfo, error_txt 
 FROM t#errorlog 
WHERE 
          -- logdate > @checkdate
           error_txt not like 'Log was backed up%'  
           and error_txt not like 'Database backed up%'
         
ORDER BY seq ASC

select * from xtb3_errorlog
drop table t#errorlog
DROP TABLE t#errorlogno
DROP TABLE t#errorlog_staging
 





GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_125_lst_storage]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2017-04-13					*/
--Objetivo: Lista area de storage das tabela pelo prefixo
--exec [dbo].[prc1_Ase_125_lst_storage] x1t
--exec [dbo].[prc1_Ase_125_lst_storage] xtb
/********************************************************************************/
/********************************************************************************/
CREATE PROC [dbo].[prc1_Ase_125_lst_storage] @tb sysname
AS 
 
SET NOCOUNT ON

SELECT ObjectName = OBJECT_NAME(object_id),
object_id,
index_id,
allocation_unit_id,
used_pages,(used_pages * 8/1024) as page_MB,
AU.type_desc
FROM sys.allocation_units AS AU
INNER JOIN sys.partitions AS P
-- Container is hobt for in row data
-- and row overflow data
ON AU.container_id = P.hobt_id
-- IN_ROW_DATA and ROW_OVERFLOW_DATA
AND AU.type In (1, 3)
and substring(OBJECT_NAME(object_id),1,3) = @tb             
UNION ALL
SELECT ObjectName = OBJECT_NAME(object_id),
object_id,
index_id,
allocation_unit_id,
used_pages,(used_pages * 8/1024) as page_MB,
AU.type_desc
FROM sys.allocation_units AS AU
INNER JOIN sys.partitions AS P
-- Container is partition for LOB data
ON AU.container_id = P.partition_id
-- LOB_DATA
AND AU.type = 2 
and substring(OBJECT_NAME(object_id),1,3) = @tb
GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_126_find_unindexed_fk]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	2007-11-01	alt:2017-04-16 */
--Objetivo:
-----------------------------------------------------------
--Find unindexed foreign keys
-----------------------------------------------------------
--parametros : sem
--EXEC dbo.[prc1_Ase_126_find_unindexed_fk]
/********************************************************************************/
CREATE proc [dbo].[prc1_Ase_126_find_unindexed_fk]
as

SET NOCOUNT ON;
SET QUOTED_IDENTIFIER ON;

 ;WITH FKsNI (ObjectId, FKId) As (
SELECT DISTINCT
    parent_object_id, constraint_object_id
FROM sys.foreign_key_columns As FC
WHERE NOT EXISTS (
    SELECT * FROM sys.index_columns As IC
    WHERE
        FC.parent_object_id = IC.object_id AND
        FC.constraint_column_id = IC.index_column_id AND
        FC.parent_column_id = IC.column_id))

SELECT
    OBJECT_NAME(FKsNI.ObjectId) As Objeto,
    OBJECT_NAME(FKsNI.FKId) As FK,
    C.Name As Coluna
   --FC.constraint_column_id As Ordem
FROM FKsNI
INNER JOIN sys.foreign_key_columns As FC ON
    FKsNI.FKId = FC.constraint_object_id AND
    FKsNI.ObjectId = FC.parent_object_id
INNER JOIN sys.columns As C ON
    FC.parent_object_id = C.object_id AND
    FC.parent_column_id = C.column_id



GO

/****** Object:  StoredProcedure [dbo].[prc1_Ase_127_crindexed_fk]    Script Date: 10/02/2023 10:47:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************/
/*	Created By :	Degmar Gomes Barbosa		               		*/
/*	Created On :	lt:2017-04-16 */
--Objetivo:
-----------------------------------------------------------
--gera script para criação das fks sem indices
-----------------------------------------------------------
--parametros : sem
--EXEC dbo.[prc1_Ase_127_crindexed_fk]
/********************************************************************************/
create proc [dbo].[prc1_Ase_127_crindexed_fk]
as

SET NOCOUNT ON;
SET QUOTED_IDENTIFIER ON;

Select
'IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N''[dbo].['
+ tab.[name]
+ ']'') AND name = N''IX_'
+ cols.[name]
+ ''') '
+ 'CREATE NONCLUSTERED INDEX [IX_'
+ cols.[name]
+ '] ON [dbo].['
+ tab.[name]
+ ']( ['
+ cols.[name]
+ '] ASC ) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, 
IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, 
ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]'
From sys.foreign_keys keys
Inner Join sys.foreign_key_columns keyCols
 On keys.object_id = keyCols.constraint_object_id
Inner Join sys.columns cols
 On keyCols.parent_object_id = cols.object_id
 And keyCols.parent_column_id = cols.column_id
Inner Join sys.tables tab
 On keyCols.parent_object_id = tab.object_id
Order by tab.[name], cols.[name]


GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Objetivo:update tables [tx1_Extendednull] Extended Properties' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_000_load_Extnulltb'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Suporte de carga das procs não documentadas' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_001_load_Extnullsp'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Suporte de carga das views não documentadas' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_002_load_Extnullvw'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Objetivo:Lista "todos os triggers " de tabelas e database' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_003_list_Extended_triggers'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Objetivo:Lista "Extended Properties" de todas as tabelas' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_004_list_Extended_table'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Objetivo:Lista "Extended Properties" de todas as procedures' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_005_list_Extended_procs'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Objetivo:Lista "Extended Properties" de todas as views' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_006_list_Extended_views'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Objetivo:Lista "Extended Properties" de todas as functions' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_007_list_Extended_functions'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Objetivo:Lista "Extended Properties" de todas os idices' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_008_list_Extended_indexes'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Objetivo: cria view da tabela informada' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_009_create_V$view'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Objetivo: Realiza backup de todos os objetos fontes Procs-Funtions-Views-Triggers' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_010_create_obj_catalog'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Objetivo: List Most accessed tables into database' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_011_list_obj_accessed'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Objetivo: List Most accessed indexes into database' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_012_list_obj_accessed_ix'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Objetivo: how much memory is being used' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_013_memory_used'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'List all compression tables' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_014_list_compression_tables'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'lista func_range and scheme_range' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_015_read_partition_functions'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N' Lista total de buffer pages poR banco' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_016_lst_total_buffer_pages'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'list of database principals # role membership # dB level permissions' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_017_qry_dbPermissions'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Objetivo: Lista total de paginas e total MB de cada banco' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_018_list_database_pages'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Objetivo:Lista 20 queries mais demoradas' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_019_list_delay_queries'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Objetivo: Last time the table was accessed' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_020_list_last_accessed_tb'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N' Query the default trace by objects:--sp 8272, --tb 8277, --vw 8278' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_021_qry_default_object'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Objetivo: --Lista filegroups' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_022_list_filegroups'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'calculates the space information for the storage overview' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_023_list_database_overview'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Objetivo:--Lista map de area do banco informado' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_024_list_database_map'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Objetivo:--Lista map de area total dos bancos MDF,LDF,NDF' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_025_list_db_map_files'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Lista map de area dos indices geral banco informado' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_026_list_map_index_space'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'calculates the space information for storage overview ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_027_list_server_overview'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'This stored procedure calculates the table space ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_028_list_table_space'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'This stored procedure calculates the table space reorganization' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_029_list_table_space_reorg'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'This stored procedure list top user workload' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_030_list_user_workload'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'List dbbottlenecks' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_031_list_dbbottlenecks'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N' Conta valores non-null na tabela por coluna' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_032_count_typeNon_null'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Lista resultset na vertical' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_033_ShowDown'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'database_analysis' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_034_database_analysis'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'PageSplit - Extents allocated' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_035_database_bottleneck'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'List backup details' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_036_backups_detail'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Index Details' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_037_obj_index_det'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'List database sum details' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_038_list_obj_sum_db'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'List table details' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_039_list_obj_sum_table'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'List workload analysis total io/cpu/memory' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_040_list_workload_analysis'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N' List database storages on server ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_041_list_db_storages'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'List Page life expectancy' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_042_list_ple'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'List  last SQL Server backup' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_043_list_last_backup'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'List  last proc execution' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_044_list_last_proc_exec'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'List srv starting' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_045_list_srv_start'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'List Setting Optimize for ad hoc workloads' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_046_list_srv_adhoc'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'List uso de cpu por banco' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_047_list_cpu_by_dbase'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'List total de datacache + plancache = Bufferpool' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_048_list_tot_bufferpool'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'List VALORES RANDOMICOS PELOS TIPOS ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_049_list_random_types_values'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Localiza qualquer string dentro de objetos nao criptografados' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_050_seek_objs'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Find unindexed foreign keys' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_051_find_unindexed_fk'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'List allocation unit,page type, page description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_052_list_alloc_pages'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Lista operation,context,information on active log.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_053_crack_log_operation'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'gets an incremental snapshot of activity for all' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_054_find_activity_sql'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Lista tabelas com tipo de campos Nchar,Nvarchar,Ntext' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_055_list_unicode'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Calcula areas da tabela - Registro por paginas' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_056_calc_area_tbpages'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'instance level waits in SQL over a short period of time' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_057_list_wait_time'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Get file sizes of database files and free space on disk' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_058_list_file_size'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Lista detalhes do processo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_059_list_process_details'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Lista table indexes, size and column order' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_060_list_tbix_details'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Lista Set_File_Growth' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_061_list_Set_File_Growth'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Lista  ''Object:Deleted'', ''Object:Created'', ''Object:Altered''' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_062_list_objects_cre_del_alt'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Finding Queries IN sys.dm_exec_query_stats' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_063_list_qry_stats'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Information returned by sys.dm_db_missing_index_details' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_064_gera_missing_index'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Check FileSize and LogUsage for all DBs' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_065_lst_FileSize'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Objetivo: Lista falha de logins ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_066_lst_logins_fails'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Lista Tabelas com divisões de páginas (page split)  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_067_lst_tb_pagesplit'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Objetivo: Trunca log do banco informado ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_068_log_truncate'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Localiza qualquer string dentro de objetos' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_069_seek'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'List total data pages - number of rows used pages' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_070_lst_datapages_details'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Lista detalhes das tabelas particionadas' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_071_lst_paritioned_table'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Lista Storage Partition Funtions Schemes' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_072_lst_paritioned_details'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Cria Filegroup dinâmico para qualquer banco fgrp0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_073_cr_ndf_fgrp0'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Cria Filegroup dinâmico para qualquer banco fgrp1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_074_cr_ndf_fgrp1'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Cria Filegroup dinâmico para qualquer banco fgrp2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_075_cr_ndf_fgrp2'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Cria Filegroup dinâmico para qualquer banco fgrp3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_076_cr_ndf_fgrp3'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Cria Filegroup dinâmico para indice fgrpix0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_077_cr_ndf_fgrpix0'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Cria Filegroup dinâmico para indice fgrpix1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_078_cr_ndf_fgrpix1'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Cria Filegroup dinâmico para indice fgrpix2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_079_cr_ndf_fgrpix2'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Cria Filegroup dinâmico para indice fgrpix3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_080_cr_ndf_fgrpix3'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Objetivo: Lista range values e filegroups' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_081_lst_range_data_spaces'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Cria partition function e partition scheme com 4 niveis' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_082_Partition_Function'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N' Exemplos do uso dos comandos para particionamento' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_083_lst_docs_partition_cmd'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Objetivo:  List e audita Table & Index Compression' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_084_tbix_compression'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Restaura ou copia uma tabela direto das paginas de dados' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_085_read_tb_pages_save'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'alter table object compression ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_086_compress_tables'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Retrieving Index Properties by Using the Bitwise AND Operator' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_087_read_sysindexes'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'list tables datatypes numbers ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_088_lst_datatype'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Sql Server memory' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_089_sql_server_mem'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Optimize for Ad hoc Workloads' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_090_opt_Ad_hoc_workloads'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Merge do intervalo da partition function  func_range ()' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_091_alter_merge_range'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Split criando um intervalo func_range () ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_092_alter_split_func_range'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'check to see how your plan cache is currently allocated' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_093_plan_cache_allocated'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Clearing *JUST* the ''SQL Plans'' ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_094_plan_cache_cleared'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'list physical_name,the_file_path,the_file_name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_095_lst_physical_name'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'report the percentage of memory consumed' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_096_lst_memory_consumed'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Finding a better candidate for your clustered indexes' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_097_choose_clustered'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'the tables indexes that have not been used' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_098_lst_ix_non_used'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Finding the index and the index columns in one row' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_099_lst_ix_inone_row'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'index USER_SEEKS,USER_SCAN and USER_LOOKUP in one row ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_100_lst_ix_used_row'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Finding the index INFORMATIONS in one row' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_101_lst_ix_used_noused'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N' Lista as 30 queries mais usadas pela cpu ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_104_lst_qry_cpu'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Lista (db_buffer_pages) de cada banco' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_105_lst_db_buffer_pages'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Lista o total de dados mdf NDF POR BANCO ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_106_lst_tot_server_mdf'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Lista Heap Tables no indexes' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_107_lst_heap_tables'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'CACHESTORE_SQLCP  (SQL Plans) 
 CACHESTORE_OBJCP (Object Plans) 
CACHESTORE_PHDR   (Bound Trees)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_108_cachestore'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Obtendo Buffer Cache por Banco de Dados ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_109_buffer_cache_total'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Lista total de espaco data/log por banco' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_110_lst_total_logdataAlloc_MB'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Lista estatistica de oprecionalização dos indices na tabela' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_111_lst_dmv_db_index_stats'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N' Shows what individual SQL statements are running.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_112_lst_dmv_executing'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'dbcc extentinfo(''x1dbsql'',''xtbl_Partition'')' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_113_defrag_extentinfo'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'lista configuração Buffer Pool Extension (BPE) in SQL 2016' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_114_lst_BPE_usage'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Index Fragmentation Status (includes Partitioned)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_115_lst_ix_frag_status'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Lista  User_Seeks,User_Scans,User_Lookups,User_Updates' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_116_lst_user_seeks_lookups'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Lê e cria tabela (xtb_tracelog) trace blackbox.trc oculto ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_117_loadtrace'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Query the default trace file for Altered,Created,deleted objects' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_118_qry_default_trace'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N' Stop and Run sql trace default 1 ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_120_stop_trace_default'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Monitora todos os traces existentes no banco' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_121_lst_trace_status'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'DBCC CHECKDB ran without finding any corruptions.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_122_st_boot_page'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N' Le errorlog com parametros:1-2-3-4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_123_xp_readerrorlog'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Le o errorlog carregando na tabela xtb3_errorlog ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_124_load_errorlog'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Lista area de storage das tabela pelo prefixo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_125_lst_storage'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'Find unindexed foreign keys' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_126_find_unindexed_fk'
GO

EXEC sys.sp_addextendedproperty @name=N'SP', @value=N'gera script para criação das fks sem indices' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'prc1_Ase_127_crindexed_fk'
GO

