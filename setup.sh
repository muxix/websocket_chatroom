set -ex
# clone 代码到 /var/www/chatroom

# 换源
cp /var/www/chatroom/misc/sources.list /etc/apt/sources.list
mkdir -p /root/.pip
cp /var/www/chatroom/misc/pip.conf /root/.pip/pip.conf

# 装依赖 第三方仓库
add-apt-repository -y ppa:deadsnakes/ppa
apt-get update

# 系统设置
apt-get -y install ufw
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ufw allow 22
ufw allow 80
ufw allow 443
# ufw allow 25
ufw default deny incoming
ufw default allow outgoing
ufw status verbose
ufw -f enable

# 装依赖
apt-get install -y python3.6 python3-pip
python3.6 /var/www/chatroom/get-pip.py
pip3 install flask eventlet flask-socketio

# 启动并后台运行
cd /var/www/chatroom
nohup python3.6 chat.py &

echo 'succsss'
echo 'ip'
hostname -I