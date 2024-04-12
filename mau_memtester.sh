#!/bin/bash

change_date() {

	while :
	do
	
	declare -A timezone
	
	timezone[1]=America/Los_Angeles
	timezone[2]=Europe/London
	timezone[3]=Asia/Taipei
	timezone[4]=break
	
		while :
		do
		
			echo "========================================"
			echo "Time Zone list:"
			echo "1. America/Los_Angeles (UTC-8)"
			echo "2. Europe/London (UTC+0)"
			echo "3. Asia/Taipei (UTC+8)"
			echo "4. Return to main menu"
			echo "========================================"
			
			read -p "Enter Time Zone: (1-4) " tz_select
			
			echo "========================================"
			
			if [[ $tz_select == "4" ]]; then
				
				tz_input=${timezone[$tz_select]}
				
				$tz_input
				
			elif [[ ${timezone[$tz_select]} ]]; then
				
				tz_input=${timezone[$tz_select]}
				
				echo "========================================"
				echo "Time Zone $tz_input is selected."
				echo "========================================"
					
				export TZ=$tz_input
					
				break
					
			else
				
				echo "========================================"
				echo "Invalid input. Please enter number 1-4."
				echo "========================================"
					
			fi		
		done
		
		if [[ $tz_input == "break" ]]; then
		
			break
			
		else
		
			echo "========================================"
			read -p "Enter Year: (ex: 2024) " year
			read -p "Enter Month & Day: (ex: 0530) " monthday
			read -p "Enter Hour & Minute: (ex: 2245) " hourminute
			echo "========================================"
			
			mddash=$(echo $monthday | sed 's/\(..\)/\1-/')
			hmdash=$(echo $hourminute | sed 's/\(..\)/\1:/')
			
			echo "========================================"
			echo "Change date/time successfully!"
			echo "Current system time is:"
			
			date -s "$year-$mddash $hmdash:00"
			echo "========================================"
			
			break
			
		fi
	done
}


mem_default() {
	
	export density=10M
	export literation=2
	export now=$(date +"%Y%m%d%H%M")
	export memlog=memlog_${density}-${literation}_$now.txt
	
	echo "========================================"
	echo "memtester pending command:"
	echo "memtester $density $literation"
	echo "========================================"
	
	while :
	do
	
		echo "========================================"
		read -p "Are you ready to execute? (y/n) " execute
		echo "========================================"
	

		if [[ $execute == "y" ]]; then
	
			echo "========================================"
			echo "Executing memtester..."
			echo "========================================"
		
			memtester $density $literation | tee >( ts '[%Y-%m-%d %H:%M:%S]' > $memlog )
		
			echo "========================================"
			echo "Test complete!"
			echo "memtester log has been saved in:"
			echo "========================================"
			echo "$memlog"
			echo "========================================"
		
			exit
		
		elif [[ $execute == "n" ]]; then
	
			break
		
		else
	
			echo "Invalid input. Please enter y or n."
		
		fi
	done
}


mem_customize() {
	
	echo "========================================"
	echo "Setting up memtester parameters..."
	echo "========================================"
	read -p "Enter test density: (ex 10M) " density
	read -p "Enter test literation: (ex 2) " literation
	export density
	export literation
	export now=$(date +"%Y%m%d%H%M")
	export memlog=memlog_${density}-${literation}_$now.txt
	
	echo "========================================"
	echo "memtester pending command:"
	echo "memtester $density $literation"
	echo "========================================"
	
	while :
	do
	
		echo "========================================"
		read -p "Are you ready to execute? (y/n) " execute
		echo "========================================"
	

		if [[ $execute == "y" ]]; then
	
			echo "========================================"
			echo "Executing memtester..."
			echo "========================================"
		
			memtester $density $literation | tee >( ts '[%Y-%m-%d %H:%M:%S]' > $memlog )
		
			echo "========================================"
			echo "Test complete!"
			echo "memtester log has been saved in:"
			echo "========================================"
			echo "$memlog"
			echo "========================================"
		
			exit
		
		elif [[ $execute == "n" ]]; then
	
			break
		
		else
	
			echo "Invalid input. Please enter y or n."
		
		fi
	done
}


#main

declare -A mem_script

mem_script[1]=change_date
mem_script[2]=mem_default
mem_script[3]=mem_customize
mem_script[4]=exit

while :
do

	echo "========================================"
	echo "This program is written by Maurice."
	echo "========================================"
	echo "Script list:"
	echo "1. Change date/time"
	echo "2. memtester with default parameters"
	echo "3. memtester with customized parameters"
	echo "4. Exit"
	echo "========================================"
	
	read -p "Enter script number: (1-4) " script_select
	
	echo "========================================"
	
	if [[ ${mem_script[$script_select]} ]]; then
	
		export script=${mem_script[$script_select]}
		
		$script
		
	else
	
		echo "========================================"
		echo "Invalid input. Please enter 1-4."
		echo "========================================"
		
	fi
done
	

