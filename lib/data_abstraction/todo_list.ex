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
