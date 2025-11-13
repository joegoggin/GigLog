defmodule App.Repo.Migrations.CreatePayments do
  use Ecto.Migration

  def change do
    create table(:payments) do
      add :total, :decimal, precision: 10, scale: 2, null: false
      add :payout_type, :string, null: false
      add :expected_payout_date, :date
      add :expected_transfer_date, :date
      add :transfer_initiated, :boolean, default: false, null: false
      add :payment_received, :boolean, default: false, null: false
      add :transfer_received, :boolean, default: false, null: false
      add :tax_withholdings_covered, :boolean, default: false, null: false
      add :job_id, references(:jobs, on_delete: :delete_all)
      add :user_id, references(:users, type: :id, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:payments, [:user_id])

    create index(:payments, [:job_id])
  end
end
