sudo apt update

echo "Installing NodeJS"
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs

echo "Installing unzip"
sudo apt install unzip

echo "Installing mysql"
sudo apt install mysql-client-core-8.0 -y 
sudo apt install mysql-server -y
