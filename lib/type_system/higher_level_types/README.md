# Higher-level types

Los tipos incorporados que acabamos de mencionar se heredan del mundo Erlang. Después de todo, Elixir El código se ejecuta en BEAM, por lo que su sistema de tipos está fuertemente influenciado por los fundamentos de Erlang. Pero además de estos tipos básicos, Elixir proporciona algunas abstracciones de nivel superior. El los que se utilizan con más frecuencia son:

- `Range`
- `Keyword` 
- `MapSet`
- `Date`
- `Time` 
- `NaiveDateTime`
- `DateTime` 

Examinemos cada uno de ellos.

## Range

Un rango es una abstracción que le permite representar un rango de números. Elixir incluso
proporciona una sintaxis especial para definir rangos:

```elixir
range = 1..2
```

Puede preguntar si un número cae en el rango usando el operador `in`:

```elixir
range = 1..2

2 in range #=> true
-1 in range #=> false
```

Los rangos son enumerables, por lo que las funciones del módulo `Enum` saben cómo trabajar con ellos. Anteriormente conociste `Enum.each/2`, que itera a través de un enumerable. El siguiente ejemplo utiliza esta función con un rango para imprimir los primeros tres números:

```elixir
Enum.each(
  1..3,
  &IO.puts/1
)
```

Es importante darse cuenta de que un rango no es un tipo especial. Internamente, se representa como un mapa que contiene límites de rango. No debe confiar en este conocimiento, porque la representación del rango es un detalle de implementación, pero es bueno tener en cuenta que la huella de memoria de un rango es muy pequeña, independientemente del tamaño. Un número de un millón el rango sigue siendo solo un pequeño map.

## Keyword lists

Una lista de `keyword` es un caso especial de una lista, donde cada elemento es una `tupla` de dos elementos y el primer elemento de cada tupla es un átomo. El segundo elemento puede ser de cualquier tipo. Vamos mirar un ejemplo:

```elixir
days = [{:monday, 1}, {:tuesday, 2}, {:wednesday, 3}]
```

Elixir allows a slightly more elegant syntax for defining a keyword list:

```elixir
days = [monday: 1, tuesday: 2, wednesday: 3]
```

Ambas construcciones producen el mismo resultado: una lista de pares. Podría decirse que el segundo es un poco mas elegante.
las `keyword lists` se utilizan a menudo para estructuras `clave/valor` de tamaño pequeño, donde las claves son átomos.
Muchas funciones útiles están disponibles en el módulo de palabras clave (https://hexdocs.pm/
elixir / Keyword.html). Por ejemplo, puede utilizar Keyword.get / 2 para obtener el valor de
una llave:

```elixir
Keyword.get(days, :monday) #=> 1
Keyword.get(days, :noday) #=> nil
days[:tuesday] #=> 2
```

Sin embargo, no dejes que eso te engañe. Como se trata de una lista, la complejidad de un ja operación de búsqueda es `O(n)`. las listas de palabras clave suelen ser útiles para permitir que los clientes pasen un número arbitrario de argumentos opcionales. Por ejemplo, el resultado de la función `IO.inspect`, que imprime una representación de cadena de un término en la consola, se puede controlar proporcionando opciones adicionales a través de una lista de palabras clave:

```elixir
IO.inspect([100, 200, 300]) #=> [100, 200, 300] Default behavior
IO.inspect([100, 200, 300],  [width: 3]) #=>  Passes additional options

#=> [100, 
#=>  200, 
#=>  300] 
```

De hecho, este patrón es tan frecuente que Elixir le permite omitir los corchetes si el último argumento es una lista de palabras clave:

```elixir
IO.inspect([100, 200, 300], width: 3, limit: 1)
#=> [100,
#=> ...]
```

Observe en este ejemplo que todavía está enviando dos argumentos a `IO.inspect/2`: a número y una lista de palabras clave de dos elementos. Pero este fragmento demuestra cómo simular argumentos opcionales. Puede aceptar una lista de palabras clave como último argumento de su función y hacer que ese argumento sea predeterminado en una lista vacía:

