defmodule Signinsheet.Calendar.Reservation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reservations" do
    field :comments, :string
    field :date, :date
    field :name, :string
    field :time_in, :string
    field :time_out, :string

    timestamps()
  end

  @doc false
  def changeset(reservation, attrs) do
    reservation
    |> cast(attrs, [:date, :name, :time_in, :time_out, :comments])
    |> validate_required([:date, :name, :time_in, :time_out, :comments])
  end
end
