# Module Attributes

El propósito de los atributos de módulos es doble
 - puede ser usados como constantes en tiempo de compilación
 - y poder registrar cualquier atributo 

```elixir
defmodule Circle do
  @pi 3.14159 #  Defines a module attribute

  def area(r), do: r * r * @pi #  Uses a module attribute
  
  def circumference(r), do: 2 * r * @pi # Uses a module attribute
end

Circle.area(1) # => 3.14159
Circle.circumference(1) # => 6.28318
```

Lo importante aquí es que `@pi` funciona como una constante durante el tiempo de compilación
Además, se puede registrar un atributo, lo que significa que se almacenará en el binario generado y se podrá acceder a él en tiempo de ejecución. Elixir registra algunos atributos del módulo por
defecto. Por ejemplo, los atributos @moduledoc y @doc se pueden usar para proporcionar documentación para módulos y funciones:

```elixir
defmodule Circle do
  @moduledoc "Implements basic circle functions"
  @api 3.14159

  @doc "Computes the area of a circle"
  def area(r), do: r * r * @pi

  @doc "Computes the circumference of a circle"
  def circumference(r), do: 2 * r * @pi
end
```

para ver esto es necesario generar un archivo compilado

```elixir
elixir circle.ex
```

después inicie iex shell

```elixir
Code.get_docs(Circle, :moduledoc) # => {1, "Implements basic circle functions"}
```

Otra característica del ecosistema de ruby es que sabe como trabajar con esos atributos

```elixir
h Circle # => Implements basic circle functions

# Function documentation
h Circle.area  # => Computes the area of a circle
```

Además, puede utilizar la herramienta ex_doc (consulte https://github.com/elixir-lang/ex_doc)
para generar documentación HTML para su proyecto. Esta es la forma en que la documentación de Elixir
se produce, y si planea construir proyectos más complejos, especialmente algo que
será utilizado por muchos clientes diferentes, debería considerar el uso de @moduledoc y @doc.
El punto subyacente es que los atributos registrados se pueden usar para adjuntar metainformación a un módulo, que luego puede ser usado por otras herramientas Elixir (e incluso Erlang). Ahí
Hay muchos otros atributos registrados previamente, y también puede registrar sus propios atributos personalizados. Eche un vistazo a la documentación del módulo Módulo (https://hexdocs.pm/
elixir / Module.html) para obtener más detalles.

## Type specifications

(a menudo llamados typespecs) son otra característica importante basada en atributos

```elixir
defmodule Circle do
  @pi 3.141559

  @spec area(number) :: number # =>  Type specification for area/1
  def area(r), do: r * r * @pi

  @spec circumference(number) :: number # => Type specification for circumference/1
  def circumference(r), do: 2 * r * @pi
end
```

En este caso el atributo `@spec` indica que ambas funciones reciben y devuelven un número.

Typepecs proporciona una forma de compensar la falta de un sistema de tipos estáticos. Esto puede ser
útil junto con la herramienta dializador para realizar análisis estáticos de sus programas.
Además, las especificaciones de tipo le permiten documentar mejor sus funciones. Recuerda ese Elixir
es un lenguaje dinámico, por lo que las entradas y salidas de funciones no se pueden deducir fácilmente mirando
la firma de la función. Typepecs puede ayudar significativamente con esto, y yo personalmente puedo
atestiguan que es mucho más fácil entender el código de otra persona cuando se proporcionan las especificaciones de tipo.
Por ejemplo, mire la especificación de tipo para la función 
Elixir:

```elixir
List.insert_at / 3:
@spec insert_at(list, integer, any) :: list
```

Incluso sin mirar el código o leer los documentos, puede adivinar razonablemente que
esta función inserta un término de cualquier tipo (tercer argumento) en una lista (primer argumento) en un
posición dada (segundo argumento) y devuelve una nueva lista.
No utilizará typepecs en este libro, principalmente para mantener el código lo más breve posible.
Pero si planea construir sistemas más complejos, mi consejo es que considere seriamente usar
typepecs. Puede encontrar una referencia detallada en los documentos oficiales en https://hexdocs.pm/
elixir / typespecs.html.

## Comments

Los comentarios en Elixir comienzan con el carácter #, que indica que el resto de la línea es
un comentario. No se admiten los comentarios de bloque. Si necesita comentar varias líneas,
prefija cada uno con un carácter #

```elixir
# This is a comment
a = 3.14 # so is this
```
