defmodule MedussaStudio.Repo do
  use Ecto.Repo,
    otp_app: :medussa_studio,
    adapter: Ecto.Adapters.Postgres
end
