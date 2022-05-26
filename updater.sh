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
curl -O "https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/accelerated-domains.china.conf" -O "https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/apple.china.conf" -O "https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/google.china.conf"
sed -i "/^#/d" ./*.conf && sed -i "s/[[:space:]]//g" ./*.conf
cp ./accelerated-domains.china.conf ./CHN.txt && cp ./apple.china.conf ./CHN.AAPL.txt && cp ./google.china.conf ./CHN.GOOG.txt
cat ./apple.china.conf ./google.china.conf ./accelerated-domains.china.conf > ./CHN.ALL.txt
sed -i "s|server=/||g" ./CHN*.txt && sed -i "s|/114.114.114.114||g" ./CHN*.txt
cp ./accelerated-domains.china.conf ./CHN.conf && cp ./apple.china.conf ./CHN.AAPL.conf && cp ./google.china.conf ./CHN.GOOG.conf
cat ./apple.china.conf ./google.china.conf ./accelerated-domains.china.conf > ./CHN.ALL.conf
sed -i "s|server=/|DOMAIN-SUFFIX,|g" ./CHN*.conf && sed -i "s|/114.114.114.114||g" ./CHN*.conf
cp ./accelerated-domains.china.conf ./CHN.yaml && cp ./apple.china.conf ./CHN.AAPL.yaml && cp ./google.china.conf ./CHN.GOOG.yaml
cat ./apple.china.conf ./google.china.conf ./accelerated-domains.china.conf > ./CHN.ALL.yaml
sed -i "s|server=/|  - '+.|g" ./CHN*.yaml && sed -i "s|/114.114.114.114|'|g" ./CHN*.yaml && sed -i "1s|^|payload:\n|" ./CHN*.yaml
cp ./accelerated-domains.china.conf ./CHN.agh && cp ./apple.china.conf ./CHN.AAPL.agh && cp ./google.china.conf ./CHN.GOOG.agh
cat ./apple.china.conf ./google.china.conf ./accelerated-domains.china.conf > ./CHN.ALL.agh
sed -i "s|server=|[|g" ./CHN*.agh && sed -i "s|114.114.114.114|]tls://223.5.5.5|g" ./CHN*.agh
cp ./accelerated-domains.china.conf ./CHN.list && cp ./apple.china.conf ./CHN.AAPL.list && cp ./google.china.conf ./CHN.GOOG.list
cat ./apple.china.conf ./google.china.conf ./accelerated-domains.china.conf > ./CHN.ALL.list
sed -i "s|server=/|+.|g" ./CHN*.list && sed -i "s|/114.114.114.114| = server:system|g" ./CHN*.list
rm ./accelerated-domains.china.conf ./apple.china.conf ./google.china.conf
git init
git add .
updated=`date --rfc-3339 sec`
git commit -m "$updated"
git push -u origin master
