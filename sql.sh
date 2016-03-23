#! /bin/bash 
MYSQL_STATE()
{
mysql_pass="passmysql"
(echo "show databases;" | mysql -u root --password=$mysql_pass) 2>/dev/null 1>/dev/null
ret=$(echo $?)
#echo $ret
zero=0
if [ "$ret" -eq "$zero" ] 
        then echo OK
        else echo KO 
fi
}
MYSQL_STATE  
