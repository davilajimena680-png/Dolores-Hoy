# Directorio Dolores Hidalgo: TDD y API

## 1. Pruebas de Cliente y Seguridad

Rojo: las pruebas iniciales del cliente HTTP y seguridad fallan.

![Pruebas rojas clientes](assets/pruebas_rojas_clientes.png)

### Cliente Falso y Cliente Seguro

Rojo: la prueba del cliente falso y el cliente seguro falla porque aún no están implementadas las validaciones.

![Rojo cliente falso](assets/rojo_cliente_falso.png)
![Rojo cliente seguro](assets/rojo_cliente_seguro.png)

Verde: se implementa el cliente seguro y la prueba pasa.

![Verde cliente seguro](assets/verde_cliente_seguro.png)

### Seguridad General

Rojo: la prueba de seguridad general falla.

![Rojo seguridad](assets/rojo_seguridad.png)

Verde: se implementan las políticas de seguridad y la prueba pasa.

![Verde seguridad](assets/verde_seguridad.png)

---

## 2. Pruebas de Servicios (APIs)

Rojo: las pruebas de integración de los servicios fallan porque aún no se han desarrollado.

![Rojo servicios](assets/rojo_servicios.png)

Verde: se implementan los servicios y las pruebas pasan.

![Verde servicios](assets/verde_servicios.png)

### Iteraciones de Servicios

Rojo: las pruebas de las iteraciones avanzadas fallan.

![Rojo 2 servicios](assets/rojo2_servicios.png)
![Rojo 3 servicios](assets/rojo3_servicios.png)
![Rojo 6 servicios](assets/rojo6_servicios.png)

Verde: se completan las iteraciones y las pruebas pasan exitosamente.

![Verde 3 servicios](assets/verde3_servicios.png)
![Verde 6 servicios](assets/verde6_servicios.png)

### API NASA

Verde: la prueba específica para la API de la NASA pasa correctamente.

![Verde NASA](assets/verde_nasa.png)

---

## 3. Tablero ViewModel (Gestión de Estados)

Rojo: la prueba de la secuencia de estados del ViewModel (cargando, error, datos) falla.

![Rojo tablero viewmodel](assets/rojo_tableroviewmodel.png)

Verde: se implementa la gestión de estados en el ViewModel y la prueba pasa.

![Verde tablero viewmodel](assets/verde_tableroviewmodel.png)

---

## 4. Vistas y Comportamiento en la Aplicación

Página funcionando: la aplicación carga correctamente los datos de las APIs.

![Página funcionando](assets/pagina_funcionando.png)

Todas funcionando: tablero completo consumiendo todas las APIs correctamente.

![Todas funcionando](assets/todas_funcionando.png)

### Manejo de Errores y Red

Página sin internet: manejo adecuado de la excepción por falta de conectividad.

![Página sin internet](assets/paguna_sininternet.png)

Página con error 403: manejo de respuestas de acceso denegado por parte del servidor.

![Página con error 403](assets/pagina%20con%20error%20403.png)
