#!/bin/bash

#These are some queries that I write pretty frequently when dealing with
#databases (MySQL database) at work. I get tired of typing select and the name of the 
#table over and over again, so instead I just run these from the command
#line. Not intended to be elegant. Was thrown together quickly and just
#intended to get the job done.

#I would write something like––queries.sh table_name -o column_of_interest

TABLE=$1
echo "Table: $TABLE"
QUERY=
while :; do
	case $2 in
		-c|--count)
			QUERY="select count(*) from $TABLE"
			break
			;;
		-a|--all)
			QUERY="select * from $TABLE"
			break
			;;
		-f|--field)
			QUERY="select $3 from $TABLE"
			break
			;;
		-o|--order)
			QUERY="select sq.what as $3, sq.howMany as \"Instances of $3\" from (select $3 as what, count($3) as howMany from $TABLE group by $3) as sq order by sq.howMany desc"
			break
			;;
		-l|--limit)
			QUERY="select $3 from $TABLE limit $4"
			break
			;;
		-n|--countnull)
			QUERY="select count(*) from $TABLE where $3 is null"
			break
			;;
		-e|--qry)
			QUERY=$3
			break
			;;
		-N|--notnull)
			QUERY="select count(*) from $TABLE where $3 is not null"
			break
			;;
		-d|--describe)
			QUERY="describe $TABLE"
			break
			;;
		-u|--unique)
			QUERY="select distinct $3 from $TABLE"
			break
			;;
		-U|--countunique)
			QUERY="select count(distinct $3) from $TABLE"
			break
			;;	
		-w|--where)
			QUERY="select * from $TABLE where $3"
			break
			;;
		-W|--countwhere)
			QUERY="select count(*) from $TABLE where $3"
			break
			;;	
		--min)
			QUERY="select min($3) from $TABLE"
			break
			;;
		--max)
			QUERY="select max($3) from $TABLE"
			break
			;;
		--avg)
			QUERY="select avg($3) from $TABLE"
			break
			;;
		--sum)
			QUERY="select sum($3) from $TABLE"
			break
			;;


	esac
done

QUERY="$QUERY;"
echo "Query: $QUERY"

mysql -h ********* -P ***** -u ******************* --password=************************ --database=************************ --table 2> /dev/null << EOF
$QUERY
EOF

