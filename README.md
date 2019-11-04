Ejercicio de Mercado Libre para puesto de Analista Técnico Funcional:

Construir un script que nos permita realizar la siguiente tarea:
1. Recorrer todos los ítems publicados por el **seller_id = 183212103** del **site_id = "MLA"**
2. Generar un archivo de LOG que contenga los siguientes datos de cada ítem:
    * "id" del ítem, "title" del item, "category_id" donde está publicado, "name" de la categoría.
   
(\*) Usar como ayuda el siguiente site [http://developers.mercadolibre.com/](http://developers.mercadolibre.com/)

Construir el script en cualquier lenguaje de programación para realizar lo anteriormente solicitado. Hacerlo de forma genérica para poder re-utilizarlo con uno o múltiples users como entrada.


### ¿Cómo ejecutar el script?
1. Descargar el script [obtenerItemsBySellerId.sh](https://github.com/rodrigoealonso/obtenerItemsBySellerId/blob/master/obtenerItemsBySellerId.sh)
2. Abrir la consola en la ubicación del archivo
3. Ejecutarlo con el siguiente comando: 
~~~
sh obtenerItemsBySellerId.sh seller_id_1 seller_id_2 seller_id_N
~~~

Donde *seller_id_X* es el id del vendedor
  
* Ejemplos:
~~~
sh obtenerItemsBySellerId.sh 183212103 123456789 987654321
~~~
~~~
sh obtenerItemsBySellerId.sh 183212103
~~~

Como resultado, el script arrojará un archivo de log listando la información solicitada de cada item. Esto es por cada uno de los seller_id ingresados siempre y cuando estos existan y posean items. El nombre del archivo incluye el seller id y la fecha y hora de cuando se generó.
[Archivo de ejemplo](https://github.com/rodrigoealonso/obtenerItemsBySellerId/blob/master/items_of_seller_id_183212103--2019-11-04_16:51:14.log)
