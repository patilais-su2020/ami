sudo apt update

echo "Installing NodeJS"
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs

echo "Installing mysql"
sudo apt install mysql-client-core-8.0 -y 
sudo apt install mysql-server -y
sudo mysql << EOF
CREATE USER 'admin' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' WITH GRANT OPTION;
flush privileges;
create database webappdb;
use webappdb;
create table users(id integer auto_increment primary key, firstName text not null, lastName text not null, email text not null, password text not null);
create table books(id integer auto_increment primary key, isbn bigint(20) not null, title text not null, authors text not null, publication_date date not null, quantity integer not null, price double not null, createdOn datetime not null, updatedOn datetime not null, user_id integer, deleted boolean default false, foreign key (user_id) references users(id));
create table cart(id integer primary key auto_increment, book_id integer not null, buyer_id integer not null, seller_id integer not null, quantity integer not
null, foreign key (book_id) references books(id), foreign key (buyer_id) references users(id), foreign key (seller_id) references users(id));
EOF
