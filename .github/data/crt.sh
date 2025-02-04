#!/bin/bash
PKI_DIR="/etc/openvpn/keys"
echo 删除缓存目录 ${PKI_DIR}
rm -Rf ${PKI_DIR}
echo 新建目录 ${PKI_DIR}
mkdir -p ${PKI_DIR}
chmod -R 0600 ${PKI_DIR}
cd ${PKI_DIR}
touch index.txt; echo 1000 > serial
echo 新建证书目录 newcerts
mkdir newcerts
echo 拷贝配置文件
cp /etc/ssl/openssl.cnf ${PKI_DIR}
cd newcerts
echo 修改配置
PKI_CNF=${PKI_DIR}/openssl.cnf
sed -i '/^dir/   s:=.*:= /etc/openvpn/keys:' ${PKI_CNF}
sed -i '/.*Name/ s:= match:= optional:' ${PKI_CNF}
sed -i '/organizationName_default/    s:= .*:= WWW Ltd.:' ${PKI_CNF}
sed -i '/stateOrProvinceName_default/ s:= .*:= London:' ${PKI_CNF}
sed -i '/countryName_default/         s:= .*:= GB:' ${PKI_CNF}
sed -i '/default_days/   s:=.*:= 3650:' ${PKI_CNF} ## default usu.: -days 365
sed -i '/default_bits/   s:=.*:= 4096:' ${PKI_CNF} ## default usu.: -newkey rsa:2048
echo 添加必要的内容
cat >> ${PKI_CNF} <<"EOF"
###############################################################################
### Check via: openssl x509 -text -noout -in *.crt | grep 509 -A 1
[ server ]
# X509v3 Key Usage: Digital Signature, Key Encipherment
# X509v3 Extended Key Usage: TLS Web Server Authentication
keyUsage = digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth

[ client ]
# X509v3 Key Usage: Digital Signature
# X509v3 Extended Key Usage: TLS Web Client Authentication
keyUsage = digitalSignature
extendedKeyUsage = clientAuth

EOF
echo 生成CA密钥和证书
openssl req -batch -nodes -new -keyout "ca.key" -out "ca.crt" -x509 -config ${PKI_CNF} ## x509 (self-signed) for the CA
echo 生成Server密钥和证书
openssl req -batch -nodes -new -keyout "server.key" -out "server.csr" -subj "/CN=server" -config ${PKI_CNF}
openssl ca -batch -keyfile "ca.key" -cert "ca.crt" -in "server.csr" -out "server.crt" -config ${PKI_CNF} -extensions server
echo 生成Client密钥和证书
openssl req -batch -nodes -new -keyout "client1.key" -out "client1.csr" -subj "/CN=client1" -config ${PKI_CNF}
openssl ca -batch -keyfile "ca.key" -cert "ca.crt" -in "client1.csr" -out "client1.crt" -config ${PKI_CNF} -extensions client
echo 生成dh2048.pem文件, 这一步会很久
openssl dhparam -out dh2048.pem 2048
echo 开始复制证书文件
cp ca.crt client1.key client1.crt server.key server.crt /etc/openvpn
echo 修改OpenVPN Server配置文件
uci set openvpn.myvpn.dh=/etc/openvpn/dh2048.pem
uci set openvpn.myvpn.duplicate_cn=1
uci commit openvpn
echo 添加防火墙规则
sed -i '$a iptables -t nat -A PREROUTING -i eth1 -p udp --dport 53 -j REDIRECT --to-ports 1194' /etc/firewall.user
/etc/init.d/openvpn restart
/etc/init.d/firewall restart
echo 执行完毕