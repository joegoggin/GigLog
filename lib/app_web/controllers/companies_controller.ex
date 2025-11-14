defmodule AppWeb.CompaniesController do
  use AppWeb, :controller

  alias App.Notifications.Notification
  alias App.Companies

  def companies_page(conn, _params) do
    scope = conn.assigns.current_scope
    companies = Companies.list_companies(scope)

    conn
    |> assign_prop(:companies, companies)
    |> render_inertia("companies/Companies")
  end

  def view_company_page(conn, _params) do
    conn
    |> render_inertia("companies/Company")
  end

  def delete_company(conn, _params) do
    notifications = [
      Notification.new(
        :info,
        "delete /companies was called",
        "Remember to actually implement delete logic later"
      )
    ]

    conn
    |> put_flash(:notifications, notifications)
    |> redirect(to: ~p"/companies")
  end
end
