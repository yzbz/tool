#!/bin/bash
# 将2019-09-23全天的访问日志放到a.txt文本
# cat access.log |sed -rn '/2019-09-23T00:00:00/,/2019-09-24T00:00:00/p' > a.txt
# 统计a.txt里面有多少个ip访问
# 文件名
filename=$1
if [ -z $filename ] ; then
    echo 'please enter filename'
    exit 0
fi
# ip所在的列
ip_column_num=$2
if [ -z $ip_column_num ] ; then
    echo 'please enter ip_column_num'
    exit 0
fi

cat $filename |awk -v value=$ip_column_num '{print $(value)}'|sort|uniq  > ipnum.txt
#通过shell统计每个ip访问次数
echo>result.txt #清空原文件
for i in `cat ipnum.txt`
do
iptj=`cat $filename |grep $i |grep -v 400|wc -l`
date=$(date)
echo "ip地址"$i"在"$date"全天(24小时)累计成功请求"$iptj"次，平均每分钟>    请求次数为："$(($iptj/1440)) >> result.txt
done
