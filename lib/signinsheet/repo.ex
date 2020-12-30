defmodule Signinsheet.Repo do
  use Ecto.Repo,
    otp_app: :signinsheet,
    adapter: Ecto.Adapters.Postgres
end
