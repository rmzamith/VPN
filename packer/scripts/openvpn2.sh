yum install -y openvpn
modprobe iptable_nat
echo 1 | tee /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -s 10.4.0.1/2 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE

yum install easy-rsa -y --enablerepo=epel

mkdir /etc/openvpn/easy-rsa
cd /etc/openvpn/easy-rsa
cp -Rv /usr/share/easy-rsa/3.0.3/* .

./easyrsa init-pki
./easyrsa build-ca

./easyrsa gen-dh

./easyrsa gen-req server nopass

./easyrsa sign-req server server

./easyrsa gen-req client nopass

./easyrsa sign-req client client

cd /etc/openvpn
openvpn --genkey --secret pfs.key

mv /ops/server.conf /etc/openvpn/

sudo service openvpn start

cd /etc/openvpn
mkdir keys
cp pfs.key keys
cp /etc/openvpn/easy-rsa/pki/dh.pem keys
cp /etc/openvpn/easy-rsa/pki/ca.crt keys
cp /etc/openvpn/easy-rsa/pki/private/ca.key keys
cp /etc/openvpn/easy-rsa/pki/private/client.key keys
cp /etc/openvpn/easy-rsa/pki/issued/client.crt keys
chmod 777 *

zip -r keys.zip keys/

mv keys.zip /home/ec2-user