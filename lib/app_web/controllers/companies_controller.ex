defmodule AppWeb.CompaniesController do
  use AppWeb, :controller

  alias App.Notifications.Notification
  alias App.Companies
  alias AppWeb.Utils.StringUtils

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

  def delete_company(conn, %{
        "company_id" => company_id,
        "prompt_user" => prompt_user
      }) do
    prompt_user = StringUtils.to_boolean(prompt_user)
    scope = conn.assigns.current_scope

    case Companies.get_company(scope, company_id) do
      {:ok, company} ->
        if prompt_user do
          conn
          |> put_delete_modal(company)
          |> redirect(to: ~p"/companies")
        else
          case Companies.delete_company(scope, company) do
            {:ok, company} ->
              companies = Companies.list_companies(scope)

              conn
              |> put_delete_successful_notification(company)
              |> assign_prop(:companies, companies)
              |> redirect(to: ~p"/companies")

            {:error, _} ->
              conn
              |> put_something_went_wrong_notification()
              |> redirect(to: ~p"/companies")
          end
        end

      {:error, error_message} ->
        conn
        |> put_not_found_notification(error_message)
        |> redirect(to: ~p"/companies")
    end
  end

  defp put_delete_modal(conn, company) do
    modal = %{
      delete: %{
        id: company.id,
        name: company.name,
        table: "Copmany",
        relatedTables: ["Jobs", "Payments", "Work Sessions"]
      }
    }

    conn
    |> put_flash(:modal, modal)
  end

  defp put_not_found_notification(conn, error_message) do
    notifications = [Notification.new(:error, "Not Found", error_message)]

    conn
    |> put_flash(:notifications, notifications)
  end

  defp put_delete_successful_notification(conn, company) do
    notifications = [
      Notification.new(
        :success,
        "Company Deleted",
        "#{company.name} was successfully deleted."
      )
    ]

    conn
    |> put_flash(:notifications, notifications)
  end

  defp put_something_went_wrong_notification(conn) do
    notifications = [
      Notification.new(:error, "Delete Failed", "Somthing went wrong please try again.")
    ]

    conn
    |> put_flash(:notifications, notifications)
  end

  def create_company_page(conn, _params) do
    conn
    |> render_inertia("companies/CreateCompany")
  end

  def create_company(
        conn,
        %{
          "requires_tax_withholdings" => requires_tax_withholdings
        } = params
      ) do
    scope = conn.assigns.current_scope

    attrs =
      if requires_tax_withholdings do
        params
      else
        params
        |> Map.take(["name", "requires_tax_withholdings"])
        |> Map.put("tax_withholding_rate", 0)
      end

    dbg(attrs)

    case Companies.create_company(scope, attrs) do
      {:ok, company} ->
        notifications = [
          Notification.new(
            :success,
            "Copmany Created",
            "A company named #{company.name} was successfully created"
          )
        ]

        conn
        |> put_flash(:notifications, notifications)
        |> redirect(to: ~p"/companies/create")

      {:error, changeset} ->
        conn
        |> assign_errors(changeset)
        |> redirect(to: ~p"/companies/create")
    end
  end
end
