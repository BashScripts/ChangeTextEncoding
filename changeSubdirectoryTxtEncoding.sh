#!/bin/bash


if [ "$1" = "--help" ]; then
	echo "Script converts txt files in subdirectory folders from cp1250 to utf-8. Put this script in folder which contains subfolders with txt files inside."
	exit 0
fi;

if [ "$1" = "" ]; then
	echo "Initializing script..."
	COUNTER=0
	
	array=()
	while IFS=  read -r -d $'\0'; do
	    array+=("$REPLY")
	done < <(find ./*/ -name '*.txt' -print0)



	
	for Tx in "${array[@]}";do
		echo "Checking if txt exists..."

		rr=`file -bi "$Tx"`;
		if [ "$rr" = "text/plain; charset=unknown-8bit" ]; then
			echo "Starting conversion..."
			iconv -f cp1250 -t utf8 "$Tx" > "$Tx.utf8"
			mv "$Tx.utf8" "$Tx"	
			echo "$Tx"	
		    COUNTER=$((COUNTER+1))
		fi
	done

	if [ $COUNTER -ne 0 ];then
		echo "Successfully converted: $COUNTER txt file/s"
	else
		echo "Script hasn't converted any file"
	fi

fi;
exit 0
	
