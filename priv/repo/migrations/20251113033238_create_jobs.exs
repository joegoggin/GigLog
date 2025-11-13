defmodule App.Repo.Migrations.CreateJobs do
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :title, :string, null: false
      add :payment_type, :string, null: false
      add :number_of_payouts, :integer
      add :payout_amount, :decimal, precision: 10, scale: 2
      add :hourly_rate, :decimal, precision: 10, scale: 2
      add :company_id, references(:companies, on_delete: :delete_all)
      add :user_id, references(:users, type: :id, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:jobs, [:user_id])

    create index(:jobs, [:company_id])
  end
end
