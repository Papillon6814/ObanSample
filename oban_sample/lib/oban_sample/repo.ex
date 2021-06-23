defmodule ObanSample.Repo do
  use Ecto.Repo,
    otp_app: :oban_sample,
    adapter: Ecto.Adapters.Postgres
end
