#!/bin/sh

cd /tmp
wget https://www.cloudflare.com/ips-v4 -O cfips-v4.tmp
wget https://www.cloudflare.com/ips-v6 -O cfips-v6.tmp

touch ufw-remove-cloudflare.sh
rm ufw-remove-cloudflare.sh

for cfip in `cat cfips-v4.tmp`; do
        ufw allow from $cfip to any port 80 proto tcp comment "cloudflare"
        ufw allow from $cfip to any port 443 proto tcp comment "cloudflare"
        echo "ufw delete allow from $cfip to any port 80 proto tcp" >> ufw-remove-cloudflare.sh
        echo "ufw delete allow from $cfip to any port 443 proto tcp" >> ufw-remove-cloudflare.sh
done

for cfip in `cat cfips-v6.tmp`; do
        ufw allow from $cfip to any port 80 proto tcp comment "cloudflare"
        ufw allow from $cfip to any port 443 proto tcp comment "cloudflare"
        echo "ufw delete allow from $cfip to any port 80 proto tcp" >> ufw-remove-cloudflare.sh
        echo "ufw delete allow from $cfip to any port 443 proto tcp" >> ufw-remove-cloudflare.sh
done

rm cfips-v4.tmp
rm cfips-v6.tmp

echo 'Done.'
echo 'A .sh file has been generated in /tmp/ufw-remove-cloudflare.sh to remove the rules that were added.'

