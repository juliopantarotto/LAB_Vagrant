# Declarando Variaveis
rede="172.16.17"
dominio="lab.example"
usuario="julio.pantarotto"
senha="123mudar"

# Instalar utilitários basicos
dnf install -y epel-release && sudo dnf clean all && \
dnf install -y vim curl wget rsync net-tools traceroute \
tcpdump bind-utils yum-utils git sshpass htop

# Desabilitando SELINUX
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
setenforce 0

# Garantindo as chaves
KEY_PATH='/vagrant/files'
mkdir -p /root/.ssh
cp $KEY_PATH/id_rsa /root/.ssh/id_rsa
cp $KEY_PATH/id_rsa.pub /root/.ssh/id_rsa.pub
cp $KEY_PATH/id_rsa.pub /root/.ssh/authorized_keys
chmod 400 /root/.ssh/id_rsa*
cat /root/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys

# Config sudoers
mv /etc/sudoers /etc/sudoers_original
cp /vagrant/files/sudoers /etc/sudoers
chmod 0440 /etc/sudoers

getent passwd $usuario > /dev/null
if [ "$?" -ne 0 ]; then
  useradd -d /home/$usuario -m -s /bin/bash -c "--/sys/${usuario}@${dominio}" -p"$senha" $usuario
  gpasswd -a $usuario wheel
  mkdir -p /home/$usuario/.ssh
  cp $KEY_PATH/id_rsa /home/$usuario/.ssh/id_rsa
  cp $KEY_PATH/id_rsa.pub /home/$usuario/.ssh/id_rsa.pub
  chmod 400 /home/$usuario/.ssh/id_rsa*
  cp $KEY_PATH/id_rsa.pub /home/$usuario/.ssh/authorized_keys
  chown -R $usuario. /home/$usuario/.ssh
fi

# Garantindo os hosts
HOSTS=$(head -n7 /etc/hosts)
echo -e "$HOSTS" > /etc/hosts
echo "${rede}.10 database-01.${dominio}" >> /etc/hosts
echo "${rede}.20 docker-swarm-01.${dominio}" >> /etc/hosts
echo "${rede}.30 docker-swarm-02.${dominio}" >> /etc/hosts
echo "${rede}.40 docker-swarm-03.${dominio}" >> /etc/hosts