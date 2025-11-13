defmodule App.Companies.Company do
  use Ecto.Schema
  import Ecto.Changeset

  alias App.Accounts
  alias App.Jobs

  schema "companies" do
    field(:name, :string)
    field(:requires_tax_withholdings, :boolean, default: false)
    field(:tax_withholding_rate, :float)

    belongs_to :user, Accounts.User
    has_many :jobs, Jobs.Job

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(company, attrs, user_scope) do
    company
    |> cast(attrs, [:name, :requires_tax_withholdings, :tax_withholding_rate])
    |> validate_required([:name, :requires_tax_withholdings])
    |> put_change(:user_id, user_scope.user.id)
  end
end
