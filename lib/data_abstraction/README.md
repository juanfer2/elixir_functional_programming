# Data Abstraction
 
Podemos usar un modulo con distintos comportamientos y llamar sus funciones en otro módulo

```elixir
defmodule MultiDict do
  def new(), do: %{}

  def add(dict, key, value) do
    Map.update(dict, key, [value], &[value | &1])
  end

  def get(dict, key) do
    Map.get(dict, key, [])
  end
end

defmodule TodoList do
  alias MultiDict

  def new(), do: MultiDict.new()

  def add_entry(todo_list, date, title) do
    # Map.update(
    #   todo_list,
    #   date,
    #   [title],
    #   fn titles -> [title | titles] end
    # )
    MultiDict.add(todo_list, date, title)
  end

  def entries(todo_list, date) do
    #Map.get(todo_list, date, [])
    MultiDict.get(todo_list, date)
  end
end

```

## Structs

Los Structs son mapas pero tienen un trato especial como por ejemplo no pueden ser usados en el módulo
Enum


```elixir
defmodule Fraction do
  defstruct a: nil, b: nil
end

f = %Fraction{a: 1, b: 2}
#=> %Fraction{a: 1, b: 2}
f |> 
Map.get(:a)
Map.get(f, :a)
#=> 1

#Updates
one_quarter = %Fraction{f | b: 4}
#=> %Fraction{a: 1, b: 4}
```

