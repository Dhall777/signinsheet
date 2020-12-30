defmodule Signinsheet.CalendarTest do
  use Signinsheet.DataCase

  alias Signinsheet.Calendar

  describe "reservations" do
    alias Signinsheet.Calendar.Reservation

    @valid_attrs %{comments: "some comments", date: ~D[2010-04-17], name: "some name", time_in: "some time_in", time_out: "some time_out"}
    @update_attrs %{comments: "some updated comments", date: ~D[2011-05-18], name: "some updated name", time_in: "some updated time_in", time_out: "some updated time_out"}
    @invalid_attrs %{comments: nil, date: nil, name: nil, time_in: nil, time_out: nil}

    def reservation_fixture(attrs \\ %{}) do
      {:ok, reservation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Calendar.create_reservation()

      reservation
    end

    test "list_reservations/0 returns all reservations" do
      reservation = reservation_fixture()
      assert Calendar.list_reservations() == [reservation]
    end

    test "get_reservation!/1 returns the reservation with given id" do
      reservation = reservation_fixture()
      assert Calendar.get_reservation!(reservation.id) == reservation
    end

    test "create_reservation/1 with valid data creates a reservation" do
      assert {:ok, %Reservation{} = reservation} = Calendar.create_reservation(@valid_attrs)
      assert reservation.comments == "some comments"
      assert reservation.date == ~D[2010-04-17]
      assert reservation.name == "some name"
      assert reservation.time_in == "some time_in"
      assert reservation.time_out == "some time_out"
    end

    test "create_reservation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Calendar.create_reservation(@invalid_attrs)
    end

    test "update_reservation/2 with valid data updates the reservation" do
      reservation = reservation_fixture()
      assert {:ok, %Reservation{} = reservation} = Calendar.update_reservation(reservation, @update_attrs)
      assert reservation.comments == "some updated comments"
      assert reservation.date == ~D[2011-05-18]
      assert reservation.name == "some updated name"
      assert reservation.time_in == "some updated time_in"
      assert reservation.time_out == "some updated time_out"
    end

    test "update_reservation/2 with invalid data returns error changeset" do
      reservation = reservation_fixture()
      assert {:error, %Ecto.Changeset{}} = Calendar.update_reservation(reservation, @invalid_attrs)
      assert reservation == Calendar.get_reservation!(reservation.id)
    end

    test "delete_reservation/1 deletes the reservation" do
      reservation = reservation_fixture()
      assert {:ok, %Reservation{}} = Calendar.delete_reservation(reservation)
      assert_raise Ecto.NoResultsError, fn -> Calendar.get_reservation!(reservation.id) end
    end

    test "change_reservation/1 returns a reservation changeset" do
      reservation = reservation_fixture()
      assert %Ecto.Changeset{} = Calendar.change_reservation(reservation)
    end
  end
end
