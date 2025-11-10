defmodule AppWeb.PublicController do
  use AppWeb, :controller

  @doc """
    route: get /
    
    Renders home page
  """
  def home(conn, _params) do
    conn
    |> render_inertia("Home")
  end
end
