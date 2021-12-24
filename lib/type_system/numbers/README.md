# Numbers

pueden ser enteros y flotantes

```elixir
3 # => Integer
0xFF # => Integer  written in hex
3.14 # => Float
1.0e-2 # => Float, exponential notation
```

También permite realizar operaciones standar

```elixir
1 + 2 * 3 # => 7
4/2 # => 2.0
```

También podemos importar funciones del auto-imported de kernel functions:

```elixir
div(5,2) # => 2
 rem(5,2) # => 1
```

También tienen syntactic sugar, usando underscore podemos tener delimitadores de
manera visual

```elixir
1_000_000 # => 1000000
```


No existe un límite superior para el tamaño de un número entero y puede usar
números arbitrariamente grandes:

```elixir
999999999999999999999999999999999999999999999999999999999999 # => 999999999999999999999999999999999999999999999999999999999999
```
