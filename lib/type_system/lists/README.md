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

## Recursive list definition

Una forma alternativa de ver las listas es pensar en
ellos como estructuras recursivas. Una lista puede estar representada por un par (cabeza, cola), donde la cabeza es la primera
elemento de la lista y la cola "apunta" a la (cabeza, cola)
par de los elementos restantes, como se ilustra en la figura 2.1. Si está familiarizado con Lisp, entonces sabe
este concepto como contras de células.
En Elixir, hay una sintaxis especial para admitir la definición de lista recurrente:

![image](https://user-images.githubusercontent.com/64051193/147367783-0b851dea-6e2f-461c-b96c-6da3baf94c4d.png)

```elixir
a_list = [head | tail] 
```

head puede ser cualquier tipo de datos, mientras que tail es en sí mismo
una lista. Si tail es una lista vacía, indica el final de
la lista completa.
Veamos algunos ejemplos:

```elixir
[1 | []] #=> [1]
[1 | [2 | []]] #=> [1, 2]
[1 | [2]] #=> [1, 2]
[1 | [2, 3, 4]] #=> [1, 2, 3, 4]
```

Esta es solo otra forma sintáctica de definir listas, pero ilustra lo que es una lista. Es un
emparejar con dos valores: una cabeza y una cola, siendo la cola en sí misma una lista.
El siguiente fragmento es una definición recursiva canónica de una lista:

```elixir
[1 | [2 | [3 | [4 | []]]]] #=> [1, 2, 3, 4]
```

Por supuesto, nadie quiere escribir construcciones como esta. Pero es importante que estés
siempre consciente de que, internamente, las listas son estructuras recursivas de pares (cabeza, cola).
Para obtener el encabezado de la lista, puede usar la función hd. La cola se puede obtener por
llamando a la función tl:

```elixir
hd([1, 2, 3, 4]) #=> 1
tl([1, 2, 3, 4]) #=> [2, 3, 4]
```

Ambas operaciones son `O(1)`, porque equivalen a leer uno u otro valor
del par (cabeza, cola).

- NOTA En aras de la integridad, debe mencionarse que la cola
no necesita ser una lista. Puede ser de cualquier tipo. Cuando la cola no es una lista, se dice que
la lista es incorrecta y la mayoría de las manipulaciones estándar de la lista no funcionarán.
Las listas incorrectas tienen algunos usos especiales, pero no nos ocuparemos de ellos en este libro.

Una vez que conozca la naturaleza recursiva de la lista, es simple y eficiente impulsar una nueva
elemento al principio de la lista:

```elixir
a_list = [5, :value, true] #=> [5, :value, true]
new_list = [:new_element | a_list] #=> [:new_element, 5, :value, true]
```

La construcción de `new_list` es una operación `O(1)` y no se produce ninguna copia de memoria.
la cola de `new_list` es la `a_list`. Para comprender cómo funciona esto, analicemos el
detalles internos de inmutabilidad un poco.
