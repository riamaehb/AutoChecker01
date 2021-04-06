#!/bin/sh

strindex() { 
  x="${1%%$2*}"
  [[ "$x" = "$1" ]] && echo -1 || echo "${#x}"
}

touch assign01-scores.txt

noOfCases=78
testCase=('create' 'GIVEYOU!' 'GIVEYOU! hello' 'GIVEYOU! "hello world"' 'GIVEYOU! 1234.5' 'GIVEYOU! "hello" #this prints hello' 'GIVEYOU! ", world."' 'GIVEYOU! "12.5"' 'GIVEYOU! "リア"' 'GIVEYOU!       "yes       "' 'GIVEYOU! "NO!"           #"prints no"' 'giveyou! "hello world"' 'GIVEYOU!!' 'GIVEYOU!! hello' 'GIVEYOU!! "hello world"' 'GIVEYOU!! 1234.5' 'GIVEYOU!! "hello" #this prints hello' 'GIVEYOU!! ", world."' 'GIVEYOU!! "12.5"' 'GIVEYOU!! "リア"' 'GIVEYOU!!       "yes       "' 'GIVEYOU!! "NO!"           #"prints no"' 'giveyou!! "hello world"' 'PLUS 1 2 3' 'PLUS 1 2 a' 'PLUS 1 2' 'PLUS 12.5 2' 'PLUS 12.4 4.4' 'PLUS 12 2.2' 'PLUS 0 0' 'PLUS    1 2' 'PLUS x y' 'plus 12 m' 'MINUS 1 2 3' 'MINUS 1 2 a' 'MINUS 1 2' 'MINUS 12.5 2' 'MINUS 12.4 4.4' 'MINUS 12 2.2' 'MINUS 0 0' 'MINUS    1 2' 'MINUS x y' 'MINUS 12 m' 'minus 12 1' 'TIMES 1 2 3' 'TIMES 1 2 a' 'TIMES 1 2' 'TIMES 12.5 2' 'TIMES 12.4 4.4' 'TIMES 12 2.2' 'TIMES 0 0' 'TIMES    1 2' 'TIMES x y' 'TIMES 12 m' 'times 3 4' 'DIVBY 1 2 3' 'DIVBY 1 2 a' 'DIVBY 1 2' 'DIVBY 12.5 2' 'DIVBY 12.4 4.4' 'DIVBY 12 2.2' 'DIVBY 0 0' 'DIVBY    1 2' 'DIVBY x y' 'DIVBY 12 m' 'divby 5 6' 'MODU 1 2 3' 'MODU 1 2 a' 'MODU 1 2' 'MODU 12.5 2' 'MODU 12.4 4.4' 'MODU 12 2.2' 'MODU 0 0' 'MODU    1 2' 'MODU x y' 'MODU 12 m' 'modu 1 2' 'rupture')

answerKey=('incorrect' 'incorrect' 'incorrect' ' correct' 'incorrect' ' correct' ' correct' ' correct' 'incorrect' ' correct' ' correct' 'incorrect' 'incorrect' 'incorrect' ' correct' 'incorrect' ' correct' ' correct' ' correct' 'incorrect' ' correct' ' correct' 'incorrect' 'incorrect' 'incorrect' ' correct' 'incorrect' 'incorrect' 'incorrect' ' correct' ' correct' 'incorrect' 'incorrect' 'incorrect' 'incorrect' ' correct' 'incorrect' 'incorrect' 'incorrect' ' correct' ' correct' 'incorrect' 'incorrect' 'incorrect' 'incorrect' 'incorrect' ' correct' 'incorrect' 'incorrect' 'incorrect' ' correct' ' correct' 'incorrect' 'incorrect' 'incorrect' 'incorrect' 'incorrect' ' correct' 'incorrect' 'incorrect' 'incorrect' ' correct' ' correct' 'incorrect' 'incorrect' 'incorrect' 'incorrect' 'incorrect' ' correct' 'incorrect' 'incorrect' 'incorrect' ' correct' ' correct' 'incorrect' 'incorrect' 'incorrect' 'incorrect')

for file in assign01/*; do 
	i1=`strindex "$file" "-"`
	i1=$((i1+1))
	i2=`strindex "$file" "-0"`

    if [ -f "$file" ]; then 
    	len=`echo -n $file | wc -c`
    	len=$(($len - 7))
        outfile=assign01-feedback/`echo $file | cut -c5-$len`.txt
        touch $outfile

        i=0
        score=0
        while [ $i -lt $noOfCases ]
		do 
			#echo $file
			echo "CREATE\n${testCase[$i]}\nRUPTURE" > currCase
			output=`python3 $file < currCase | grep -i "correct\|valid\|again" | grep -vi "syntax checker\|begin" ` #>> out/$outfile
			output=`echo "$output" | awk '{print tolower($0)}'`
			if [[ $output == *"${answerKey[$i]}"* ]]
			then
				((score++))
			else
				echo "Test Case: ${testCase[$i]}" >> $outfile
				echo "Your Answer: $output" >> $outfile
				echo "Correct Answer: ${answerKey[$i]}" >> $outfile
				echo "" >> $outfile
			fi
			((i++))
		done
		echo "${file:$i1:$((i2-i1))} ${file:4:$((i1-5))} \t $score" >> scores.txt
    fi 
done