#!/bin/bash


user-name (){
  aws iam get-access-key-last-used --access-key-id $1 --output text --query 'UserName'
}

access-key-list (){
  aws iam list-access-keys --user-name $1 --output text | awk '{print $2}'
}

last-used (){
  aws iam get-access-key-last-used --access-key-id $1 --output text --query 'AccessKeyLastUsed.LastUsedDate'
}

user-list(){
  aws iam list-users --output text | awk '{print $6}'
}


all-access-key (){
  for user in `user-list`
  do
    access-key-list $user
  done
}

get-diff(){
  if [ $1 = "None" ]; then
    echo 9999
  else
    last_used=`date -d $1 +%s`
    date_now=`date +%s`
    echo $[($date_now - $last_used) / (60 * 60 * 24)]
  fi
}

print-last-used(){
  for key in `all-access-key`
  do
    username=`user-name $key`
    date=`last-used $key`
    diff=`get-diff $date`
    #echo -e "$username\t$key\t$date\t$diff"
    printf "%-20s  %-20s  %-20s  %-3d\n" $username $key $date $diff
  done
}

print-last-used | sort -nk3

