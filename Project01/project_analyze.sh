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

#!/bin/bash

MergeLog ()
{
         rm -f "merge.log"
         log=`git log --oneline
         while read -r line; do
                 if [[ ! -z `echo $line | grep "Merge"` ]]; then
                         hash=`echo $line | cut -d " " -f 1`
                         echo $hash >> merge.log
                         echo "Find it: $hash"
                 fi
         done <<< $log
         echo "Finished"
         echo "Go check "merge.log" in the same dir"
}


#!/bin/bash

if [ $# -eq 1 ]
then

    if [$1 -eq 1 ]
    then
         grep -r --exclude="todo.log" "#TODO" > ~/CS1XA3/Project01/todo.log
    elif [ $1 -eq 2 ]
    then
         echo "Compile Error log"
         list1=$(find ~/CS1XA3 -name *.hs
         list2=$(find ~/CS1XA3 -name *.py
         for hsfi in $list1;do
            cmp=$(ghci $hsfi)
            if [ "$cmp" == *syntax errors* ]
            then
                echo $hsfi >> ~/CS1XA3/Project01/compile_fail.log
            fi
         done
         for pyfi in $list2;do
            cmp=$(python $pyfi)
            if [ "$cmp"== *syntax errors* ]
            then
                echo $pyfi >> ~/CS1XA3/Project01/compile_fail.log
            fi
         done
