#!/bin/bash
PS3="op>"


select choice in "Create New Table" "Delete Table" "Display Content Of Table" "Insert Into Table " "Delete Record From Table" "Update Certain Record" "List All tables of DataBase" "Select Table" "Exit"
do
        case $REPLY in
                1) echo "Enter the table name: "
                       read table
		       while [ -f ~/database/$1/$table ]; do # if file name exist it will take another name from user
			       echo "$table Exists Please Enter Another Table Name: "
			       read table
		       done
		        echo "Table $table doesn't Exit"    #If the table doesn't exist it will create it
                        echo "Table $table will be Created"
			touch ~/database/$1/$table
                        
				ar=("First" "Second" "Third" "Fourth" "Fifith" "Sixth" "Seventh" "Eighth")
				answer=y
				arr=()
				
				typeset -i i=0

				while [[ "$answer" == y ]]
				do	
					echo "Enter the ${ar[i]} Colomun Header: "
					read col
					((i++))
					echo "Specify the Data Type for the Column(int or str): "
					read datatype

				    	while [[ "$datatype" != "int" && "$datatype" != "str" ]]
				    	do
				    		echo "Invalid Data Type"
				    		echo "Please enter Data Type again(int or str): "
				    		read datatype
   				    	done

					arr[i]="$col-$datatype"
					echo "Do you want to add another Column?(y/n)"
					read answer

				done
                      
			
			echo "${arr[@]}">> ~/database/$1/$table
			echo "Columns=${#arr[@]}">> ~/database/$1/$table
			

			sed -i 's/ /:/g' /home/ahmed/database/$1/$table
			;;

		2) echo "enter the table name"
                       read table
			until [ -f ~/database/$dbname/$table ]
		 	do
				echo "table doesnot exist re-enter the table you want to delete:"
				read table
			done			
                        rm ~/database/$1/$table
			;;
		3) echo "enter the table name"
                       read table
                       until [ -f ~/database/$dbname/$table ]   
 		       do
                                 echo "table doesnot exist re-enter the table you want to display:"
                                 read table
                      done   
		       cat ~/database/$1/$table
		       ;;
	        4)echo "Enter the table's name you want to insert into: "       #working till now
			read table

			until [ -f ~/database/$1/$table ]  # it onlt gets out when the entered table exist
			do
				echo "Table doesn't Exist"
				echo "Enter Table name, or Create a new Table"
				read table
			done	 
			
			echo "$table Exists"
			answer=y
			while [ "$answer" == y ]				#Entering a new Record
			do
				s=$(sed -n '2p' ~/database/$1/$table | cut -f 2 -d "=")         #to get number of columns
				typeset -i i=0
				typeset -i j=1
				ar=("First" "Second" "Third" "Fourth" "Fifith" "Sixth" "Seventh" "Eighth")
				arr=()
			
				while (($j <= $s))               #Start entering  the fields of a record
				do
					t=$(sed -n '1p' ~/database/$1/$table | cut -f $j -d ":" | cut -f 1 -d"-")     #get the field name
					data=$(sed -n '1p' ~/database/$1/$table | cut -f $j -d ":" | cut -f 2 -d"-")  #get the field datatype
                        		echo "Enter the ${ar[i]} field "$t": "   
					read input
					if (( $j == "1" ))	#primary key check
					then
						key=$(cut -f 1 -d":" ~/database/$1/$table | grep -w ^$input)

						#echo "$key"
						while [[ $key ]] 
						do
							echo "This Primary Key already Exist"
							echo "Enter another Value for PK: "
							read input
							key=$(cut -f 1 -d":" ~/database/$1/$table | grep -w ^$input)
						done	
					fi
							
					if [[ $data == "int" ]]          # if it's Integer, then do integer check
					then                       
						while true
						do
							if [[ $input =~ ^[0-9]+$ ]] 
							then
								arr[i]="$input"
                                          			break
                                   			else
                                        			echo "Invalid Input please Enter a Valid Integer Value for ID: "
								read input
                                			fi
						done
					else    			 #means it's a string, so do string check
						while true
			       			do
                                			if [[ $input =~ ^[a-zA-Z]+$ ]] 
							then
								arr[i]="$input"
                                        			break
                                 			else
                                       				echo "Invalid Input pleaese Enter a Valid String Value: "
				       				read input
 
                                			fi
                        			done

					fi

				((j++))
				((i++))
				done 

				echo "${arr[@]}" >> ~/database/$1/$table	#One record is entered
				sed -i 's/ /:/g' /home/ahmed/database/$1/$table

				echo "Do you want to Insert another Record?(y/n)"
				read answer
			done
			sed -i 's/: /:/g' ~/database/$1/$table   #improve the array input
		       ;;
	        5)echo "Enter the name of table you want to delete from: "
			read table
			 until [ -f ~/database/$1/$table ]
                        do
                                echo "Record does't Exist, Re-Enter the Table you want to delete from:"
                                read table
                        done

		  echo "Enter Record Primary Key: "
		 	 read pk
			 pkey=$(cut -f 1 -d: ~/database/$1/$table | grep -w ^$pk)
			 until [[ $pkey ]] 
                      	 do
                    		  echo "This Primary Key doesn't Exist"
    	                          echo "Enter another Value for PK: "
                                  read pk
                                  pkey=$(cut -f 1 -d":" ~/database/$1/$table | grep -w ^$pk)
                         done
			sed -i  "/^$pk/d"   ~/database/$1/$table
			echo "Record was Deleted Successfully"
			;;
		6)echo "Enter the table name you want to update: "
 	  		 read table
			if [ -f ~/database/$1/$table ]     #Check Table Existence
			then
        			echo "$table Exists"
        			echo "Enter the primary key value to identify the record to update: "
       			 	read pk
        			# Check if the record with the specified primary key exists
        			if grep -q "^$pk:" ~/database/$1/$table 
				then
            				echo "Record with primary key $pk found."
	    				grep "^$pk:" ~/database/$1/$table  # Display the current record
          		  		echo "Enter the number of field to modify: "
					read num
					old_val=$(grep "^$pk:" ~/database/$1/$table | cut -f $num -d ":")                  #the old value

					t=$(sed -n '1p' ~/database/$1/$table | cut -f $num -d ":" | cut -f 1 -d"-")     #get the field name
                                        data=$(sed -n '1p' ~/database/$1/$table | cut -f $num -d ":" | cut -f 2 -d"-")  #get the field datatype
					
					echo "Enter the new value for "$t": "    #the new value
                                        read input
                                        if (( $num == "1" ))      #primary key check
                                        then
                                                key=$(cut -f 1 -d":" ~/database/$1/$table | grep -w ^$input)

                                                while [[ $key ]]
                                                do
                                                        echo "This Primary Key already Exist"
                                                        echo "Enter another Value for PK: "
                                                        read input
                                                        key=$(cut -f 1 -d":" ~/database/$1/$table | grep -w ^$input)
                                                done
                                        fi

                                        if [[ $data == "int" ]]          # if it's Integer, then do integer check
                                        then
                                                while true
                                                do
                                                        if [[ $input =~ ^[0-9]+$ ]]
                                                        then
                                                                arr[i]="$input:"
                                                                break
                                                        else
                                                                echo "Invalid Input please Enter a Valid Integer Value for ID: "
                                                                read input
                                                        fi
                                                done
                                        else                             #means it's a string, so do string check
                                                while true
                                                do
                                                        if [[ $input =~ ^[a-zA-Z]+$ ]]
                                                        then
                                                                arr[i]="$input: "
                                                                break
                                                        else
                                                                echo "Invalid Input pleaese Enter a Valid String Value: "
                                                                read input

                                                        fi
                                                done
					fi
					sed -i "s/$old_val/$input/g" ~/database/$1/$table   # Use sed to update the record with the new values
					echo "Record updated successfully."
        			else
            				echo "Record with primary key $pk not found"
        			fi
    			else
        			echo "Table $table does not exist re-enter table name:"
    			fi	
    ;;
	        7) ls -l  ~/database/$1

			;;
		8) select choice in "Select By Row" "Select By Column" "Select By Cell" "Exit"
		do
        	case $REPLY in
                1)
			echo "Enter the table you want to select from"
			read table
			until [ -f ~/database/$1/$table ]  #Check on Table Existence
                         do
                                 echo "Table $table doesn't Exist Re-Enter the Table you want to select:"
                                 read table
                         done

			 echo "Enter the primary key to search:"
                         read value
                         result=$(grep "^$value" ~/database/$1/$table)
			 until [ "$result" ] #check on the primary key of the row
			 do
				echo "Record does not exist"
				echo "Re-Enter the primary key to search:"
                                read value
                                result=$(grep "^$value" ~/database/$1/$table)
			done
			
			echo "$result"
 
			;;
		2) 	
			echo "Enter the table you want to select from"
                        read table
			until [ -f ~/database/$dbname/$table ]   #check on table existence
                         do
                                 echo "Table $table doesn't Exist Re-Enter the Table you want to select:"
                                 read table
                         done
			

                        echo "Enter the No. of field to display:"
                        read num
                        result=$(sed '2d' ~/database/$1/$table |cut -d: -f"$num" )

                        until [ "$result" ]    #Check on the number of field
			do
				echo "Field not found re-enter the valid value of the field"
				read num
				result=$(sed '2d' ~/database/$1/$table |cut -d: -f"$num" )
				done

				echo "result found"
				echo "$result"
                	
                        	
			;;		
		3)	
			echo "Enter the table you want to select from"
                         read table
			 until [ -f ~/database/$1/$table ]    #check on table existence
                         do
				echo "Table doesn't Exist, Re-enter the table you want to select:"
                                 read table
                         done

			echo "Enter the row to search:"
			read value
                        result_row=$(grep -n "^$value" ~/database/$1/$table | cut -f 1 -d ":") 
                        until [ "$result_row" ]  #Check on the primary key of the row
			do
                        	echo "Record not found re-enter the value "
				read value
                                result_row=$(grep -n "^$value" ~/database/$1/$table | cut -f 1 -d ":")
				done

			echo "record found"
			                             
			echo "enter the No. of field to display:"
                        read num
                        result_col=$(sed '2d' ~/database/$1/$table | cut -d: -f"$num")
                        until [ "$result_col" ]   #check on the field
			do	
                        	echo "field not found" 
				echo "re-enter number of field"
				read num
	 			result_col=$(sed '2d' ~/database/$1/$table |cut -d: -f"$num")
			done
			
			echo "field found"
			res=$(cut -f"$num" -d ":" ~/database/$1/$table | sed -n "$result_row p")

			echo "$res"

			;;
		4)	break
			./~/opendbtest.sh
			;;
 		esac
	done
			;;
       		9)     
			. ~/Mainmenutest.sh 
		        exit
		  
	                ;;
	
		*) echo "Table doesn't Exist" ;;
	esac
done
