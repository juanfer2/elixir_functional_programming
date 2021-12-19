# Function arity

Arity es un nombre elegante para la cantidad de argumentos que recibe una función. Una función es
identificado de forma única por su módulo contenedor, su nombre y su aridad. 


```elixir
defmodule Rectangle do
  def area(a, b) do # Function with two arguments
    ...
  end
end
```

La función `Rectangle.area` recibe dos argumentos,  por lo que se dice que es una función de
arity 2. En el mundo de Elixir, esta función a menudo se llama Rectangle.area / 2, donde el
La parte / 2 denota la aridad de la función.
¿Porque es esto importante? Porque dos funciones con el mismo nombre pero diferentes.
Las aridades son dos funciones diferentes, como lo demuestra el siguiente ejemplo

```elixir
defmodule Rectangle do
  def area(a) do: area(a, a) # Rectangle.area/1

  def area(a, b) do: a * b # Rectangle.area/2
end
```

Al cargar el módulo, la función se puede llamar de la siguiente manera:

```elixir
Rectangle.area(5) # => 25

Rectangle.area(5, 6) # => 30
```

Como puedes ver las dos funciones actuan de manera diferente. el nombre se reutiliza pero las aristas son diferentes.
por lo que hablamos de ellas como dos funciones distintas, cada una
teniendo su propia implementación.
Por lo general, no tiene sentido que diferentes funciones con el mismo nombre tengan implementaciones completamente diferentes. Más comúnmente, una función de nivel inferior delega a
una función de mayor aridad, que proporciona algunos argumentos predeterminados. Esto es lo que sucede en list ing 2.2, donde Rectangle.area / 1 delega a Rectangle.area / 2.
Veamos otro ejemplo.

```elixir
defmodule Calculator do
  def sum(a) do # Calculator.sum/1 delegates to Calculator.sum/2
    sum(a, 0)
  end

  def sum(a, b) do # Calculator.sum/2 contains the implementation
    a + b
  end
end
```

Una vez más, una función de aridad inferior se implementa en términos de una de aridad superior. Este patrón es tan frecuente que Elixir le permite especificar valores predeterminados para los argumentos usando el
`\\` operador seguido del valor predeterminado del argumento:

```elixir
defmodule Calculator do
  def sum(a, b \\ 0) do #  Defining a default value for argument b
    a + b
  end
end
```


Esta definición genera dos funciones exactamente como en el como vimos ahora.
Puede establecer los valores predeterminados para cualquier combinación de argumentos:

```elixir
defmodule MyModule do
  def fun(a, b \\ 1, c, d \\ 2) do #  Setting defaults for multiple arguments
    a + b + c + d
  end
end
```

Tenga siempre en cuenta que los valores predeterminados generan múltiples funciones con el mismo nombre
con diferentes aridades. El código anterior genera tres funciones: MyModule.fun/2,
MyModule.fun/3 y MyModule.fun/4.
Debido a que arity distingue varias funciones del mismo nombre, no es posible
hacer que una función acepte un número variable de argumentos. No hay contraparte de C's ...
o los argumentos de JavaScript.
