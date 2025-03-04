#!/bin/bash
sudo apt clean
sudo apt update

echo "Installing NodeJS"
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs

echo "Installing unzip"
sudo apt install unzip

echo "------------------ AWS CLI ---------------------"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

echo "--------------- CodeDeploy Agent ---------------"
sudo apt-get install ruby -y
wget "https://aws-codedeploy-${AWS_REGION}.s3.${AWS_REGION}.amazonaws.com/latest/install"
chmod +x ./install
sudo ./install auto
echo "###INFO: Checking code deplot agent status ##"
sudo service codedeploy-agent status
if [[ $? -ne 0 ]]; then
    echo "WARNING: CodeDeploy agent is not up... Bringing it up..."
    sudo service codedeploy-agent start
    sudo service codedeploy-agent status
fi
echo "###INFO: Checking code deploy agent status again##"
sudo service codedeploy-agent status
if [[ $? -ne 0 ]]; then
    echo "ERROR: CodeDeploy agent is still not up. Exiting"
    exit 1
else
    echo "SUCCESS: CodeDeploy agent is live"
fi

echo "------------------- Cloud Watch ------------------------"
sudo rm /var/lib/dpkg/lock
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
sudo dpkg -i -E ./amazon-cloudwatch-agent.deb
echo "Copying cw-json "

sudo usermod -aG adm cwagent
echo "Listing cloudwatch service"
systemctl list-unit-files --type=service | grep amazon-cloudwatch-agent.service
echo "Enabling cloudwatch service"
sudo systemctl enable amazon-cloudwatch-agent.service
# echo "Starting cloudwatch service"
# sudo systemctl start amazon-cloudwatch-agent.service
echo "Status of cloudwatch agent"
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a status