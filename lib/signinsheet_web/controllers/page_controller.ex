defmodule SigninsheetWeb.PageController do
  use SigninsheetWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
