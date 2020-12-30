defmodule SigninsheetWeb.Router do
  use SigninsheetWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {SigninsheetWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SigninsheetWeb do
    pipe_through :browser

#    live "/", PageLive, :index
    get "/", PageController, :index

    live "/reservations", ReservationLive.Index, :index
    live "/reservations/new", ReservationLive.Index, :new
    live "/reservations/:id/edit", ReservationLive.Index, :edit

    live "/reservations/:id", ReservationLive.Show, :show
    live "/reservations/:id/show/edit", ReservationLive.Show, :edit

  end

  # Other scopes may use custom stacks.
  # scope "/api", SigninsheetWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/watchdog", metrics: SigninsheetWeb.Telemetry
    end
  end
end
