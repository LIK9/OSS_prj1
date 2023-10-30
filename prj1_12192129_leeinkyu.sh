#! /bin/bash

item_file=$1
data_file=$2
user_file=$3

echo "User Name: Lee Inkyu"
echo "Student Number: 12192129"
echo "[ MENU ]"
echo "1. Get the data of the movie identified by a specific 'movie id' from 'u.item'"
echo "2. Get the data of action genre movies from 'u.item'"
echo "3. Get the average 'rating of the movie identified by specific 'movie id' from 'u.data'"
echo "4. Delete the 'IMDb URL' from 'u.item'"
echo "5. Get the data about users from 'u.user'"
echo "6. Modify the format of 'release data' in 'u.item'"
echo "7. Get the data of movies rated by a specific 'user id' from 'u.data'"
echo "8. Get the average 'rating' of movies rated by users with 'age' between 20 and 29 'occupation' as 'programmer'"
echo "9. Exit"

input=0


while [ $input -ne 9 ]
do
	read -p "Enter your choice [ 1-9 ] " input
	echo
	if [ $input  = 1 ]
	then
		read -p "Please enter 'movie id'(1~1682): " input_1
		cat $item_file | awk -v n="$input_1" 'NR==n {print $0}'
	
	else
		if [ $input = 2 ]
		then 
			read -p "Do you want to get the data of 'action' genre movies from 'u.item'? (y/n): " input_2
			if [ $input_2 = "y" ]
			then
				cat $item_file | awk -F\| '$7==1 {print NR, $2}' | head -n 10
			fi
		fi
		if [ $input = 3 ]
		then
			read -p "Please enter the 'movie id'(1~1682): " input_3
			cat $data_file | awk -v input=$input_3 '$2==input {sum+=$3; len++} END {printf("average rating of %d: %.5f\n", input, sum/len)}'
		fi
		if [ $input = 4 ]
		then
			read -p "Do you want to delete the 'IMDb URL' from 'u.item'?(y/n): " input_4
			if [ $input_4 = "y" ]
			then
				cat $item_file | sed -E 's/http:\/\/us.imdb.com\/M\/title-exact[^|]*//g' | head -n 10
			fi
		fi
		if [ $input = 5 ]
		then
			read -p "Do you want to get the data about users from 'u.user'?(y/n): " input_5
			if [ $input_5 = "y" ]
			then
				cat $user_file | sed -E -e 's/([0-9]+)\|([0-9]+)\|M\|([^|]*)\|.*/user \1 is \2 years old male \3/' -E -e 's/([0-9]+)\|([0-9]+)\|F\|([^|]*)\|.*/user \1 is \2 years old female \3/' | head -n 10
			fi
		fi
		if [ $input = 6 ]	
		then
			read -p "Do you want to Modify the format of 'release data' in 'u.item'?(y/n): " input_6
			if [ $input_6 = "y" ]
			then
				cat $item_file | sed -E -e 's/([0-9]+)-Jan-([0-9]+)\|/\201\1/' -E -e 's/([0-9]+)-Feb-([0-9]+)\|/\202\1/' -E -e 's/([0-9]+)-Mar-([0-9]+)\|/\203\1/' -E -e 's/([0-9]+)-Apr-([0-9]+)\|/\204\1/' -E -e 's/([0-9]+)-May-([0-9]+)\|/\205\1/' -E -e 's/([0-9]+)-Jun-([0-9]+)\|/\206\1/' -E -e 's/([0-9]+)-Jul-([0-9]+)\|/\207\1/' -E -e 's/([0-9]+)-Aug-([0-9]+)\|/\208\1/' -E -e 's/([0-9]+)-Sep-([0-9]+)\|/\209\1/' -E -e 's/([0-9]+)-Oct-([0-9]+)\|/\210\1/' -E -e 's/([0-9]+)-Nov-([0-9]+)\|/\211\1/' -E -e 's/([0-9]+)-Dec-([0-9]+)\|/\212\1/' | tail -n 10
			fi
		fi
		if [ $input = 7 ]
		then
		read -p "Please enter the 'user id'(1~943): " user_id
		echo
		movieID_array=$(cat $data_file | awk -v user_id=$user_id '$1 == user_id {print $2}' | sort -n)
		movieID_array=$(echo $movieID_array | sed 's/ /|/g')
		echo $movieID_array
		echo
		echo $movieID_array | tr '|' '\n' | head -n 10 | while read id
		do
			cat $item_file | awk -v id=$id -F \| '$1 == id {print $1"|"$2}'
		done
		echo
		fi
		if [ $input = 8 ]
		then
			read -p "Do you want to get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as 'programmer'?(y/n): " input_8
			if [ $input_8  = "y" ]
			then
				userID_array=$(cat $user_file | awk -F \| '$2>=20 && $2<=29 && $4=="programmer" {print $1}')
			pattern=$(echo $userID_array | sed 's/ /|/g')
			for movieID in $(seq 1 1655)
			do
				cat $data_file | awk -v pattern="^($pattern)$" -v movieID=$movieID '$2==movieID && $1 ~ pattern {sum+=$3; len++} END{if (len > 0) printf("%d %.5f\n", movieID, sum/len)}'
			done

			fi
		fi
		if [ $input = 9 ]
		then
			echo "Bye!"
		fi
	fi
		
done

