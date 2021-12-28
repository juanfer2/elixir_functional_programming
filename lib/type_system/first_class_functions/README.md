# First-class funtions


En Elixir, una función es un ciudadano de primera clase, lo que significa que puede asignarse a una variable.
Aquí, asignar una función a una variable no significa llamar a la función y almacenar
su resultado a una variable. En su lugar, se asigna la definición de función en sí, y puede
use la variable para llamar a la función.
Veamos algunos ejemplos. Para crear una variable de función, puede usar la función fn
construir:

```elixir
square = fn x ->
  x + x
end
```

La variable square ahora contiene una función que computa dos numeros. Debido a que la función no está vinculada a un nombre global, también se la denomina función anónima o lambda.


Tenga en cuenta que la lista de argumentos no está entre paréntesis. Técnicamente, puedes
usar paréntesis aquí, pero la convención predominante, también impuesta por el formato Elixir, es omitir los paréntesis. Por el contrario, una lista de argumentos para una función nombrada debe estar entre paréntesis. A primera vista, esto parece inconsistente, pero hay una buena
motivo de esta convención, que se explicará en el capítulo 3.
Puede llamar a esta función especificando el nombre de la variable seguido de un punto `(.)` Y los argumentos

```elixir
square.(5)
```

- NOTA: Puede que se pregunte por qué se necesita el operador de punto aquí. La motivacion detrás del operador de punto es hacer el código más explícito. Cuando encuentra una expresión cuadrada. (5) en el código fuente, conoce una expresión anónima se invoca la función. Por el contrario, la expresión cuadrado(5) invoca un función nombrada definida en algún otro lugar del módulo. Sin el operador de puntos, tendría que analizar el código circundante para comprender si está
llamar a una función nombrada o anónima.

Debido a que las funciones se pueden almacenar en una variable, se pueden pasar como argumentos a otras
funciones. Esto se usa a menudo para permitir a los clientes parametrizar la lógica genérica. Por ejemplo, la función `Enum.each/2` implementa la iteración genérica; puede iterar sobre cualquier cosa enumerable, como listas. La función `Enum.each/2` toma dos argumentos: un enumerable y una lambda de una aridad (una función anónima que acepta un argumento). Repite el enumerable y llama a la lambda para cada elemento. Los clientes proporcionan la lambda para especificar lo que quieren hacer con cada elemento. El siguiente fragmento usa `Enum.each` para imprimir cada valor de una lista en la pantalla:

```elixir
print_element = fn x -> IO.puts(x) end # Defines the lambda
Enum.each([1, 2, 3], print_element) #  Passes the lambda to Enum.each

#  Output printed by the lambda
# =>1
# =>2
# =>3

#  Return value of Enum.each
# => :ok
```
Por supuesto, no necesita una variable temporal para pasar el lambda a Enum.each:

```elixir
Enum.each(
  [1, 2, 3],
  fn x -> IO.puts(x) end #  Passes the lambda directly
)
```

Observe cómo la lambda simplemente reenvía todos los argumentos a entradas IO, sin realizar ningún otro trabajo significativo. Para tales casos, Elixir permite hacer referencia directa a la función y tener una definición lambda más compacta. En lugar de escribir `fn x → IO.puts (x) end`, puede escribir `&IO.puts/1`.
El operador `&`, también conocido como capture operator, toma el calificador de función completa:
un nombre de módulo, un nombre de función y una aridad, y convierte esa función en una lambda
que se puede asignar a una variable. Puede utilizar el capture operator para simplificar la llamada
a `Enum.each`:

```elixir
Enum.each(
  [1, 2, 3],
  &IO.puts/1
)
```

capture operator también se puede utilizar para acortar la definición lambda, haciéndola posible omitir la denominación explícita de argumentos. Por ejemplo, puede convertir esta definición: 

```elixir
lambda = fn x, y, z -> x * y + z end
```

en algo más compacto

```elixir
lambda = &(&1 * &2 + &3)
```

Este fragmento crea una lambda de tres aridades. Se hace referencia a cada argumento mediante el & n marcador de posición, que identifica el n-ésimo argumento de la función. Puedes llamar a esta lambda como
cualquier otro:

```elixir
lambda.(2, 3, 4) #=> 10
```

El valor de retorno 10 equivale a 2 * 3 + 4, como se especifica en la definición de lambda.
