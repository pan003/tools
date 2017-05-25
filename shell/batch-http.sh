#!/usr/bin/env bash
#批量发起重新下单请求
#导出浏览器cookie工具https://chrome.google.com/webstore/detail/cookiestxt/njabckikapfpffapmjgojcnbfjonfjfg
#orderlist.txt文件是要重发的订单ID
for line in `cat /Users/pan/Desktop/orderlist.txt`
do
    curl --request GET \
      --cookie /Users/pan/Desktop/cookies.txt \
      --url http://****.jd.com/****againRecharge/$line \
      --header 'cache-control: no-cache'
done