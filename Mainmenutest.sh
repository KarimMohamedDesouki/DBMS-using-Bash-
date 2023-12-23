#!/bin/bash
PS3="MM>"

select choice in "Create a New DataBase" "Open Specific DataBase" "List DataBase" "Delete DataBase" "Exit"
do 
	case $REPLY in
		1)echo "enter the database name"
		read dbname
		if [ -d ~/database/$dbname ]
		then
			echo "$dbname Exists"
		else
			echo "$dbname doesn't Exist, $dbname will be created"
			cd ~/database
                	mkdir ~/database/$dbname
		fi	
		;;


		2) echo "enter the database name"
                read dbname
		until [ -d ~/database/$dbname ]
		do
			echo "enter a valid database"
			read dbname
		done
		ls -l ~/database/$dbname
		export $dbname
                . ~/opendbtest.sh $dbname      
		
		;;


		3) ls -l ~/database            ;;


	        4) echo "WARNING:All Tables within the given Database will be Deleted"
		echo "Enter the database name"
                read dbname
                rm -r ~/database/$dbname 
	        echo "$dbname and it's Tables werer deleted"	;;

		5)  
		   exit
		   exit 
		   break    	;;
					

		*) echo "Wrong Choice, Please Select Again"      ;;
	esac
	done	
