#!/bin/bash
raiz=$(pwd)
echo "caminho onde o script está rodando $raiz"
file_var=$(find . -name "global_vars.yml")
echo "caminho do arquivo de variaveis $file_var"
envs=$(cat $file_var)
arquivos=$(find "$raiz" -name '*' -type f | grep -v $file_var | grep -v "/objects"| grep -v "hooks")
file=$(find "$raiz" -name '*.yml' -type f | grep -v $file_var)
qnt=$(echo "$envs" | wc -l)
while [ $qnt -gt 0 ]
do
      psc=$(echo "$envs" | awk NR==$qnt)
      key=$(echo "var_$psc"| awk -F": " '{printf $1}')
      value=$(echo "$psc"|awk -F": " '{printf $2}'| sed "s/\//\\\\\//g")
      for arq in $arquivos
      do
        sed -i "s/${key}/${value}/g" $arq
      done
      #echo "$key e $value"
   qnt=$(( $qnt - 1 ))
done


