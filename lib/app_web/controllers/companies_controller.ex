defmodule AppWeb.CompaniesController do
  use AppWeb, :controller

  def companies_page(conn, _params) do
    conn
    |> render_inertia("companies/Companies")
  end
end
