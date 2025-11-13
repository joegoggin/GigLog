defmodule App.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add(:name, :string)
      add(:requires_tax_withholdings, :boolean, default: false, null: false)
      add(:tax_withholding_rate, :float)
      add(:user_id, references(:users, type: :id, on_delete: :delete_all))

      timestamps(type: :utc_datetime)
    end

    create(index(:companies, [:user_id]))
  end
end
