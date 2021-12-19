# Function visibility

Llamar a funciones desde otro módulo a veces puede resultar engorroso porque
Necesito hacer referencia al nombre del módulo. Si su módulo a menudo llama a funciones de otro
módulo, puede importar ese otro módulo al suyo. Importar un módulo permite
que llame a sus funciones públicas sin prefijarlas con el nombre del módulo:

```elixir
defmodule MyModule do
  import IO # Imports the module

  def my_function do
    puts "Calling imported function" # You can use puts instead of IO.puts
  end
end
```

Por supuesto, puede importar varios módulos. De hecho, el Kernel de la biblioteca estándar
El módulo se importa automáticamente en cada módulo. Kernel contiene funciones que
se utilizan a menudo, por lo que la importación automática facilita su uso.

- NOTA Puede ver qué funciones están disponibles en el módulo Kernel consultando la documentación en línea en https://hexdocs.pm/elixir/Kernel.html.

Otro constructo, `alias`, hace posible hacer referencia a un módulo bajo una diferente
nombre:

```elixir
defmodule MyModule do
  alias IO, as: MyIO #Creates an alias for IO

  def my_function do
    MyIO.puts(("Calling imported function.") #Calls a function using the alias
  end
end
```

Los alias pueden resultar útiles si un módulo tiene un nombre largo. Por ejemplo, si su aplicación es muy
dividido en una jerarquía de módulos más profunda, puede resultar engorroso hacer referencia a los módulos a través de
nombres totalmente calificados. Los alias pueden ayudar con esto. Por ejemplo, supongamos que tiene una geometría
.Módulo rectangular. Puede usar un alias en su módulo de cliente y usar un nombre más corto:

```elixir
defmodule MyModule do
  alias Geometry.Rectangle, as: Rectangle # Sets up an alias to a module

  def my_function do
    Rectangle.area(...) # Calls a module function using the alias
  end
end
```


En el ejemplo anterior, el alias de Geometry.Rectangle es la última parte de su nombre.
Este es el uso más común de alias, por lo que Elixir le permite omitir la opción as en este caso:

```elixir
defmodule MyModule do
  alias Geometry.Rectangle

  def my_function do
    Rectangle.area(...)
  end
end
```
