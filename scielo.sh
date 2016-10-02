#!/bin/bash
aki=$(pwd)
i=0


 for scielourl in $(cat download | grep -E 'http\:\/\/\/scielo\.php\?script\=sci\_arttext.*?\"' -o | sed -e 's/\"//g' | sed -e 's/\/\/\//\/\/www\.scielo\.br\//g' | sed -e 's/\&amp\;/\&/g')
 do pid=$(echo $scielourl | sed -e 's/http.*pid\=\(.*\)\&lng.*/\1/g')
	#if (( $i < 6 ))
	#then
	     cd "$aki"
	     mkdir -p "$pid"
	     cd "$pid"
		# echo "olha o pid: $pid"
		# echo $scielourl
		 scielourlpdf=$(wget -q -O- $scielourl | grep -E 'setTimeout.*?http\:\/\/.*?sci_pdf.*?self' -o | sed -e "s/setTimeout.*\(http.*?\)/\\1/g" | sed -e 's/\s.*//g' | sed -e 's/\&amp\;/\&/g')
		# echo "olha o scielourlpdf: $scielourlpdf"
		 pdf=$(wget -q -O- "$scielourlpdf" | grep -E 'http.*?\.pdf' -oh | sed -e 's/URL=//g')
		 echo "olha a url do pdf: $pdf"
		 wget -O "$pid.pdf" "$pdf"
		 wget -O "$pid.xml" $(echo 'http://www.scielo.br/scieloOrg/php/articleXML.php?pid=')$pid$(echo '&lang=pt');xsltproc --output dublin_core.xml ../scielotodublincore.xsl $pid.xml;xsltproc --output metadata_usp.xml ../scielotousp.xsl $pid.xml         
		 #;xsltproc --output agfomento.html ../agfomento.xsl $pid.xml;html2text -o agfomento.txt -utf8 agfomento.html; grep -Pizo '(acknowledg\S+|agradec\S+)\n(.*\n)+.*?\n(literature\scited|referências|referencias|resumo|abstract)\s*\n' agfomento.txt | grep -Pvi '(AGRADECIMENTOS|ACKNOWL\S+)\s*$' | grep -Pvi '(LITERATURE\s+CITED|REFERENCIAS|REFERÊNCIAS|RESUMO|ABSTRACT)\s*$' | grep -Pv '^\s*$' > agftmp.txt ; sed -i '/<dcvalue element="description" qualifier="sponsorship" language="pt_BR">/ragftmp.txt' dublin_core.xml ; sed -i 's/TEXTOASERRETIRADO//' dublin_core.xml;rm *.html; rm *.txt; ls -1 | egrep -v '.xml$'  | grep -v 'contents' > contents
	#fi
	#let i++
	cd "$aki"
 done
 
