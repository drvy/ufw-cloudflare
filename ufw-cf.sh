#!/bin/sh

cfufw_deleted=0
cfufw_created=0
cfufw_ignored=0
cfufw_nonew=0
cfufw_purge=0
cfufw_showhelp=0

cf_ufw_add () {
    if [ ! -z $1 ]; then
        rule=$(LC_ALL=C && ufw allow from $1 to any port 80,443 proto tcp comment "cloudflare")

        if [ "$rule" = 'Rule added' ] || [ "$rule" = 'Rule added (v6)' ]; then
            echo -n "\e[32m+\e[39m"
            cfufw_created=$((cfufw_created+1))
            return
        fi
    fi

    echo -n "\e[90m.\e[39m"
    cfufw_ignored=$((cfufw_ignored+1))
}

cf_ufw_del () {
    if [ ! -z $1 ]; then
        rule=$(LC_ALL=C && ufw delete allow from $1 to any port 80,443 proto tcp)

        if [ "$rule" = 'Rule deleted' ] || [ "$rule" = 'Rule deleted (v6)' ]; then
            echo -n "\e[31m-\e[39m"
            cfufw_deleted=$((cfufw_deleted+1))
            return
        fi
    fi

    echo -n "\e[90m.\e[39m"
    cfufw_ignored=$((cfufw_ignored+1))
}

cf_ufw_purge () {
    total="$(sudo ufw status numbered | awk '/\# cloudflare$/ {++count} END {print count}')"
    i=1

    if [ -z $total ]; then
        cfufw_deleted=0
        return
    fi

    while [ $i -le $total ]; do
        cfip=$(sudo ufw status numbered | awk '/\# cloudflare$/{print $6; exit}')
        cf_ufw_del $cfip
        i=$((i+1))
    done
}

touch /tmp/cloudflare-ips.tmp
wget https://www.cloudflare.com/ips-v4 -a /tmp/cloudflare-ips.tmp
wget https://www.cloudflare.com/ips-v6 -a /tmp/cloudflare-ips.tmp

for cfip in `cat cloudflare-ips.tmp`; do
        cf_ufw_add "$cfip"
done

rm /tmp/cloudflare-ips.tmp

echo 'Done.'

