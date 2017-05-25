#!/usr/bin/env bash
#批量发起重新下单请求
for line in `cat /Users/pan/Desktop/orderlist.txt`
do
    curl --request GET \
      --cookie /Users/pan/Desktop/cookies.txt \
      --url http://man.jyk.jd.com/order/againRecharge/$line \
      --header 'cache-control: no-cache'
done