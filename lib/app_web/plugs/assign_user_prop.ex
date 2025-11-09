defmodule AppWeb.Plugs.AssignUserProp do
  use AppWeb, :controller

  alias App.Accounts.User

  def init(opts), do: opts

  def call(conn, _opts) do
    if conn.assigns.current_scope do
      user = conn.assigns.current_scope.user

      if user do
        user = User.to_json(user)

        conn
        |> assign_prop(:user, user)
      else
        conn
      end
    else
      conn
    end
  end
end
