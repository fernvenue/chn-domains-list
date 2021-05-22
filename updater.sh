#!/bin/bash
eval $(ssh-agent -s)
echo "$SSH_PRIVATE_KEY" | tr -d '\r' | ssh-add -
mkdir -p ~/.ssh
chmod 700 ~/.ssh
ssh-keyscan github.com > ~/.ssh/known_hosts
chmod 644 ~/.ssh/known_hosts
git config --global user.email "$GITHUB_MAIL_ADDRESS"
git config --global user.name "fernvenue"
git clone git@github.com:fernvenue/chn-domains-list.git
cd './chn-domains-list'
curl 'https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/accelerated-domains.china.conf' -o './accelerated-domains.china.conf'
sed -i 's/[[:space:]]//g' './accelerated-domains.china.conf'
cp ./accelerated-domains.china.conf ./CHN.yaml
sed -i "s|server=/|  - '+.|g" ./CHN.yaml
sed -i "s|/114.114.114.114|'|g" ./CHN.yaml
sed -i "1s|^|payload:\n|" ./CHN.yaml
cp ./accelerated-domains.china.conf ./CHN.conf
sed -i "s|server=/|DOMAIN-SUFFIX,|g" ./CHN.conf
sed -i "s|/114.114.114.114||g" ./CHN.conf
cp ./accelerated-domains.china.conf ./CHN.txt
sed -i 's|server=|[|g' ./CHN.txt
sed -i 's|114.114.114.114|]tls://223.5.5.5|g' ./CHN.txt
curl 'https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/apple.china.conf' -o './apple.china.conf'
sed -i 's/[[:space:]]//g' './apple.china.conf'
cp ./apple.china.conf ./CHN.AAPL.yaml
sed -i "s|server=/|  - '+.|g" ./CHN.AAPL.yaml
sed -i "s|/114.114.114.114|'|g" ./CHN.AAPL.yaml
sed -i "1s|^|payload:\n|" ./CHN.AAPL.yaml
cp ./apple.china.conf ./CHN.AAPL.conf
sed -i "s|server=/|DOMAIN-SUFFIX,|g" ./CHN.AAPL.conf
sed -i "s|/114.114.114.114||g" ./CHN.AAPL.conf
cp ./apple.china.conf ./CHN.AAPL.txt
sed -i 's|server=|[|g' ./CHN.AAPL.txt
sed -i 's|114.114.114.114|]tls://223.5.5.5|g' ./CHN.AAPL.txt
git init
git add .
git commit -m 'Update CHN Domains list'
git push -u origin master
