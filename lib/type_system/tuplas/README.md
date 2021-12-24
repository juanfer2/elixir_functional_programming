# Tuplas

Las tuplas son algo así como una structura sin tipado o registros
se utilizan con mayor frequencia para agrupar un número fijo de elementos
El siguiente fragmento define una tupla
que consiste en el nombre de una persona y eda

```elixir
person = {"Bob", 25} #=> {"Bob", 25}
```

Para extraer un elemento de la tupla, puede utilizar la función `Kernel.elem/2`, que
acepta una tupla y el índice de base cero del elemento. Recuerde que el módulo Kernel se importa automáticamente, por lo que puede llamar a `elem` en lugar de `Kernel.elem`


```elixir
age = elem(person, 1) #=> 25
```

para modifica un elemento de una tupla podemos usar `Kernel.put_elem/3`, que acepta una tupla, un índice de base cero y el nuevo valor del campo en el
posición:

```elixir
put_elem(person, 1, 26) #=> 26
put_elem(person, 0, "Jhon") #=> Jhon
```
La función `put_elem` no modifica la tupla. Devuelve la nueva versión, manteniendo
el viejo intacto. Recuerde que los datos en Elixir son inmutables, por lo que no puede hacer un in-memory
modificación de un valor. Puede verificar que la llamada anterior a put_elem no cambió
la variable persona

```elixir
person #=> {"Bob", 25}
older_person = put_elem(person, 1, 26) #=> {"Bob", 26}
```

Recuerde que las variables se pueden rebotar, por lo que también puede hacer lo siguiente:

```elixir
person = put_elem(person, 1, 26) #=> {"Bob", 26}
```


Al hacer esto, ha recuperado efectivamente la variable de persona a la nueva ubicación de memoria. La ubicación anterior no está referenciada por ninguna otra variable, por lo que es elegible para la basura
colección.

- NOTA Puede que se pregunte si este enfoque es eficiente en la memoria. En la mayoría de los casos,
Habrá poca copia de datos y las dos variables compartirán tanta memoria como sea posible. Esto se explicará más adelante en esta sección, cuando analicemos
inmutabilidad.

Las tuplas son las más apropiadas para agrupar un número pequeño y fijo de elementos.
Cuando necesite una colección de tamaño dinámico, puede utilizar listas.
