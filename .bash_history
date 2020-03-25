sudo yum update -y
sudo yum install -y mysql
export MYSQL_HOST=ulur2020db.cxrbnddhxclf.us-east-1.rds.amazonaws.com
mysql --user=admin --password=megapassword ulur2020db
sudo yum update -y
sudo amazon-linux-extras install docker
sudo yum install git -y
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -a -G docker ec2-user
sudo curl -L https://github.com/docker/compose/releases/download/1.25.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo reboot
mkdir wordpress && cd wordpress
mkdir nginx-conf
nano nginx-conf/nginx.conf
nano .env
git init
nano .gitignore
nano .dockerignore
nano docker-compose.yml
docker-compose up -d
docker-compose ps
ls
nano .env
docker-compose down
docker-compose up -d
docker-compose ps
ls
cd wordpress
ls
nano docker-compose.yml
cd ..
EXPORT MYSQL_HOST=ulur2020db.cxrbnddhxclf.us-east-1.rds.amazonaws.com
export MYSQL_HOST=ulur2020db.cxrbnddhxclf.us-east-1.rds.amazonaws.com
cd wordpress
ls
nano docker-compose.yml
nano .env
export MYSQL_HOST=megaulur.cxrbnddhxclf.us-east-1.rds.amazonaws.com
mysql --megaulur --password=megapassword megaulur
mysql --user=megaulur --password=megapassword megaulur
mysql --megaulur --password=megapassword megaulur
mysql --user=admin --password=megapassword megaulur
cd wordpress
nano .env
nano docker-compose.yml
docker-compose down
docker-compose up -d
ls
cd wordpress
docker-compose exec wordpress sh
docker-compose down
docker-compose up -d
cd wordpress
ls
docker-compose exec wordpress sh
docker-compose ps
docker-compose down
docker-compose up -d
docker-compose stop wordpress
docker-compose down
nano docker-compose ps
nano docker-compose.yml
docker-compose up -d
docker-compose logs
docker-compose ps
docker-compose logs
docker-compose down
nano docker-compose.yml
docker-compose up -d
docker-compose logs
docker-compose down
docker ps
docker ps -a
docker rm wordpress
docker-compose up -d
cd wordpress
ls
docker-compose.yml
nano docker-compose.yml
docker-compose exec wordpress sh
docker-compose down
docker-compose up -d
docker-compose down
cd wordpress
nano docker-compose.yml
docker-compose down
docker ps
docker ps -a
docker-compose up -d
docker-compose up --force-recreate --no-deps wordpress
docker-compose u -dp --force-recreate --no-deps wordpress
docker-compose up -d --force-recreate --no-deps wordpress
docker-compose up -d --force-recreate --no-deps webserver
docker-compose ps
docker-compose exec
cd wordpress
ls
docker-compose exec wordpress sh
docker-compose down
docker-compose up -d
ls -l
cd wordpress
ls
docker-compose ps
nano docker-compose.yml
docker-compose down
docker-compose up -d
docker-compose exec wordpress sh
cd wordpress
ls
docker-compose exec wordpress sh
cd wordpress
docker-compose exec wordpress sh
ls
cd wordpress
docker-compose logs
echo "# ULUR" >> README.md
git init
git add README.md
git commit -m "first commit"
git remote add origin https://github.com/SymphonycM/ULUR.git
git push -u origin master
exit
