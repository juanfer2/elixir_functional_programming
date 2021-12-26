# Binaries and bitstrings

Un binario es un fragmento de bytes. Puede crear binarios adjuntando la secuencia de bytes
entre los operadores `<< y >>`. El siguiente fragmento crea un binario de 3 bytes:


```elixir
<<1, 2, 3>> #=> <<1, 2, 3>>
```

Cada número representa el valor del byte correspondiente. Si proporciona un byte
valor mayor que 255, se trunca al tamaño del byte:

```elixir
<<256>> #=> <<0>>
<<257>> #=> <<1>>
<<512>> #=> <<0>>
```

Puede especificar el tamaño de cada valor y así decirle al compilador cuántos bits utilizar
por ese valor en particular:

```elixir
<<257::16>> #=> <<1, 1>>
```

Esta expresión coloca el número 257 en 16 bits de espacio de memoria consecutiva. El
La salida indica que usa 2 bytes, ambos con un valor de 1. Esto se debe al binario
representación de 257, que en formato de 16 bits se escribe 00000001 00000001.
El especificador de tamaño está en bits y no es necesario que sea un multiplicador de 8. El siguiente fragmento
crea un binario combinando dos valores de 4 bits:

```elixir
<<1::4, 15::4>> #=> <<31>>
```

El valor resultante tiene 1 byte y se representa en la salida utilizando el valor normalizado
formulario 31 (0001 1111).
Si el tamaño total de todos los valores no es un múltiplo de 8, el binario se llama cadena de bits, una
secuencia de bits:

```elixir
<<1::1, 0::1, 1::1>> #=> <<5::size(3)>>
```

También puede concatenar dos binarios o cadenas de bits con el operador <>:

```elixir
<<1, 2>> <> <<3, 4>> #=> <<1
```

Hay mucho más que se puede hacer con los binarios, pero por el momento los colocaremos
aparte. Lo más importante que debe saber sobre los binarios es que son secuencias consecutivas de bytes. Los binarios juegan un papel importante en el soporte de cadenas.
