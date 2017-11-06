#!/bin/bash
#Author:  Ravikuamr Wagh
#About Script : Script checks for ssh key in remote machine, If key not found for providd user it will copy to it.
#Input: 1. File contains list of servers to check for key. 2. Common password for all of the specifed servers 3. Name of user to check key.
#Example: bash check_ssh_key.sh <servers_file> <common-password> <User-Name>
#Server File contents ae as:
#######
#server1
#server2
#######

while read line
do
  if [[ $(sshpass -p $2 ssh -n root@$line grep $3 .ssh/authorized_keys | wc -l) -gt 0 ]]
 	then
	echo "$line: found $2 key"
	else
	echo "$line:  key not found for $2... Copying to $line"
	sshpass -p $2 ssh-copy-id $line
  fi
done < $1
