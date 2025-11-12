defmodule App.Companies.Company do
  use Ecto.Schema
  import Ecto.Changeset

  alias App.Accounts

  schema "companies" do
    field(:name, :string)
    field(:requires_tax_withholdings, :boolean, default: false)
    field(:tax_witholding_rate, :float)
    belongs_to :user, Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(company, attrs, user_scope) do
    company
    |> cast(attrs, [:name, :requires_tax_withholdings, :tax_witholding_rate])
    |> validate_required([:name, :requires_tax_withholdings, :tax_witholding_rate])
    |> put_change(:user_id, user_scope.user.id)
  end
end
