defmodule AppWeb.PrivateController do
  use AppWeb, :controller

  alias AppWeb.UserAuth
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
      |> redirect(to: ~p"/set-password")
    else
      conn
      |> render_inertia("private/Dashboard")
    end
  end

  @doc """
    route: get /set-password

    Renders set password page
  """
  def set_password_page(conn, _params) do
    conn
    |> render_inertia("private/SetPassword")
  end

  @doc """
    route: post /set-password

    Attempts to set password. If successful the user is relogged in and
    redirected to `/dashboard`. 
  """
  def set_password(conn, params) do
    user = conn.assigns.current_scope.user

    case Accounts.update_user_password(user, params) do
      {:ok, {user, _}} ->
        conn
        |> UserAuth.log_in_user(user)
        |> redirect(to: ~p"/dashboard")

      {:error, changeset} ->
        conn
        |> assign_errors(changeset)
        |> redirect(to: ~p"/set-password")
    end
  end

  @doc """
    route: delete /auth/log-out

    Logs out user
  """
  def log_out(conn, _params) do
    conn
    |> UserAuth.log_out_user()
  end
end
