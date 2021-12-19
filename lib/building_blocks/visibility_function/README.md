# Function visibility

Cuando define una función usando la macro `def`, la función se hace pública: puede
ser llamado por cualquier otra persona. En terminología de Elixir, se dice que la función se exporta. Ustedes
también puede usar la macro `defp` para hacer que la función sea privada. Una función privada puede ser
se usa solo dentro del módulo en el que está definido. El siguiente ejemplo demuestra esto.


```elixir
defmodule TestPrivate do
  def double(a) do # Public function
    sum(a, a) # Calls private function
  end

  defp sum(a, b) do  #Private function
    a + b
  end
end
```

El módulo TestPrivate define dos funciones. La función double se exporta y
se puede llamar desde el exterior. Internamente, se basa en la suma de la función privada para hacer su
trabajo.

```elixir
TestPrivate.double(3) # => 6

TestPrivate.sum(3, 4) # => ** (UndefinedFunctionError) function TestPrivate.sum/2 ...
```

No puedes usar una función privada por fuera del módulo
