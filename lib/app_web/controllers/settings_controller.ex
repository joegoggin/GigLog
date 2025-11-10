defmodule AppWeb.SettingsController do
  use AppWeb, :controller

  alias App.Accounts
  alias AppWeb.UserAuth

  @doc """
    route: /settings

    renders settings page
  """
  def settings_page(conn, _params) do
    conn
    |> render_inertia("settings/Settings")
  end

  @doc """
    route: get /settings/set-password

    Renders set password page
  """
  def set_password_page(conn, _params) do
    conn
    |> render_inertia("private/SetPassword")
  end

  @doc """
    route: post /settings/set-password

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
        |> redirect(to: ~p"/settings/set-password")
    end
  end
end
