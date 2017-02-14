# index_visual
MS SQL Server - TSQL Index Visualizer

## File Options ##

Use [index_visual.sql](https://github.com/dzsquared/index_visual/blob/master/index_visual.sql) to quickly run against a table on your database to determine which columns are used and/or included with indicies on a table.

Use [sp_index_visual.sql](https://github.com/dzsquared/index_visual/blob/master/sp_index_visual.sql) to create a stored procedure that outputs the same visual of columns/indicies on a table from an input parameter (table name).

## TSQL Output ##
The first column of output lists all of the columns of the specified table.  The subsequent columns detail all indexes on the specified table utilizing the following notation:

* C = clustered index column
* X = index column
* i = column included in index
