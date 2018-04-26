#!/bin/bash
#we need a treshold, and I take it from a text file named threshold.txt
threshold=$(< threshold.txt)

#we need to know how much disk in usage now. I just take the total disk usage.

current_usage=$(df -h --total | grep 'total' | awk {'print $5'})

#check if this is the first time the script is working.
#I mean the first month.

if [ -s previous.txt ]
   
then 
	#we need previous usage of the disk. We saved it to previous.txt file
	
previous_usage=$(cat previous.txt | grep 'total' | awk {'print $5'})

	#we make calculations if there is an error it will show us the error.
	
check=$(((${previous_usage%?}*${threshold%?}/100)+${previous_usage%?}))
	
if [ ${current_usage%?} -ge "$check" ]
  	   
then echo "There is problem !!! "
		
echo "In order to threshold, the current disk usage is bigger than previous month's."
		
echo "Current disk usage: ${current_usage}"
		
echo "Previous month's disk usage: ${previous_usage}"

elif [ ${current_usage%?} -lt "$check" ]
  	     
then echo "There is no problem. Everything is alright."
		  
echo "Current disk usage: ${current_usage}"
		  
echo "Previous month's disk usage: ${previous_usage}"
	
fi

fi

#THERE IS NO NEED ELSE STATEMENT TO HERE,
#BECAUSE IN EVERY CASE, THE CURRENT KNOWLEDGE WILL BE PREVIOUS KNOWLEDGE
#ON NEXT MONTH !!!

#finally, we must save the current disk usage to previous.txt,

#because, current knowledge will be previous knowledge on next month !
df -h --total > previous.txt


