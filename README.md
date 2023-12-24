# DBMS With Bash Script
>In this repositry the user can make his own Database with many tables as he wants.

### first you will run the Mainmenutest.sh file.

![Mainmenutest sh-Menu](https://github.com/KarimMohamedDesouki/OS44/assets/153070580/c062fb9d-611d-40ab-9611-161ce46c8d58)

this menu contains `Create Database` `Open Database` `List All Databases` `Delete Database` `Exit`.            
1. Create Database -- create a new database.
1. Open Database -- will open a created database (will open the opendbtest.sh file in step 13).
1. List all Database -- will list all the databases.
1. Delete the Database -- will delete a specific database.
1. Exit -- will get out of the Mainmenutest.sh file. (the prompt of the Mainmenutest.sh is MM>)


![Opendbtest sh-Menu](https://github.com/KarimMohamedDesouki/OS44/assets/153070580/0fa8be2f-c1f1-455c-bbf3-fc01aca0b6bc)

when you open a database it will call the file named opendbtest.sh where you will have menu `Create Table`  `Delete Table`  `Insert In Table`  `Update the Table`  `Delete Record from table`  `List All the Tables` `Select Table` `Exit`.
1. create table -- will ask the user to enter the name of the table you want to create then it will say how many columns you want to add and will ask about the datatype of every field (int,str).   
1. delete table -- will ask user to enter the name of the table you want to delete.  
1. content of table -- will ask the user about the table he wants to know the data in it.
1. insert in table -- will ask the user which table he wants to enter data into. then will insert data at the last and will ask the user to enter the data of every field.
1. update the table -- will take the place where the user want to update the table and substitute the old data with the new data.
1. delete record from table -- will take the primary key from the user and delete its row.    
1. list all tables -- will list all the table in this specific database.   
1. select from table -- will ask the user which table to select from and there will be 3 option you can select by row,column,cell.               
   - select by row -- will take the primary key from the user and print the record.
   - select by column -- will take the field number and print all the field.
   - select by cell -- will take the record from the user and take the column from the user and will print for him the cell chosen.
1. exit -- will get the user out of the opendbtest.sh and go back to the Mainmenutest.sh prompt changes in opendbtest.sh is OP>

here you will find the demo video link of the project: https://drive.google.com/file/d/1koRLpjqDisJ-ZbBQcxjXk5OKr1aGFsSJ/view?usp=sharing 
