# Inferencia causal del problema del tranvía

Este trabajo busca analizar el modelo de inferencia causal de jalar o no la palanca del problema del tranvía.

El problema del tranvía consiste en que una persona está en control de una palanca que cambiaría el curso de un tren a toda velocidad. Si el agente jala la palanca, el tren mata únicamente a una persona; si no jala la palanca, el tren mata a cinco personas.

Hicieron un experimento a 9930 adultos anglohablantes de EEUU, Reino Unido y Canadá, en el que les enseñaron 32 escenarios con variaciones ligeras y les pidieron que calificara si les pareció que la decisión del agente fue muy mala (o prohibida, 1) a muy buena (u obligaqtoria, 7). Se recopilaron variables de control de los encuestados de edad, género y educación. 

por otro lado, los autores plantearon tres modelos (que a su vez tenían variantes adicionales) de inferencia bayesiana para predecir la variable de respuesta, 5todas ellas con verosimilitud dorderlogit  los cambios estaban en las especificaciones del modelo o en la definición de algunas pruebas. 

En el modelo mas sencillo, el parametro esta compuesto de una combinacion lineal de las variables de acción, intención o contacto  en el segundo se añadieron variables de edad y educación, en la tercera se añadió una variable de distribución Dirichlet  
