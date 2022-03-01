# Macros

Las macros son posiblemente una de las características más importantes que Elixir trae a la mesa, en comparación con Erlang. Permiten realizar potentes transformaciones de código en tiempo de compilación, lo que reduce el texto estándar y proporciona un elegante mini-DSL constructos. Las macros son un tema bastante complejo y se necesitaría un libro pequeño para tratarlas. extensamente. Debido a que este libro está más orientado hacia el tiempo de ejecución y BEAM, y las macros son una función algo avanzada que debe usarse con moderación, no proporcionaré una tratamiento detallado. Pero debería tener una idea general de cómo funcionan las macros porque muchas de las funciones de Elixir funcionan con ellos. Una macro consta de código Elixir que puede cambiar la semántica del código de entrada. A la macro siempre se llama en tiempo de compilación; recibe la representación analizada de la entrada Elixir code, y tiene la oportunidad de devolver una versión alternativa de ese código. Aclaremos esto con un ejemplo. a menos que (un equivalente de si no) sea un simple macro proporcionada por Elixir:

```elixir
unless some_expression do
  block_1
else
  block_2
end
```

`unless` no es una palabra clave especial. Es una macro (es decir, una función Elixir) que transforma el código de entrada en algo como esto:

```elixir
if some_expression do
 block_2
else
 block_1
end
```

Tal transformación no es posible con macros de estilo C, porque el código de la expresión puede ser arbitrariamente compleja y anidada entre paréntesis múltiples. Pero en Macros de Elixir (que están fuertemente inspiradas en Lisp), ya trabaja en una representación de origen, por lo que tendrá acceso a la expresión y a ambos bloques en variables separadas. El efecto final es que muchas partes de Elixir están escritas en Elixir con la ayuda de `macros`. Esto incluye las construcciones `unless` y `if`, y también `defmodule` y `def`. Mientras que otros idiomas suelen utilizar palabras clave para estas funciones, en Elixir se basan en un núcleo de lenguaje mucho más pequeño. El punto principal que se debe quitar los macros  transformadores de código en tiempo de compilación. Siempre que digo que algo es una macro, la implicación subyacente es que se ejecuta en tiempo de compilación y produce código alternativo.

Para obtener más detalles, es posible que desee consultar la guía oficial de metaprogramación (https: // elixir-lang.org/getting-started/meta/quote-and-unquote.html). Mientras tanto, hemos terminado
con nuestro recorrido inicial por el lenguaje Elixir. Pero antes de terminar este capítulo, deberíamos
discutir algunos aspectos importantes del tiempo de ejecución subyacente.
