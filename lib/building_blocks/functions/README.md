# Functions

Una función puede ser parte de un módulo. Las función manejan la misma convención que las variables start with lowercase or underscore character, seguido de una combinación alfanúmerica con underscores.
Las variables pueden contener `!` o `?` alfinal de su nombre, el signo ? permite indicar que la respuesta de la función en un `true` o un `false` y el signo `!` indica que talves la función puede devolver un error

las funciones puede definirse usando un `def` macro:

```elixir
defmodule Geometry do
  def rectangle_area(a, b) do # Function declaration
    ... # Function body
  end
end
```
la funciones inician con el constructor def seguido  del nombre de la función

- Nota: `defmodule` y `def` no se denominan palabras clave. En cambio, se trata de construcciones de compilación llamadas macros. Si le ayuda, puede pensar en def y defmodule como palabras clave, pero sea
consciente de que esto no es exactamente cierto

Si la función no recibe argumentos puede omitir los parénteis

```elixir
defmodule Program do
  def run do
    ...
  end
end
```

Recuerde que en Elixir, todo lo que tiene un valor de retorno
es una expresion. El valor de retorno de una función es el valor de retorno de su última expresión.
No hay retorno explícito en Elixir.

- NOTA: Dado que no hay una devolución explícita, es posible que se pregunte qué tan complejo
las funciones funcionan. La regla general es mantener las funciones
breves y simples, lo que facilita calcular el resultado y devolverlo lo de la última expresión

si la definición de una función es corta, puedes usar una sola línea para su definición

```elixir
defmodule Geometry do
  def rectangle_area(a, b), do: a * b
end
```

Calls functions
```elixir
Geometry.rectangle_area(3, 2) # => return 6
```

también puedes llamar las funciones omitiendo los parentesis
```elixir
Geometry.rectangle_area 3, 2 # => return 6
```

Si una función reside en el mismo módulo podemos omitir el prefijo del módulo para usarla dentro de alguna otra función

```elixir
defmodule Geometry do
  def rectangle_area(a, b) do
    a * b
  end

  def square_area(a) do
    rectangle_area(a, a)
  end
end
```

Dado que elixir es un lenguaje de programación funcional, a menudo encontraras una combinación de funciones pasando el resultado de esa función como argumento de la siguiente. Elixir viene con un
operador incorporado, |>, llamado operador de canalización, que hace exactamente esto:

```elixir
 -5 |> abs() |> Integer.to_string() |> IO.puts()
```
 
Este código se transforma en tiempo de compilación en lo siguiente:

```elixir
IO.puts(Integer.to_string(abs(-5)))
```

puedes usar el pipeline operator en múltiple líneas


```elixir
-5
  |> abs()
  |> Integer.to_string()
  |> IO.puts
```
