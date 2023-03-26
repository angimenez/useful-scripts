#!/bin/bash
#
###########################################
#                                         #
# Script para migrar web wordpress de un  #
# dominio a otro (agregando https tambien)#
#                                         #
###########################################

print_help(){
	cat << EOF
############################################
#                                          #
# Script para migrar web wordpress de un   #
# dominio a otro (agregando https tambien) #
#                                          #
# Creado por: Nicolas Gimenez              #
# Fecha de Modificacion: 27/04/2021        #
#                                          #
############################################

MODO DE USO:

migration.sh -f domainFrom -t domainTo -d path/to/directory
-f indica desde que dominio se migra
-t indica a que dominio migrar
-d la carpeta donde estan los archivos a migrar


EOF
}

while getopts f:t:d: flag
do
    case "${flag}" in
        f) from=${OPTARG};;
        t) to=${OPTARG};;
        d) folder=${OPTARG};;
    esac
done
if [ -z "$from" ]; then
	echo $from
	print_help
	exit 0
fi
if [ -z "$to" ]; then
        echo $to
        print_help
        exit 0
fi
if [ -z "$folder" ]; then
        echo $folder
        print_help
        exit 0
fi

echo "Esta seguro de continuar? (s para si, cualquiera para no)"
echo
echo "From: $from";
echo "To: $to";
echo "Folder: $folder";
echo "##############"
echo
read
if [ $REPLY = "s" ]; then
	grep -rl "http://$from" $folder | xargs sed -i 's/http:\\\\\/\\\\\/'"$from"'/https:\\\\\/\\\\\/'"$to"'/g'
	grep -rl "http://$from" $folder | xargs sed -i 's/http:\/\/'"$from"'/https:\/\/'"$to"'/g'
	grep -rl "$from" $folder | xargs sed -i 's/'"$from"'/'"$to"'/g'
	exit 0
fi
echo "** ABORTADO **"

