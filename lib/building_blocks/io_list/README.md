# IO lists

Una lista de I/O es un tipo especial de lista que es útil para generar resultados de manera incremental que al ser reenviado a un dispositivo de I/O, como una red o un archivo. Cada elemento de una lista IO debe ser uno de los siguientes:

- Un número entero en el rango de 0 a 255
- Un binario
- Una lista de IO

En otras palabras, una lista de I/O es una estructura profundamente anidada en la que los elementos de hoja son simples
bytes (o binarios, que nuevamente son una secuencia de bytes). Por ejemplo, aquí está "Hola
mundo "representado como una lista IO complicada:

```elixir
iolist = [[['H', 'e'], "llo,"], " worl", "d!"]
```

Observe cómo puede combinar listas de caracteres y cadenas binarias en una lista profundamente anidada.
Muchas funciones de E / S pueden trabajar directa y eficientemente con dichos datos. Por ejemplo,
puede imprimir esta estructura en la pantalla:
iex (2)> IO.puts (iolist)
¡Hola Mundo!
Debajo del capó, la estructura se aplana y puede ver la salida legible por humanos. Obtendrá el mismo efecto si envía una lista de E / S a un archivo o una toma de red.
Las listas de E / S son útiles cuando necesita construir incrementalmente un flujo de bytes. Liza
generalmente no son buenos en este caso, porque agregar a una lista es una operación O (n). En
Por el contrario, agregar a una lista de E / S es O (1), porque puede usar el anidamiento. Aquí hay una demostración de esta técnica:
