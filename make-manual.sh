#!/bin/bash

# verifica se o diretório "pdfs" existe
if [ -d pdfs ] ; then
	cd pdfs
else
	mkdir pdfs; cd pdfs
fi

# gera o pdf da man page de cada comando contido no arquivo
for COMANDO in $(cat ../$1)
do
	echo "Gerando pdf de $COMANDO..."
	man -t $COMANDO | ps2pdf - $COMANDO.pdf
done

echo "Unir pdfs? [sim | não]"
read resp
if [ $resp = "sim" ] ; then
	# une os pdfs gerados em um único pdf
	echo "Gerando pdf..."
	pdfunite *.pdf ../linux-manual.pdf
	
	echo "Apagar a pasta temporária com os manuais? [sim | não]"
	read resp
	if [ $resp = "sim" ] ; then
		cd .. ; rm -r pdfs
	fi
fi

