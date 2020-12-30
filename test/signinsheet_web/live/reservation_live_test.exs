defmodule SigninsheetWeb.ReservationLiveTest do
  use SigninsheetWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Signinsheet.Calendar

  @create_attrs %{comments: "some comments", date: ~D[2010-04-17], name: "some name", time_in: "some time_in", time_out: "some time_out"}
  @update_attrs %{comments: "some updated comments", date: ~D[2011-05-18], name: "some updated name", time_in: "some updated time_in", time_out: "some updated time_out"}
  @invalid_attrs %{comments: nil, date: nil, name: nil, time_in: nil, time_out: nil}

  defp fixture(:reservation) do
    {:ok, reservation} = Calendar.create_reservation(@create_attrs)
    reservation
  end

  defp create_reservation(_) do
    reservation = fixture(:reservation)
    %{reservation: reservation}
  end

  describe "Index" do
    setup [:create_reservation]

    test "lists all reservations", %{conn: conn, reservation: reservation} do
      {:ok, _index_live, html} = live(conn, Routes.reservation_index_path(conn, :index))

      assert html =~ "Listing Reservations"
      assert html =~ reservation.comments
    end

    test "saves new reservation", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.reservation_index_path(conn, :index))

      assert index_live |> element("a", "New Reservation") |> render_click() =~
               "New Reservation"

      assert_patch(index_live, Routes.reservation_index_path(conn, :new))

      assert index_live
             |> form("#reservation-form", reservation: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#reservation-form", reservation: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.reservation_index_path(conn, :index))

      assert html =~ "Reservation created successfully"
      assert html =~ "some comments"
    end

    test "updates reservation in listing", %{conn: conn, reservation: reservation} do
      {:ok, index_live, _html} = live(conn, Routes.reservation_index_path(conn, :index))

      assert index_live |> element("#reservation-#{reservation.id} a", "Edit") |> render_click() =~
               "Edit Reservation"

      assert_patch(index_live, Routes.reservation_index_path(conn, :edit, reservation))

      assert index_live
             |> form("#reservation-form", reservation: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#reservation-form", reservation: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.reservation_index_path(conn, :index))

      assert html =~ "Reservation updated successfully"
      assert html =~ "some updated comments"
    end

    test "deletes reservation in listing", %{conn: conn, reservation: reservation} do
      {:ok, index_live, _html} = live(conn, Routes.reservation_index_path(conn, :index))

      assert index_live |> element("#reservation-#{reservation.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#reservation-#{reservation.id}")
    end
  end

  describe "Show" do
    setup [:create_reservation]

    test "displays reservation", %{conn: conn, reservation: reservation} do
      {:ok, _show_live, html} = live(conn, Routes.reservation_show_path(conn, :show, reservation))

      assert html =~ "Show Reservation"
      assert html =~ reservation.comments
    end

    test "updates reservation within modal", %{conn: conn, reservation: reservation} do
      {:ok, show_live, _html} = live(conn, Routes.reservation_show_path(conn, :show, reservation))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Reservation"

      assert_patch(show_live, Routes.reservation_show_path(conn, :edit, reservation))

      assert show_live
             |> form("#reservation-form", reservation: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#reservation-form", reservation: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.reservation_show_path(conn, :show, reservation))

      assert html =~ "Reservation updated successfully"
      assert html =~ "some updated comments"
    end
  end
end
