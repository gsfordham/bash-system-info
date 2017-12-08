#! /bin/bash

#INIT SCRIPT
while [ true ]; do
	#CLEAR DISPLAY
		clear
	#END CLEAR DISPLAY
	
	#DISPLAY TIME AND DATE
		date_time_raw=`date +%Y" "%m" "%d" "%H" "%M" "%S" "%b" "%Z" "%A" "%s`
			#[2001 01 01] [12 34 56] [Jan] [GMT] [Monday]
		time_now=`echo "${date_time_raw}"|awk '{print $4":"$5":"$6}'`
		time_now_tz=`echo "${date_time_raw}"|awk '{print $8}'`
		date_now=`echo "${date_time_raw}"|awk '{print $1"-"$7"-"$3}'`
		date_now_day=`echo "${date_time_raw}"|awk '{print $9}'`
		
		printf "\033[1;35m❄️❄️❄️Date and Time❄️❄️❄️\033[0m\n"
		printf "\033[1;37m"
		printf "Time❄️ %s %s\n" $time_now $time_now_tz
		printf "Date❄️ %s, %s\n" $date_now $date_now_day
		printf "\n"
		
		printf "\033[0m"
	#END DISPLAY TIME AND DATE
	
	#DISPLAY SYSTEM UPTIME
		IFS=" "
		date_time_list=( $date_time_raw )
		#up_since=`uptime -s|sed 's/[:-]/ /g'`
		up_since_raw=`uptime -s`
		up_since=`echo "${up_since_raw}"|sed 's/[-]/ /g'`
			#[2001 01 01] [12:34:56]
		up_time_raw=`date -d "${up_since_raw}" +"%s"`
		up_time_stamp=`echo "$((${date_time_list[9]} - ${up_time_raw}))"`
		up_time_days=`echo "$(((((${date_time_list[9]} - ${up_time_raw}) / 24) / 60) / 60))"`
		up_time=`date -u -d @${up_time_stamp} +"%H %M %S"`
		up_time_list=( $up_time )
		
		printf "\033[1;35m❄️❄️❄️Current Uptime❄️❄️❄️\033[0m\n"
		printf "\033[1;37m"
		printf "Uptime since last restart❄️\n %s d, %s:%s:%s\n" $up_time_days ${up_time_list[0]} ${up_time_list[1]} ${up_time_list[2]}
		printf " Total seconds: %s\n" $up_time_stamp
		printf "\n"
		
		printf "\033[0m"
	#END DISPLAY SYSTEM UPTIME
	
	#DISPLAY SYSTEM INFO
		sysinfo_os=`uname -s`
		sysinfo_arch=`uname -m`
		sysinfo_rel=`uname -r`
		sysinfo_host=`echo $HOSTNAME`
		
		printf "\033[1;35m❄️❄️❄️System Information❄️❄️❄️\033[0m\n"
		printf "\033[1;37m"
		printf "OS❄️ %s\n" $sysinfo_os 
		printf "Kernel❄️ %s\n" $sysinfo_rel
		printf "Architecture❄️ %s\n" $sysinfo_arch
		printf "Hostname❄️ %s\n" $sysinfo_host
		printf "\033[0m\n"
	#END DISPLAY SYSTEM INFO


	#DISPLAY MEMORY
		mem_raw=`free -m`
		mem_total=`echo "${mem_raw}"|awk 'NR==2{print $2}'`
		mem_used=`echo "${mem_raw}"|awk 'NR==2{print $3}'`
		mem_free=`echo "${mem_raw}"|awk 'NR==2{print $7}'`
		mem_free_perc=`echo "${mem_raw}"|awk 'NR==2{print ($7*100/$2)}'`
		
		printf "\033[1;35m❄️❄️❄️MEMORY INFO❄️❄️❄️"
		printf "\033[0m\n"
		
		if [ `echo "${mem_free_perc} < 20.0"|bc` -eq 1 ]; then
			printf "\033[0;31m!!MEMORY CRITICAL!!\n%s MB/%s MB (%.2f%%)" $mem_free $mem_total $mem_free_perc
		elif [ `echo "${mem_free_perc} < 25.0"|bc` -eq 1 ]; then
			printf "\033[1;31m!MEMORY LOW!\n%s MB/%s MB (%.2f%%)" $mem_free $mem_total $mem_free_perc
		elif [ `echo "${mem_free_perc} < 30.0"|bc` -eq 1 ]; then
			printf "\033[0;33mMEMORY LIMITED\n%s MB/%s MB (%.2f%%)" $mem_free $mem_total $mem_free_perc
		elif [ `echo "${mem_free_perc} < 40.0"|bc` -eq 1 ]; then
			printf "\033[1;33mMEMORY OK\n%s MB/%s MB (%.2f%%)" $mem_free $mem_total $mem_free_perc
		else
			printf "\033[1;32mMEMORY GOOD\n%s MB/%s MB(%.2f%%)" $mem_free $mem_total $mem_free_perc
		fi
		printf "\n\033[0m\n"
	#END DISPLAY MEMORY
	
	#CURRENT PROCESSES
		curr_proc=`ps ax|wc -l`
		printf "\033[1;35m❄️❄️❄️Processes❄️❄️❄️\033[0m\n"
		printf "\033[1;37m"
		printf "Count❄️ %d\n" $curr_proc
		printf "\033[0m"
	#END CURRENT PROCESSES
	printf "\033[0m"
	sleep 1
done
#END SCRIPT
