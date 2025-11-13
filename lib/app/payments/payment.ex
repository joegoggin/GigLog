defmodule App.Payments.Payment do
  use Ecto.Schema
  import Ecto.Changeset

  alias App.Accounts
  alias App.Jobs

  schema "payments" do
    field :total, :decimal

    field :payout_type, Ecto.Enum,
      values: [:paypal, :cash, :check, :zelle, :venmo, :direct_deposit]

    field :expected_payout_date, :date
    field :expected_transfer_date, :date
    field :transfer_initiated, :boolean, default: false
    field :payment_received, :boolean, default: false
    field :transfer_received, :boolean, default: false
    field :tax_withholdings_covered, :boolean, default: false

    belongs_to :job, Jobs.Job
    belongs_to :user, Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(payment, attrs, user_scope) do
    payment
    |> cast(attrs, [
      :total,
      :payout_type,
      :expected_payout_date,
      :expected_transfer_date,
      :transfer_initiated,
      :payment_received,
      :transfer_received,
      :tax_withholdings_covered
    ])
    |> validate_required([
      :total,
      :payout_type,
      :expected_payout_date,
      :expected_transfer_date,
      :transfer_initiated,
      :payment_received,
      :transfer_received,
      :tax_withholdings_covered
    ])
    |> put_change(:user_id, user_scope.user.id)
  end
end
