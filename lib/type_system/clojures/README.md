# Clojures

Una lambda o función anónima puede referenciar cualquier variable fuera del scope

```elixir
outside_var = 5

my_lambda = fn ->
  IO.puts(outside_var) #  Lambda references a variable from the outside scope
end

my_lambda.() #=> 5
```

Siempre que tenga la referencia a `my_lambda`, la variable `outside_var` también es accesible. Esto también se conoce como `clojure`: al mantener una referencia a una lambda, indirectamente mantiene una referencia a todas las variables que utiliza, incluso si esas variables son de alcance externo.

Un clojure siempre captura una ubicación de memoria específica. Volver a vincular una variable no afectan a la lambda previamente definida que hace referencia al mismo nombre simbólico:

```elixir
outside_var = 5

my_lambda = fn ->
  IO.puts(outside_var) #  Lambda captures the current location of outside_var
end

my_lambda.()

outside_var = 6 # Proof that the closure isn’t affected

my_lambda.() #=> 5
```

El código anterior ilustra otro punto importante. Normalmente, después de tener rebote `outside_var` al valor 6, la ubicación de memoria original sería elegible
para recolección de basura. Pero debido a que la función lambda captura la ubicación original
(el que tiene el número 5), y todavía está haciendo referencia a ese lambda, la ubicación original no está disponible para la recolección de basura.
