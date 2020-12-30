defmodule Signinsheet.Repo.Migrations.CreateReservations do
  use Ecto.Migration

  def change do
    create table(:reservations) do
      add :date, :date
      add :name, :string
      add :time_in, :string
      add :time_out, :string
      add :comments, :string

      timestamps()
    end

  end
end
