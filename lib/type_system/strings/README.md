# Strings

Puede resultar una sorpresa, pero Elixir no tiene un tipo de string dedicado. En lugar de, Las cadenas se representan mediante un tipo binario o de lista.

```elixir
<<1::4, 15::4>> #=> <<31>>
```

## Binary strings

La manera más compun y conocida es usar commillas dobles en la sintaxis:

```elixir
"This is a string" #=> "This is a string"
```

El resultado se imprime como una cadena, pero debajo es un binario, nada más que un
secuencia consecutiva de bytes.
Elixir proporciona soporte para expresiones de cadena incrustadas. Puede utilizar `#{}` para colocar una
Expresión de elixir en una constante de cadena. La expresión se evalúa inmediatamente y su
La representación de cadena se coloca en la ubicación correspondiente en la cadena:

```elixir
"Embedded expression: #{3 + 0.14}" #=> "Embedded expression: 3.14"
```

Classical \ escaping works:

```elixir
"\r \n \" \\"
```

Y las cadenas no tienen que terminar en la misma línea:

```elixir
"
This is
a multiline string
"
```

Elixir proporciona otra sintaxis para declarar cadenas, los llamados sigils. En este enfoque,
encierra la cadena dentro de `~s()`:

```elixir
~s(This is also a string) #=> "This is also a string"
```

se pueden usar para incluir comillas en un string

```elixir
~s("Do... or do not. There is no try." -Master Yoda) #=>"\"Do... or do not. There is no try.\" -Master Yoda"
```

También hay una versión en mayúsculas `~S` que no maneja interpolación o caracteres de escape `(\)`:

```elixir
~S(Not interpolated #{3 + 0.14}) #=> "Not interpolated \#{3 + 0.14}"

~S(Not escaped \n) #=> "Not escaped \\n"
```

Por último, hay una sintaxis heredocs especial, que admite un mejor formato para multilínea
instrumentos de cuerda. Las cadenas de Heredocs comienzan con una comilla doble triple. El final triple comilla doble
debe estar en su propia línea:

```elixir
"""
Heredoc must end on its own line """
""" #=> "Heredoc must end on its own line \"\"\"\n"
```

Debido a que las cadenas son binarios, puede concatenarlas con el operador `<>`:

```elixir
"String" <> " " <> "concatenation" #=> "String concatenation"
```

Many helper functions are available for working with binary strings. Most of them 
reside in the String module (https://hexdocs.pm/elixir/String.html).


## Character lists

La forma alternativa de representar cadenas es utilizar la sintaxis de comillas simples:

```elixir
'ABC' #=> 'ABC'
```

Esto crea una lista de caracteres, que es esencialmente una lista de enteros en la que cada elemento
representa un solo carácter.
El resultado anterior es exactamente el mismo que si construyera manualmente la lista de números enteros:

```elixir
[65, 66, 67] #=> 'ABC'
```

Como puede ver, incluso el tiempo de ejecución no distingue entre una lista de enteros y una
lista de caracteres. Cuando una lista consta de números enteros que representan caracteres imprimibles, es
impreso en la pantalla en forma de cadena.
Al igual que con las cadenas binarias, existen contrapartes de sintaxis para varias definiciones de
listas de caracteres:

```elixir
'Interpolation: #{3 + 0.14}' #=> 'Interpolation: 3.14'
~c(Character list sigil) # => 'Character list sigil'
~C(Unescaped sigil #{3 + 0.14}) #=> 'Unescaped sigil \#{3 + 0.14}'

'''
Heredoc
''' #=> 'Heredoc\n'
```

Las listas de caracteres no son compatibles con cadenas binarias. La mayoría de las operaciones del
El módulo de cadenas no funcionará con listas de caracteres. En general, deberías preferir binario
cadenas sobre listas de caracteres. Ocasionalmente, algunas funciones pueden funcionar solo con caracteres
liza. Esto sucede principalmente con las bibliotecas de Erlang puras. En este caso, puede convertir un
cadena binaria a una versión de lista de caracteres usando la función `String.to_charlist/1`:

```elixir
String.to_charlist("ABC") #=> 'ABC'
```

Para convertir una lista de caracteres en una cadena binaria, puede usar `List.to_string/1`.
En general, debe preferir las cadenas binarias tanto como sea posible, utilizando listas de caracteres
solo cuando alguna biblioteca de terceros (la mayoría de las veces escrita en Erlang puro) lo requiera

