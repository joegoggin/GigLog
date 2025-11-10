defmodule AppWeb.DashboardController do
  use AppWeb, :controller

  alias App.Accounts

  @doc """
    route: get /dashboard

    Renders dashboard page if `user.hashed_password` is set. Otherwise redirects
    to `/set-password`
  """
  def dashboard_page(conn, _params) do
    token = get_session(conn, :user_token)
    {user, _} = Accounts.get_user_by_session_token(token)

    if !user.hashed_password do
      conn
      |> redirect(to: ~p"/settings/set-password")
    else
      conn
      |> render_inertia("private/Dashboard")
    end
  end
end
