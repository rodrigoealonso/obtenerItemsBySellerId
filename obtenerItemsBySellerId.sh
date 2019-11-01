#!/bin/bash

#chequeo si recibi parametros
if [ $# != 0 ]; then

	#itero los seller_id recibidos
	for seller_id in "$@"
	do
		site_id='MLA'

		echo "Procesando seller_id $seller_id..."
		
		#obtengo los resultados del vendedor a traves de la API de Mercado Libre
		resultsJSON=$(curl -s -X GET https://api.mercadolibre.com/sites/$site_id/search?seller_id=$seller_id | jq -c '[.results | .[]]')

		#proceso la respuesta para obtener el id, titulo e id de categoria de cada uno de los items 
		idsJSON=$(echo "$resultsJSON" | jq -c 'map(.id)')
		titlesJSON=$(echo "$resultsJSON" | jq -c 'map(.title)')
		categoriesIdJSON=$(echo "$resultsJSON" | jq -c 'map(.category_id)')

		#remuevo los corchetes de inicio y fin [ ]
		idsJSON=${idsJSON:1:${#idsJSON}-2}
		titlesJSON=${titlesJSON:1:${#titlesJSON}-2}
		categoriesIdJSON=${categoriesIdJSON:1:${#categoriesIdJSON}-2}

		#hago un split del string por el separador ',' para luego meterlo en un array
		IFS=',' read -ra idsJSON <<< "$idsJSON"
		IFS=',' read -ra titlesJSON <<< "$titlesJSON"
		IFS=',' read -ra categoriesIdJSON <<< "$categoriesIdJSON"

		#genero el nombre de archivo dinamicamente por seller id y fecha actual
		dt=$(date '+%Y-%m-%d_%H:%M:%S');
		filename="items_of_seller_id_$seller_id--$dt.log"

		#si hay resultados imprimo en el archivo el encabezado del log con 
		#las columnas, sino muestro un error por pantalla
		if(( ${#idsJSON} != 0 )); then
			echo "id;title;category_id;categoy_name" >> $filename
		else
			echo "El seller_id $seller_id no posee items o bien no existe."
		fi
		
		#itero para procesar cada registro
		for i in "${!idsJSON[@]}"
		do
			#obtengo el id, el titulo y el id de categoria
			id=("${idsJSON[i]}")
			title=("${titlesJSON[i]}")
			category_id=("${categoriesIdJSON[i]}")
			
			#remuevo las comillas de inicio y fin " " del category_id para usarlo en el curl
			category_id_curl=${category_id:1:${#category_id}-2}
			#obtengo el nombre de la categoria haciendo un curl a la API de Mercado Libre
			category_name=$(curl -s -X GET https://api.mercadolibre.com/categories/$category_id_curl | jq '.name')

			#escribo el resultado en el archivo, cada campo separado por ';'
			echo "$id;$title;$category_id;$category_name" >> $filename
		done

	done

else
 	
 	#no recibi parametros, muestro error e invocacion de ejemplo
    echo "Sin parametros! Por favor, listar separados por un espacio los seller_id que se quieren procesar."
    echo "\t- Ejemplo para un seller_id"
    echo "\t\tsh $0 183212103"
    echo "\t- Ejemplo para mas de un seller_id"
    echo "\t\tsh $0 183212103 123456789 987654321"
 
fi