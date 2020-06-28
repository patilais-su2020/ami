sudo apt update

echo "Installing NodeJS"
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs

echo "Installing unzip"
sudo apt install unzip

echo "--------------- CodeDeploy Agent ---------------"
sudo apt-get install ruby -y
wget "https://aws-codedeploy-{{user `aws_region`}}.s3.{{user `aws_region`}}.amazonaws.com/latest/install"
chmod +x ./install
sudo ./install auto
echo "###INFO: Checking code deplot agent status ##"
sudo service codedeploy-agent status
if [[ $? -ne 0 ]]; then
    echo "WARNING: CodeDeploy agent is not up... Bringing it up..."
    sudo service codedeploy-agent start
    sudo service codedeploy-agent status
fi
echo "###INFO: Checking code deplot agent status again##"
sudo service codedeploy-agent status
if [[ $? -ne 0 ]]; then
    echo "ERROR: CodeDeploy agent is still not up. Exiting"
    exit 1
else
    echo "SUCCESS: CodeDeploy agent is live"
fi