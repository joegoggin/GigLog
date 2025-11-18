defmodule App.Companies.Company do
  use Ecto.Schema
  import Ecto.Changeset

  alias App.Companies.Company
  alias App.Accounts
  alias App.Jobs
  alias AppWeb.Utils.MapUtils

  schema "companies" do
    field(:name, :string)
    field(:requires_tax_withholdings, :boolean, default: false)
    field(:tax_withholding_rate, :float)

    belongs_to :user, Accounts.User
    has_many :jobs, Jobs.Job

    timestamps(type: :utc_datetime)
  end

  @doc """
  converts company into map with camel case keys to send to client 
  """
  def to_json(company) do
    company
    |> Map.take([:id, :name, :requires_tax_withholdings, :tax_withholding_rate])
    |> MapUtils.camelize()
    |> Map.new()
  end

  @doc """
  converts companies into list of maps with camel case keys to send to client
  """
  def copmanies_to_json(companies) do
    companies
    |> Enum.map(fn company -> Company.to_json(company) end)
  end

  @doc false
  def changeset(company, attrs, user_scope) do
    company
    |> cast(attrs, [:name, :requires_tax_withholdings, :tax_withholding_rate])
    |> validate_required([:name, :requires_tax_withholdings], message: "is required")
    |> validate_number(:tax_withholding_rate,
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 100
    )
    |> put_change(:user_id, user_scope.user.id)
  end
end
