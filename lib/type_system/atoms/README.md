# Atoms

Los átomos son literalmente constantes, son similares a los symbolos en ruby. inician con dos puntos seguido de una combinación alfanumérica y underscore, y pueden tener espacios al usar comillas

```elixir
an_atom
:another_atom
:"an atom with spaces"
```

Un átomo consta de dos partes: el texto y el valor. El texto del átomo es lo que pones
después del carácter de dos puntos. En tiempo de ejecución, este texto se mantiene en la tabla de átomos. El valor es el
datos que entran en la variable, y es simplemente una referencia a la tabla de átomos.
Esta es exactamente la razón por la que los átomos se utilizan mejor para constantes con nombre. Son eficientes tanto
memoria y rendimiento. Cuando tu dices
`variable = :some_atom`
la variable no contiene todo el texto, sino solo una referencia a la tabla de átomos.
Por lo tanto, el consumo de memoria es bajo, las comparaciones son rápidas y el código sigue siendo
legible.

## Alias

Esta es una sintaxis para los atoms constant. puedes omitir los dos puntos y usar la primera letra en mayúscula

```elixir
:"Elixir.AnAtom":
AnAtom == :"Elixir.AnAtom" # => true
```

Cuando usa un alias, el compilador agrega implícitamente el Elixir. prefijo a su texto y
inserta un átomo allí. Pero si un alias ya contiene ese prefijo, no se agrega. En consecuencia, lo siguiente también funciona:

```elixir
AnAtom == Elixir.AnAtom # => true
```

Puede recordar de antes que también puede usar alias para dar nombres alternativos a
módulos:

```elixir
alias IO, as: MyIO
MyIO.puts("Hello!") #=> Hello!
```

No es casualidad que el término alias se utilice para ambas cosas. Cuando escribe alias IO,
como: `MyIO`, le indica al compilador que transforme `MyIO` en `IO`. Resolviendo esto aún más,
el resultado final emitido en el binario generado es: `Elixir.IO`. Por tanto, con un alias
configurado, lo siguiente también es válido:

```elixir
MyIO == Elixir.IO #=> true
```

Todo esto puede parecer extraño, pero tiene un propósito subyacente importante. Los alias admiten la resolución adecuada de los módulos. Esto se discutirá al final del capítulo.
cuando volvemos a visitar los módulos y observamos cómo se cargan en tiempo de ejecución

## Atomos como Booleanos

Puede resultar una sorpresa que Elixir no tenga un tipo booleano dedicado. En lugar de,
se utilizan los átomos `:true` y `:false`. Como azúcar sintáctico, Elixir le permite hacer referencia
estos átomos sin el carácter de dos puntos inicial:

```elixir
:true == true #=> true
:false == false #=> true
```

El término booleano todavía se usa en Elixir para denotar un átomo que tiene un valor de
`:true` o `false`. Los operadores lógicos estándar funcionan con átomos booleanos:

```elixir
true and false #=> false
false or true #=> true
not false #=> true

not :an_atom_other_than_true_or_false #=>  ** (ArgumentError) argument error
```

Siempre tenga en cuenta que un booleano es solo un átomo que tiene un valor de verdadero o falso.

## Nil and truthy values

Otro átomo especial es `:nil`, que funciona de forma algo similar a nulo en otros idiomas. Puede hacer referencia a `nil` sin dos puntos:

```elixir
nil == :nil #=> true
```

El átomo `nil` juega un papel en el soporte adicional de Elixir para la veracidad, que funciona de manera similar a la forma en que se usa en los lenguajes convencionales como C / C ++ y Ruby. Los átomos
`nil` y `false` se tratan como valores falsos, mientras que todo lo demás se trata como un valor verdadero.
valor.
Esta propiedad se puede utilizar con los operadores de short-circuit de Elixir `||`, `&&` y `!`.

El operador `||` devuelve la primera expresión que no es falsa:

```elixir
nil || false || 5 || true #=> 5
```

Debido a que tanto `nil` como `false` son expresiones falsas, se devuelve el número `5`. Aviso
que las expresiones posteriores no se evaluarán en absoluto. Si todas las expresiones se evalúan a
valor falso, se devuelve el resultado de la última expresión.

El operador`&&` devuelve la segunda expresión, pero solo si la primera expresión es
la verdad. De lo contrario, devuelve la primera expresión sin evaluar la segunda.

```elixir
true && 5 #=> 5
false && 5 5 #=> false
nil && 5 5 #=> nil
```

El short-circuit se puede utilizar para un elegante encadenamiento de operaciones. Por ejemplo, si necesita
para obtener un valor de la caché, un disco local o una base de datos remota, puede hacer algo
como esto:

```elixir
read_cached || read_from_disk || read_from_database
```

Similarly, you can use the operator `&&` to ensure that certain conditions are met:

```elixir
database_value = connection_established? && read_data
```

En ambos ejemplos, los operadores de short-circuit hacen posible escribir código conciso sin recurrir a construcciones condicionales anidadas complicadas.
