defmodule ElixirInAction.Repo do
  use Ecto.Repo,
    otp_app: :elixir_in_action,
    adapter: Ecto.Adapters.Postgres
end
