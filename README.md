# ufw-cloudflare
Automatically whitelist Cloudflare IPs with UFW and get an easier way to delete old rules. A simple bash script that will fetch Cloudflare's IPs (IPV4 & IPV6) and will add them automatically to UFW (Uncomplicated FireWall) thus allowing Cloudflare TCP traffic to ports 80 (http) and 443 (ssl/https).

## Usage
- Clone this repository
- Give execution permissions to `ufw-cf.sh`
- Execute the script with sudo/root

    chmod +x ufw-cf.sh
    sudo ./ufw-cf.sh

The script will download 2 temporal files (_cfip-v4.tmp_ and _cfips-v6.tmp_) into the `/tmp` folder, will add all of them to UFW.

## Delete rules
The script will also create a simple `.sh` to remove the rules added. By default it is created in `/tmp/ufw-remove-cloudflare.sh`. It is recommended to copy that script to a personal place since it will allow you to remove the UFW rules when you decide to update or stop using them. 

    cp /tmp/ufw-remove-cloudflare.sh ~/ufw-remove-cloudflare.sh
    chmod +x ufw-remove-cloudflare.sh
    sudo ./ufw-remove-cloudflare.sh
    
![Usage example](https://i.imgur.com/MOKlQ1K.gif)
