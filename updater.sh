#!/bin/bash
eval $(ssh-agent -s)
echo "$SSH_PRIVATE_KEY" | tr -d "\r" | ssh-add -
mkdir -p ~/.ssh
chmod 700 ~/.ssh
ssh-keyscan gitlab.com > ~/.ssh/known_hosts
git config --global user.email "$GIT_MAIL_ADDRESS"
git config --global user.name "fernvenue"
git clone git@gitlab.com:fernvenue/chn-domains-list.git
cd "./chn-domains-list"
curl "https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/accelerated-domains.china.conf" -o "./accelerated-domains.china.conf"
sed -i "/^#/d" "./accelerated-domains.china.conf"
sed -i "s/[[:space:]]//g" "./accelerated-domains.china.conf"
cp ./accelerated-domains.china.conf ./CHN.txt
sed -i "s|server=/||g" ./CHN.txt
sed -i "s|/114.114.114.114||g" ./CHN.txt
cp ./accelerated-domains.china.conf ./CHN.conf
sed -i "s|server=/|DOMAIN-SUFFIX,|g" ./CHN.conf
sed -i "s|/114.114.114.114||g" ./CHN.conf
cp ./accelerated-domains.china.conf ./CHN.yaml
sed -i "s|server=/|  - '+.|g" ./CHN.yaml
sed -i "s|/114.114.114.114|'|g" ./CHN.yaml
sed -i "1s|^|payload:\n|" ./CHN.yaml
rm ./accelerated-domains.china.conf
curl "https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/apple.china.conf" -o "./apple.china.conf"
sed -i "/^#/d" "./apple.china.conf"
sed -i "s/[[:space:]]//g" "./apple.china.conf"
cp ./apple.china.conf ./CHN.AAPL.txt
sed -i "s|server=/||g" ./CHN.AAPL.txt
sed -i "s|/114.114.114.114||g" ./CHN.AAPL.txt
cp ./apple.china.conf ./CHN.AAPL.conf
sed -i "s|server=/|DOMAIN-SUFFIX,|g" ./CHN.AAPL.conf
sed -i "s|/114.114.114.114||g" ./CHN.AAPL.conf
cp ./apple.china.conf ./CHN.AAPL.yaml
sed -i "s|server=/|  - '+.|g" ./CHN.AAPL.yaml
sed -i "s|/114.114.114.114|'|g" ./CHN.AAPL.yaml
sed -i "1s|^|payload:\n|" ./CHN.AAPL.yaml
rm ./apple.china.conf
curl "https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/google.china.conf" -o "./google.china.conf"
sed -i "/^#/d" "./google.china.conf"
sed -i "s/[[:space:]]//g" "./google.china.conf"
cp ./google.china.conf ./CHN.GOOG.txt
sed -i "s|server=/||g" ./CHN.GOOG.txt
sed -i "s|/114.114.114.114||g" ./CHN.GOOG.txt
cp ./google.china.conf ./CHN.GOOG.conf
sed -i "s|server=/|DOMAIN-SUFFIX,|g" ./CHN.GOOG.conf
sed -i "s|/114.114.114.114||g" ./CHN.GOOG.conf
cp ./google.china.conf ./CHN.GOOG.yaml
sed -i "s|server=/|  - '+.|g" ./CHN.GOOG.yaml
sed -i "s|/114.114.114.114|'|g" ./CHN.GOOG.yaml
sed -i "1s|^|payload:\n|" ./CHN.GOOG.yaml
rm ./google.china.conf
git init
git add .
updated=`date --rfc-3339 sec`
git commit -m "$updated"
git push -u origin master
