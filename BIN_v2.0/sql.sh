#! /bin/bash

MYSQL_STATE()
{
(echo "show databases;" | mysql -pglenn) 2>/dev/null 1>/dev/null
ret=$(echo $?)
zero=0
if [ "$ret" -eq "$zero" ]
then echo OK
else echo KO
fi
}
MYSQL_STATE 
