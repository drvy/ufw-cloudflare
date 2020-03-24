# ufw-cloudflare `v2`

    █▀▀ █▀▀   █░█ █▀▀ █░█░█
    █▄▄ █▀░   █▄█ █▀░ ▀▄▀▄▀

Automatically whitelist [Cloudflare](https://www.cloudflare.com/) IPs (subnets) within [UFW](https://wiki.ubuntu.com/UncomplicatedFirewall) and get an easier way to delete old rules. A _simple_ SH script that will fetch Cloudflare's IPs and subnets (IPV4 & IPV6) and will create rules for them automatically in UFW (Uncomplicated Firewall) thus allowing Cloudflare TCP traffic to port 80 (http) and 443 (ssl/https).

## Usage
- Clone this repository (`https://github.com/drvy/ufw-cloudflare`)
- Give execution permissions to `ufw-cf.sh`
- Execute the script with sudo/root

        chmod +x ufw-cf.sh
        sudo ./ufw-cf.sh

The script will download a temporal file (`cloudflare-ips.txt`) into the `/tmp` folder and will parse it to add the IPs to UFW.

The IPs are provided by Cloudflare: [IPv4](https://www.cloudflare.com/ips-v4), [IPv6](https://www.cloudflare.com/ips-v6).


## Purge/delete rules
The script has the ability to purge all the previously created rules in UFW. Keep in mind it deletes only those rules commented as "_cloudflare_".

    sudo ./ufw-cf.sh --purge

This will delete existing Cloudflare rules, fetch the IPs and create new rules. You can also delete/purge the rules without creating new ones.

    sudo ./ufw-cf.sh --purge --no-new


## Example

![Usage example](https://i.imgur.com/cmcCyOB.gif)

## Old version
This is a completely rewritten script. It is still fairly simple but you may not have the desire or time to review it thus, if you want something functional and very simple, go check out the [old_v1 branch](https://github.com/drvy/ufw-cloudflare/tree/old_v1) for the previous version.
