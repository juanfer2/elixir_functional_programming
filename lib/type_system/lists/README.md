# Listas

Las listas en Erlang se utilizan para administrar colecciones de datos dinámicas de tamaño variable. La sintaxis engañosamente se parece a las matrices de otros idiomas:

```elixir
prime_numbers = [2, 3, 5, 7] # => [2, 3, 5, 7]
```

Las listas pueden parecer matrices, pero funcionan como listas enlazadas individualmente. Hacer algo con
la lista, tienes que recorrerla. Por lo tanto, la mayoría de las operaciones en listas tienen una `O(n)`
complejidad, incluida la función `Kernel.length/1`, que itera a través de la
lista completa para calcular su longitud:

```elixir
length(prime_numbers) # => 4
```

- Lista de funciones de utilidad: Hay muchas operaciones que puede hacer con listas, pero esta sección menciona solo un par
de los más básicos. Para obtener una referencia detallada, consulte la documentación de la Lista
módulo (https://hexdocs.pm/elixir/List.html). También hay muchos servicios útiles en
el módulo Enum (https://hexdocs.pm/elixir/Enum.html).
El módulo Enum trata con muchas estructuras enumerables diferentes y no se limita a
liza. El concepto de enumerables se explicará en detalle en el capítulo 4, cuando analicemos los protocolos.

Para obtener un elemento de una lista, puede usar la función `Enum.at/2`:

```elixir
Enum.at(prime_numbers, 3) # => 7
```

`Enum.at` es nuevamente una operación O(n): itera desde el principio de la lista hasta el
elemento deseado. Las listas nunca son adecuadas cuando se requiere acceso directo. Para esos
propósitos podemos usar `tuplas`, `maps` o una estructura de datos de nivel superior es apropiada.
Puede comprobar si una lista contiene un elemento en particular con la ayuda de in
operador:


```elixir
5 in prime_numbers # => true
4 in prime_numbers # => false
```

Para manipular listas, puede utilizar funciones del módulo `List`. Por ejemplo, `List.replace_at/3` modifica el elemento en una posición determinada:

```elixir
List.replace_at(prime_numbers, 0, 11) # => [11, 3, 5, 7]
```

Como sucedió con las tuplas, el modificador no muta la variable, pero devuelve el
versión modificada de la misma, que debe almacenar en otra variable:

```elixir
new_primes = List.replace_at(prime_numbers, 0, 11) # => [11, 3, 5, 7]
```

O puede volver a enlazar al mismo:

```elixir
prime_numbers = List.replace_at(prime_numbers, 0, 11) # => [11, 3, 5, 7]
```

Puede insertar un nuevo elemento en la posición especificada con `List.insert_at`:

```elixir
#  Inserts a new element at the fourth position
List.insert_at(prime_numbers, 3, 13)  # => [11, 3, 5, 13, 7]
```

Para agregar al final, puede usar un valor negativo para la posición de inserción:

```elixir
#  Value of -1 indicates that the element should be appended to the end of the list
List.insert_at(prime_numbers, -1, 13)  # => [11, 3, 5, 7, 13]
```

Como la mayoría de las operaciones de lista, modificar un elemento arbitrario tiene una complejidad de `O(n)`. En
En particular, agregar al final es costoso porque siempre requiere n pasos, siendo `n`
la longitud de la lista.
Además, el operador dedicado `++` está disponible. Concatena dos listas:

```elixir
[1, 2, 3] ++ [4, 5]  # => [1, 2, 3, 4, 5]
```

Nuevamente, la complejidad es `O(n)`, siendo n la longitud de la lista de la izquierda (la que está
anexando a). En general, debe evitar agregar elementos al final de una lista. las listas
son más eficientes cuando los elementos nuevos se colocan en la parte superior o se extraen de ella.
Para entender por qué, veamos la naturaleza recursiva de las listas
