#!/bin/bash

caster () {
    # $1 - source number    <num>[k,M,G,m,u,n,p] 
    # $2 - required format  <k,M,G,m,u,n,p>
case ${1: -1} in
    k) norm=$(bc <<< "scale=2; ${1%?} * 10^3") ;;
    M) norm=$(bc <<< "scale=2; ${1%?} * 10^6") ;;
    G) norm=$(bc <<< "scale=2; ${1%?} * 10^9") ;;
    m) norm=$(bc <<< "scale=3; ${1%?} * 10^-3") ;;
    u) norm=$(bc <<< "scale=6; ${1%?} * 10^-6") ;;
    n) norm=$(bc <<< "scale=9; ${1%?} * 10^-9") ;;
    p) norm=$(bc <<< "scale=12; ${1%?} * 10^-12") ;;
    *) norm=$1 ;;
esac

case $2 in
    k) res=$(bc <<< "scale=2; $norm / 10^3") ;;
    M) res=$(bc <<< "scale=2; $norm / 10^6") ;;
    G) res=$(bc <<< "scale=2; $norm / 10^9") ;;
    m) res=$(bc <<< "scale=3; $norm / 10^-3") ;;
    u) res=$(bc <<< "scale=6; $norm / 10^-6") ;;
    n) res=$(bc <<< "scale=9; $norm / 10^-9") ;;
    p) res=$(bc <<< "scale=12; $norm / 10^-12") ;;
    *) res=$norm ;;
esac

echo $res
}

while getopts ":u:i:r:" opt; do
    case $opt in
        u) u="$OPTARG" ;;
        i) i="$OPTARG" ;;
        r) r="$OPTARG" ;;
    esac
done

u=$(caster $u)
i=$(caster $i)
r=$(caster $r)

if [ -z $u ]
    then u=$(bc <<< "scale=4; $i * $r")
fi

if [ -z $i ]
    then i=$(bc <<< "scale=4; $u / $r")
fi

if [ -z $r ]
    then r=$(bc <<< "scale=4; $u / $i")
fi

p=$(bc <<< "scale=2; $i * $u")

echo "U is  ${u}V"
echo "I is  ${i}A"
echo "R is  ${r}Ω"
echo "P is  ${p}W"
