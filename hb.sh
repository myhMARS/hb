#!/bin/bash
if [ "$1" == "" ]
then
	echo "合并视频为videos.m4s audios.m4s按照example1输入指令"
	echo "example1:./hb 视频路径 输出文件名(默认后缀avi)"
	echo "合并视频为*.blv格式的多个视频按照example2输入"
	echo "example2:./hb 视频路径 输出文件名 1 blv文件个数减一后的个数"
	echo "注意！如果只有一个blv文件自己改后缀就可以了"
else
	if [ "$2" == "" ]
	then
		echo "未输入输出文件名"
	else
		if [ "$3" == "" ]
		then
			cd $1
			ffmpeg -i video.m4s -i audio.m4s -vcodec copy -acodec copy $2.avi
		else
			if [ "$3" == "1" ]
			then
				if [ "$4" == "" ]
				then
					echo "未指定存在blv个数"
				else
					cd $1
					touch list.txt
					for x in `seq 0 $4`;do
						echo file $x.blv >> list.txt
					done
					ffmpeg -f concat -safe 0 -i list.txt -c copy $2.mkv
					rm list.txt
				fi
			else
				echo "第三项参数输入错误，如需合并多个视频文件则第三项参数为1"
				echo "example:./hb 视屏路径 输出文件名 1"
				echo "如合并视频为 videos.m4s audio.m4s 则无需第三项参数"
			fi
		fi
	fi

fi
echo "此脚本由myhMARS编写用于bilibili视频合成"

