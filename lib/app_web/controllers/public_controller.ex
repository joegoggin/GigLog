defmodule AppWeb.PublicController do
  use AppWeb, :controller

  alias App.Notifications.Notification

  def home(conn, _params) do
    notifications = [
      Notification.new(:info, "Info", "This is an info message."),
      Notification.new(:warning, "Warning", "This is a warning message."),
      Notification.new(:success, "Success", "This is a success message."),
      Notification.new(:error, "Error", "This is an error message.")
    ]

    conn
    |> put_flash(:notifications, notifications)
    |> render_inertia("Home")
  end
end
