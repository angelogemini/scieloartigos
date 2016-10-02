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
                 wget -O "$pid.xml" $(echo 'http://www.scielo.br/scieloOrg/php/articleXML.php?pid=')$pid$(echo '&lang=pt');xsltproc --output dublin_core.xml ../scielotodublincore.xsl $pid.xml
	cd "$aki"
 done
 
