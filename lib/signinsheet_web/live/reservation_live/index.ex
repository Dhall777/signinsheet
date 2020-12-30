defmodule SigninsheetWeb.ReservationLive.Index do
  use SigninsheetWeb, :live_view

  alias Signinsheet.Calendar
  alias Signinsheet.Calendar.Reservation

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :reservations, list_reservations())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Reservation")
    |> assign(:reservation, Calendar.get_reservation!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Reservation")
    |> assign(:reservation, %Reservation{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Reservations")
    |> assign(:reservation, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    reservation = Calendar.get_reservation!(id)
    {:ok, _} = Calendar.delete_reservation(reservation)

    {:noreply, assign(socket, :reservations, list_reservations())}
  end

  defp list_reservations do
    Calendar.list_reservations()
  end
end
