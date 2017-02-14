--index_visual.sql, a grid of a table's columns and their use in indexes
--created 2/13/2017
--drewsk.tech


DECLARE @COLUMNS NVARCHAR(MAX)
DECLARE @QSQL NVARCHAR(MAX)

--edit your table name here
DECLARE @INQTABLE NVARCHAR(100) = N'DMX_Entries'

SET @COLUMNS = STUFF((SELECT  ', [' +  NAME + ']   ' FROM
	( select ind.name
		from sys.tables t 
		left JOIN sys.indexes ind ON ind.object_id = t.object_id 
		WHERE t.name = @INQTABLE) TUF
		FOR XML PATH(''), TYPE
		).value('.', 'NVARCHAR(MAX)')
	,1,1,'')

set @QSQL = 'select *
from
(
select 
ind.name as indexname, 
tcol.name as columnname,
case when ic.is_included_column = 0 then 
		case when ind.type = 1 then ''C'' else ''X'' end
	else ''i'' end as columnused
from sys.tables t 
INNER JOIN sys.columns tcol on t.object_id = tcol.object_id
left JOIN sys.index_columns ic ON t.object_id = ic.object_id and ic.column_id = tcol.column_id --and ic.is_included_column = 0
left JOIN sys.columns col ON ic.object_id = col.object_id and ic.column_id = col.column_id 
left JOIN sys.indexes ind ON ind.object_id = t.object_id  and ind.index_id = ic.index_id
WHERE t.name = N'''+@INQTABLE+'''
) indecies
PIVOT
(
max(columnused)
for indexname IN ('+@COLUMNS+')
) as pivottable;'


EXECUTE(@QSQL)
