defmodule Checker.Repo do
  use Ecto.Repo,
    otp_app: :checker,
    adapter: Ecto.Adapters.Postgres
end
