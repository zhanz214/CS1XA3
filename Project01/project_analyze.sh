#!/bin/bash

cd ..
echo "type whatever the function you want please"
echo "check TODO to see the list of the function"
echo "check rmtemp to remove temporary"
echo "type exit to exit"
read -p "u've typed:" func
echo "processinggggg. Please wait. u've typed:" $func

while [ $func != "exit" ]
do
        if [ $func = "TODO" ] then
               cp /dev/null  ~/CS1XA3/Project01/todo.log
               if [ -e "todo.log" ]
               then 
                      rm todo.log
               fi

               chklst=$( git ls-files )
               for note in $chklst
               do
                     while IFS= read line
                     do
                         echo "$line #TODO" >> ~/CS1XA3/Project01/todo.log
                     done < $note
               done
        elif  [ $func = "rmtemp" ];then
        smfile=$(git ls-files . --exclude-standard --others)
        for files in $smfile
        do
             if [[ "$files" == *.tmp ]];then
                     echo "remove temporaty files"
                     rm $files
             fi
        done
        else
             echo "no existed command matches, please try again"
        fi
        read -p "Type another command:" func
        echo "processingggg. Please wait" $func
done
unset func
exit
