defmodule App.CompaniesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `App.Companies` context.
  """

  @doc """
  Generate a company.
  """
  def company_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        name: "some name",
        requires_tax_withholdings: true,
        tax_witholding_rate: 120.5
      })

    {:ok, company} = App.Companies.create_company(scope, attrs)
    company
  end
end
