#!/bin/sh

touch /tmp/cloudflare-ips.tmp
wget https://www.cloudflare.com/ips-v4 -a /tmp/cloudflare-ips.tmp
wget https://www.cloudflare.com/ips-v6 -a /tmp/cloudflare-ips.tmp

for cfip in `cat cloudflare-ips.tmp`; do
        ufw allow from $cfip to any port 80 proto tcp comment "cloudflare"
        ufw allow from $cfip to any port 443 proto tcp comment "cloudflare"
        #echo "ufw delete allow from $cfip to any port 80 proto tcp" >> ufw-remove-cloudflare.sh
        #echo "ufw delete allow from $cfip to any port 443 proto tcp" >> ufw-remove-cloudflare.sh
done

rm /tmp/cloudflare-ips.tmp

echo 'Done.'

