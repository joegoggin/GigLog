defmodule App.Repo.Migrations.CreateJobs do
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :title, :string
      add :payment_type, :string
      add :number_of_payouts, :integer, null: true
      add :payout_amount, :decimal, null: true
      add :hourly_rate, :decimal, null: true
      add :company_id, references(:companies, on_delete: :delete_all)
      add :user_id, references(:users, type: :id, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:jobs, [:user_id])

    create index(:jobs, [:company_id])
  end
end
