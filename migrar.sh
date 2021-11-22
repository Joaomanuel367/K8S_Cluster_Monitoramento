#!/bin/bash
caminho=$(pwd)
echo $caminho
DB=$1
TABLES=$(sqlite3 $DB .tables | sed -r 's/(\S+)\s+(\S)/\1\n\2/g' | grep -v migration_log)
echo "USE grafana;" > $caminho/grafana.sql
for t in $TABLES; do
    echo "TRUNCATE TABLE $t;"
done >> $caminho/grafana.sql
echo -e "alter table dashboard_tag change term term longtext;\n" >> $caminho/grafana.sql
for t in $TABLES; do
    echo -e ".mode insert $t\nselect * from $t;"
done | sqlite3 $DB >> $caminho/grafana.sql
sed -i 's/INSERT/REPLACE/g' $caminho/grafana.sql
