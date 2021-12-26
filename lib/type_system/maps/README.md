# Maps

Un mapa es un almacén de clave / valor, donde las claves y los valores pueden ser cualquier término. Los mapas tienen doble
uso en Elixir. Se utilizan para impulsar estructuras clave / valor de tamaño dinámico, pero
también se utilizan para administrar registros simples: un par de campos con nombres bien definidos
agrupados juntos. Echemos un vistazo a estos casos por separado

## Maps de tamaño dinámico

Se puede crear un mapa vacío con la construcción %{}:

```elixir
empty_map = %{}
```

Un map con algún valur puede ser creado con la siguiente sintaxis:

```elixir
squares = %{1 => 1, 2 => 4, 3 => 9}
```

También puedes popularlo con la función `Map.new/1`. La función toma un enumerable donde cada elemento es una tupla de tamaño 2 (un par):

```elixir
squares = Map.new([{1, 2}, {2, 4}, {3, 9}]) #=> %{1 => 1, 2 => 4, 3 => 9}
```

para obtener algún valor de los más puede acceder a ellos por su key

```elixir
squares[2] #=> 4
squares[4] #=> nil
```

En la segunda expresión, obtiene un nulo porque no hay ningún valor asociado con la clave dada.
Se puede obtener un resultado similar con `Map.get/3`. En la superficie, esta función
se comporta como `[]`. Pero `Map.get/3` le permite especificar el valor predeterminado, que se devuelve
si no se encuentra la clave. Si no se proporciona este valor predeterminado, se devolverá `nil`:

```elixir
Map.get(square, 2) #=> 4
Map.get(square, 4) #=> nil
Map.get(square, 2, :not_found) #=> :not_found
```

Observe que en la última expresión no sabe con precisión si no hay valor
bajo la clave dada, o si el valor es `:not_found`. Si quieres distinguir con precisión
entre estos casos, puede utilizar `Map.fetch/2`:

```elixir
Map.fetch(squares, 2) #=> {:ok, 4}
Map.fetch(squares, 4) #=> :error
```

Como puede ver, en el caso de éxito, obtendrá un valor en forma de `{: ok, value}`.
Este formato permite detectar con precisión el caso cuando la clave no está presente.
A veces, solo desea continuar si la clave está en el mapa y generar una excepción
de lo contrario. Esto se puede hacer con la función `Map.fetch!/2`:

```elixir
Map.fetch!(squares, 2) #=> 4
Map.fetch!(squares, 4) #=> ** (KeyError) key 4 not found in: %{1 => 1, 2 => 4, 3 => 9} (stdlib) :maps.get(4, %{1 => 1, 2 => 4, 3 => 9})
```

Para almacenar un nuevo elemento puedes usar ``Map.put/3`:

```elixir
squares = Map.put(squares, 4, 16)
squares[4] # => 16
```

Hay muchas otras funciones útiles en el módulo Mapa, como `Map.update/4`
o `Map.delete/2`. Puede consultar la documentación oficial del módulo en https: //
hexdocs.pm/elixir/Map.html. Además, un mapa también es enumerable, lo que significa
que todas las funciones del módulo `Enum` pueden trabajar con maps

## Estructurando la data

Los maps son el tipo de referencia para administrar estructuras de datos de clave/valor de un tamaño arbitrario. Pero
También se utilizan con frecuencia en Elixir para combinar un par de campos en una sola estructura. Este caso de uso se superpone un tanto al de las tuplas, pero ofrece la ventaja de
permitiéndole acceder a los campos por nombre.

Veamos un ejemplo. En el siguiente fragmento, creará un mapa que representa
una persona soltera:

```elixir
bob = %{:name => "Bob", :age => 25, :works_at => "Initech"}
```

Si las claves son átomos, puede escribir esto para que sea un poco más corto:


```elixir
bob = %{name: "Bob", age: 25, works_at: "Initech"}
bob[:works_at] #=> Initech
bob[:non_existent_field] #=> nil
```

Las claves Atom reciben de nuevo un tratamiento de sintaxis especial. El siguiente fragmento obtiene un valor
almacenado bajo la clave: age:

```elixir
bob.age #=> 25
```

Con esta sintaxis, obtendrá un error si intenta obtener un campo inexistente:

```elixir
bob.non_existent_field #=> ** (KeyError) key :non_existent_field not found
```

Para cambiar uno o muchos valores solamente existentes con la siguiente sintaxis:

```elixir
bob.next_years_bob = %{bob | age: 26} #=> %{age: 26, name: "Bob", works_at: "Initech"}
%{bob | age: 26, works_at: "Initrode"} #=> %{age: 26, name: "Bob", works_at: "Initrode"}
%{bob | works_in: "Initech"} #=> ** (KeyError) key :works_in not found
```

El uso de maps para contener datos estructurados es un patrón frecuente en Elixir. El patrón común es proporcionar todos los campos mientras se crea el mapa, utilizando átomos como claves. Si el valor para algún campo no está disponible, puede establecerlo en cero. Un mapa así, entonces, siempre tiene todo los campos. Con la sintaxis de actualización, puede modificar el map con la sintaxis de actualización.
Finalmente, para buscar un campo deseado, puede usar la sintaxis `a_map.some_field`.
Por supuesto, estos datos siguen siendo un mapa, por lo que también puede utilizar las funciones del Map
módulo, como `Map.put/3` o `Map.fetch/2`. Pero estas funciones suelen ser adecuadas para los casos en los que los maps se utilizan para gestionar una estructura clave/valor de tamaño dinámico.

