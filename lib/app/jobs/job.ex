defmodule App.Jobs.Job do
  use Ecto.Schema
  import Ecto.Changeset

  alias App.Payments
  alias App.Accounts
  alias App.Companies

  schema "jobs" do
    field :title, :string
    field :payment_type, Ecto.Enum, values: [:hourly, :payouts]
    field :number_of_payouts, :integer
    field :payout_amount, :decimal
    field :hourly_rate, :decimal

    belongs_to :company, Companies.Company
    belongs_to :user, Accounts.User
    has_many :payments, Payments.Payment

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(job, attrs, user_scope) do
    job
    |> cast(attrs, [:title, :payment_type, :number_of_payouts, :payout_amount, :hourly_rate])
    |> validate_required([
      :title,
      :payment_type,
      :number_of_payouts,
      :payout_amount,
      :hourly_rate
    ])
    |> put_change(:user_id, user_scope.user.id)
  end
end