```elixir
def my_fun(arg1, arg2, arg3, otps \\ []) do
  ...
end
```

A continuación, sus clientes pueden pasar opciones a través del último argumento. Por supuesto, depende de usted verifique el contenido en el argumento `opts` y realice alguna lógica condicional dependiendo de lo que le haya enviado el cliente que llama.


Quizás se pregunte si es mejor usar maps en lugar de palabras clave para argumentos opcionales. Una lista de palabras clave puede contener varios valores para la misma clave. Además, puede controlar el orden de los elementos de la lista de palabras clave, algo que no es posible con los maps. Finalmente, muchas funciones en las bibliotecas estándar de Elixir y Erlang toman sus opciones como `keyword lists`. Es mejor ceñirse a la convención existente y aceptar parámetros opcionales a través de listas de palabras clave.


## MapSet

Un `MapSet` es la implementación de un conjunto, un almacén de valores únicos, donde un valor puede ser de cualquier tipo. veamos algunos ejemplos:

```elixir
days = MapSet.new([:monday, :tuesday, :wednesday]) #=> #MapSet<[:monday, :tuesday, :wednesday]>
MapSet.member?(days, :monday)  #=> true
MapSet.member?(days, :noday)  #=> false
 
#Puts a new element to the MapSet
days = MapSet.put(days, :thursday)  #=> #MapSet<[:monday, :thursday, :tuesday, :wednesday]>
```

Como puede ver, puede manipular el conjunto utilizando la función del módulo MapSet. Para obtener una referencia detallada, consulte la documentación oficial en https://hexdocs.pm/ elixir / MapSet.html. Un MapSet también es enumerable, por lo que puede pasarlo a funciones desde el módulo Enum:

```elixir
Enum.each(days, &IO.puts/1)
#=> monday
#=> thursday
#=> tuesday
#=> wednesday
```

Como puede ver en el resultado, MapSet no conserva el orden de los elementos.

## Times and dates

Elixir tiene un par de módulos para trabajar con tipos de fecha y hora: `Date`, `Time`, `DateTime` y `NaiveDateTime`.
Se puede crear una fecha con el sigilo `~D`. El siguiente ejemplo crea una fecha que
representa el 31 de enero de 2018:

```elixir
date = ~D[2018-01-31] #=>  date = ~D[2018-01-31]
```

Una vez que haya creado la fecha, puede recuperar sus campos individuales:

```elixir
date.year #=> 2018
date.month #=> 1
```

De manera similar, puede representar un tiempo con el sigilo `~ T`, proporcionando horas, minutos, segundos y microsegundos:

```elixir
time = ~T[11:59:12.00007]
time.hour #=> 11
time.minute #=> 59
```

También hay algunas funciones útiles disponibles en los módulos Fecha (https://hexdocs.pm/elixir/date.html) y Hora (https://hexdocs.pm/elixir/Time.html).

Además de estos dos tipos, también puede trabajar con fechas y horas utilizando los módulos `NaiveDate` `Time` y `DateTime`. La versión ingenua se puede crear con el sigilo `~N`:

```elixir
naive_datetime = ~N[2018-01-31 11:59:12.000007]
naive_datetime.year #=> 2018
naive_datetime.hour #=> 11
```

El módulo DateTime se puede utilizar para trabajar con fechas y horas en alguna zona horaria. a diferencia de con otros tipos, no hay sigilo disponible. En su lugar, puede crear una fecha y hora utilizando las funciones de `Time`:
 
```elixir
datetime = DateTime.from_naive!(naive_datetime, "Etc/UTC")
datetime.year #=> 2018
datetime.hour #=> 11
datetime.time_zon #=> "Etc/UTC"
```

Puede consultar la documentación de referencia, disponible en https://hexdocs.pm/elixir/baiveDateTime.html y https://hexdocs.pm/elixir/DateTime.html, para más
detalles sobre cómo trabajar con estos tipos.
