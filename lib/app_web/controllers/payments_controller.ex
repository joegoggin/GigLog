defmodule AppWeb.PaymentsController do
  use AppWeb, :controller

  def payments_page(conn, _params) do
    conn
    |> render_inertia("payments/Payments")
  end
end
