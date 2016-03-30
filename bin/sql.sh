#! /bin/bash

MYSQL_STATE()
{
mysql_pass="passmysql"
(echo "show databases;" | mysql -uroot -pglenn) 2>/dev/null 1>/dev/null
ret=$(echo $?)
#echo $ret
zero=0
if [ "$ret" -eq "$zero" ]
then echo OK
else echo KO
fi
}
MYSQL_STATE 
