# immutability

Como se mencionó anteriormente, los datos de Elixir no se pueden modificar. Cada función regresa
la nueva versión modificada de los datos de entrada. Tienes que llevar la nueva versión a
otra variable o volver a vincularla con el mismo nombre simbólico. En cualquier caso, el resultado reside
en otra ubicación de la memoria. La modificación de la entrada dará como resultado algunos datos
copiando, pero en general, la mayor parte de la memoria se compartirá entre el antiguo y el nuevo
versión.

## Modificar tuplas

```elixir
a_tuple = {a, b, c}
new_tuple = put_elem(a_tuple, 1, b2)
```

La variable new_tuple contendrá una copia superficial de a_tuple, diferenciándose solo en el segundo elemento, como se ilustra en la figura 2.2.
Ambas tuplas hacen referencia a las variables a y c,
y lo que sea que haya en esas variables se comparte
(y no duplicado) entre ambas tuplas.
new_tuple es una copia superficial del original
a_tuple.
¿Qué sucede si vuelve a vincular una variable?
En este caso, después de volver a enlazar, la variable
a_tuple hace referencia a otra ubicación de memoria. La antigua ubicación de a_tuple no es accesible y está disponible para la recolección de basura.

![image](https://user-images.githubusercontent.com/64051193/147372980-f766d78e-c182-40f3-9bc1-645c329a5949.png)


Lo mismo ocurre con la variable b a la que hace referencia la versión anterior de la tupla, como se ilustra en:

![image](https://user-images.githubusercontent.com/64051193/147373017-fcb3fe71-34f4-433d-9cfd-8e633732ffa9.png)

Tenga en cuenta que las tuplas siempre se copian, pero la copia es poco profunda. Listas, sin embargo,
tienen diferentes propiedades.

## Modificar listas

Cuando modifica el enésimo elemento de una lista, la nueva versión contendrá copias superficiales
de los primeros n - 1 elementos, seguidos del elemento modificado. Después de eso, las colas son
completamente compartidas, como se ilustra imagen.

![image](https://user-images.githubusercontent.com/64051193/147373051-c54f51b6-be20-48cf-86dc-ea3a1efe9f31.png)


Esta es precisamente la razón por la que agregar elementos al final de una lista es costoso. Para agregar un
nuevo elemento en la cola, debe iterar y (profundisar) para copiar toda la lista.
Por el contrario, colocar un elemento en la parte superior de una lista no copia nada, lo que
hace que sea la operación menos costosa, como se ilustra en en la imagen. 

![image](https://user-images.githubusercontent.com/64051193/147373058-2f6dff11-bf1b-4b91-b1b3-d63b629b5aec.png)

En este caso, el nuevo
la cola de la lista es la lista anterior. Esto se usa a menudo en los programas Elixir cuando se crean listas de manera iterativa. En tales casos, es mejor colocar elementos consecutivos en la parte superior y luego, después
la lista está construida, invierta la lista completa en una sola pasada.

## Beneficios

La inmutabilidad puede parecer extraña y quizás te preguntes cuál es su propósito. Hay dos
Beneficios importantes de la inmutabilidad: 

- Funciones sin efectos secundarios
- Consistencia de datos

Funciones sin efectos secundarios y consistencia de datos.
Dado que los datos no se pueden modificar, puede tratar la mayoría de las funciones como libres de efectos secundarios
transformaciones. Toman una entrada y devuelven un resultado. Programas más complicados se escriben combinando transformaciones más simples:

```elixir
def complex_transformation(data) do
  data
  |> transformation_1(...)
  |> transformation_2(...)
  ...
  |> transformation_n(...)
end
```

Este código se basa en el operador pipeline `|>` mencionado anteriormente que encadena functiones alimentando el resultado de la llamada anterior como el primer argumento de la siguiente llamada.
Las funciones sin efectos secundarios son más fáciles de analizar, comprender y probar. Ellos tienen
Entradas y salidas bien definidas. Cuando llama a una función, puede estar seguro de que no se cambiará implícitamente ninguna variable. Haga lo que haga la función, debe tomar su resultado y hacer algo con él.

- NOTA Elixir no es un lenguaje funcional puro, por lo que las funciones aún pueden tener efectos secundarios. Por ejemplo, una función puede escribir algo en un archivo y emitir una base de datos o una llamada de red, lo que provoca que produzca un efecto secundario. Pero puedes estar seguro de que una función no modificará el valor de ninguna variable.

La consecuencia implícita de los datos inmutables es la capacidad de contener todas las versiones de un dato  estructura en el programa. Esto, a su vez, hace posible realizar en memoria atómica operaciones. Supongamos que tiene una función que realiza una serie de transformaciones:

```elixir
def complex_transformation(original_data) do
  original_data
  |> transformation_1(...)
  |> transformation_2(...)
  ...
end
```

Este código comienza con los datos originales y los pasa a través de una serie de transformaciones, cada una de las cuales devuelve la versión nueva y modificada de la entrada. Si algo va incorrecto, la función complex_transformation puede devolver `original_data`, que
efectivamente revertirá todas las transformaciones realizadas en la función. Esta
es posible porque ninguna de las transformaciones modifica la memoria ocupada por datos originales. Con esto concluye nuestra mirada a la teoría básica de la inmutabilidad. Puede que todavía no esté claro cómo utilizar correctamente datos inmutables en programas más complejos. Este tema será revisado en el capítulo 4, donde trataremos las estructuras de datos de nivel superior
