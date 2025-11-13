defmodule App.CompaniesTest do
  use App.DataCase

  alias App.Companies

  describe "companies" do
    alias App.Companies.Company

    import App.AccountsFixtures, only: [user_scope_fixture: 0]
    import App.CompaniesFixtures

    @invalid_attrs %{name: nil, requires_tax_withholdings: nil, tax_withholding_rate: nil}

    test "list_companies/1 returns all scoped companies" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      company = company_fixture(scope)
      other_company = company_fixture(other_scope)
      assert Companies.list_companies(scope) == [company]
      assert Companies.list_companies(other_scope) == [other_company]
    end

    test "get_company!/2 returns the company with given id" do
      scope = user_scope_fixture()
      company = company_fixture(scope)
      other_scope = user_scope_fixture()
      assert Companies.get_company!(scope, company.id) == company
      assert_raise Ecto.NoResultsError, fn -> Companies.get_company!(other_scope, company.id) end
    end

    test "create_company/2 with valid data creates a company" do
      valid_attrs = %{
        name: "some name",
        requires_tax_withholdings: true,
        tax_witholding_rate: 120.5
      }

      scope = user_scope_fixture()

      assert {:ok, %Company{} = company} = Companies.create_company(scope, valid_attrs)
      assert company.name == "some name"
      assert company.requires_tax_withholdings == true
      assert company.tax_witholding_rate == 120.5
      assert company.user_id == scope.user.id
    end

    test "create_company/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Companies.create_company(scope, @invalid_attrs)
    end

    test "update_company/3 with valid data updates the company" do
      scope = user_scope_fixture()
      company = company_fixture(scope)

      update_attrs = %{
        name: "some updated name",
        requires_tax_withholdings: false,
        tax_witholding_rate: 456.7
      }

      assert {:ok, %Company{} = company} = Companies.update_company(scope, company, update_attrs)
      assert company.name == "some updated name"
      assert company.requires_tax_withholdings == false
      assert company.tax_witholding_rate == 456.7
    end

    test "update_company/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      company = company_fixture(scope)

      assert_raise MatchError, fn ->
        Companies.update_company(other_scope, company, %{})
      end
    end

    test "update_company/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      company = company_fixture(scope)

      assert {:error, %Ecto.Changeset{}} =
               Companies.update_company(scope, company, @invalid_attrs)

      assert company == Companies.get_company!(scope, company.id)
    end

    test "delete_company/2 deletes the company" do
      scope = user_scope_fixture()
      company = company_fixture(scope)
      assert {:ok, %Company{}} = Companies.delete_company(scope, company)
      assert_raise Ecto.NoResultsError, fn -> Companies.get_company!(scope, company.id) end
    end

    test "delete_company/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      company = company_fixture(scope)
      assert_raise MatchError, fn -> Companies.delete_company(other_scope, company) end
    end

    test "change_company/2 returns a company changeset" do
      scope = user_scope_fixture()
      company = company_fixture(scope)
      assert %Ecto.Changeset{} = Companies.change_company(scope, company)
    end
  end
end
