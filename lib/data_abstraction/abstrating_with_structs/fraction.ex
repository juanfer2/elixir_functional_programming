defmodule Fraction do
  defstruct a: nil, b: nil
end

# f = %Fraction{a: 1, b: 2}
# f |> Map.get(:a)
# Map.get(f, :a)

#Updates
# one_quarter = %Fraction{f | b: 4}
