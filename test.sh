#!/bin/bash

test_folder=llvm/test/CodeGen/Patmos/Mine

echo words stored with args 
echo none   \| var  \| arr  \| rem  \| filename

i= 0
while read -r test ; do

    build/bin/llc -filetype=asm -O2 --mpatmos-enable-block-aligned-stack-cache $test -o x1
    build/bin/llc -filetype=asm -O2 --mpatmos-enable-stack-cache-promotion --mpatmos-enable-block-aligned-stack-cache $test -o x2
    build/bin/llc -filetype=asm -O2 --mpatmos-enable-stack-cache-promotion --mpatmos-enable-array-stack-cache-promotion --mpatmos-enable-block-aligned-stack-cache $test -o x3

    noPromoSum=0
    while read -r line ; do
        noPromoSum=`expr $noPromoSum + $line`
    done < <(cat x1 | grep "sres" | grep -oP '\d+')

    varPromoSum=0
    while read -r line ; do
        varPromoSum=`expr $varPromoSum + $line`
    done < <(cat x2 | grep "sres" | grep -oP '\d+')

    arrayPromoSum=0
    while read -r line ; do
        arrayPromoSum=`expr $arrayPromoSum + $line`
    done < <(cat x3 | grep "sres" | grep -oP '\d+')

    remSum=0
    while read -r line ; do
        remSum=`expr $remSum + $line`
    done < <(cat x3 | grep "sub" | grep "r31" | awk -F',' '{print $NF}' | grep -oP '\d+')

    remSum=`expr $remSum / 4`

    if [ $arrayPromoSum -gt $varPromoSum ]; then
        echo "   $noPromoSum |   $varPromoSum |   $arrayPromoSum |   $remSum | $test"
    elif [ $remSum != 0 ]; then
        echo "   $noPromoSum |   $varPromoSum |   $arrayPromoSum |   $remSum | $test"
    fi

    
    i=`expr $i + 1`

done < <(find "$test_folder" -type f -name "*.ll")

echo $i