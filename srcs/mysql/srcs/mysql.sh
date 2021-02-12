echo "CREATE DATABASE IF NOT EXISTS wordpress;" \
	| mysql -u root --skip-password &&\
	echo "CREATE USER IF NOT EXISTS 'hroh'@'%' IDENTIFIED BY 'hroh';" \
	| mysql -u root --skip-password &&\
	echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'hroh'@'%' WITH GRANT OPTION;" \
	| mysql -u root --skip-password
mysql -u root --skip-password --database=wordpress < wordpress.sql