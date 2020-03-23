#!/bin/sh

touch /tmp/cloudflare-ips.tmp
wget https://www.cloudflare.com/ips-v4 -a /tmp/cloudflare-ips.tmp
wget https://www.cloudflare.com/ips-v6 -a /tmp/cloudflare-ips.tmp

touch /tmp/ufw-remove-cloudflare.sh
rm /tmp/ufw-remove-cloudflare.sh

for cfip in `cat cloudflare-ips.tmp`; do
        ufw allow from $cfip to any port 80 proto tcp comment "cloudflare"
        ufw allow from $cfip to any port 443 proto tcp comment "cloudflare"
        echo "ufw delete allow from $cfip to any port 80 proto tcp" >> ufw-remove-cloudflare.sh
        echo "ufw delete allow from $cfip to any port 443 proto tcp" >> ufw-remove-cloudflare.sh
done

rm /tmp/cloudflare-ips.tmp

echo 'Done.'
echo 'A .sh file has been generated in /tmp/ufw-remove-cloudflare.sh to remove the rules that were added.'

