# Modules

Un módulo es una colección de funciones, todas las funciones en elixir deben definirse dentro de un módulo.
```elixir
defmodule Geometry do # Starts a module definitio
  def rectangle_area(a, b) do # Function definition
    a * b
  end
end
```

example use:

```elixir
Geometry.rectangle_are(6, 7) # => 42 
```

En el código fuente, un módulo puede ser definido en un simple archivo y un archivo puede contener múltiples definiciones de módulos

```elixir
defmodule Module1 do
  ...
end

defmodule Module2 do
  ...
end
```
El nombre de los módulos pueden tener ciertas reglas. Estos se puede iniciar a nombrar con Una letra mayúscula con un estilo de CamelCase. El nombre también puede contener números, underscores y el caracter punto. esto a menudo es usado para organizar módulos de manera jeraquica

```elixir
defmodule Geometry.Rectangle do
  ...
end

defmodule Geometry.Cirlce do
  ...
end
```

El caracter punto es solo una convención una ves que el código es compilado no hay una relación de jerarquia especial entre los módulos, tampoco existen servicios para consultar la jerarquia,es simplemente syntactic sugar que nos ayuda a nombar los módulos.
También podemos anidar módulos
```elixir
defmodule Geometry do
  defmodule Rectangle do
    ...
  end
end
```

los módulos anidados pueden referenciarse con `Geomtry.Rectangle` (otra ves). Esto es solo una convención al compilarse no ocurre nada especial en los módulos anidados `Geometry` o `Geometry.Rectangle`

nota: una convensión común para los archivos elixir en la extension `.ex`

Elixir provee una libreria standar con muchos módulos útiles. por ejemplo IO module que puede ser usado con para varios operaciones I/O.

