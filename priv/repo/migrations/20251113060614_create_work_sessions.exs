defmodule App.Repo.Migrations.CreateWorkSessions do
  use Ecto.Migration

  def change do
    create table(:work_sessions) do
      add :start_time, :utc_datetime, null: true
      add :end_time, :utc_datetime, null: true
      add :is_running, :boolean, default: false, null: false
      add :accumulated_paused_duration, :integer, default: 0
      add :paused_at, :utc_datetime, null: true
      add :total_minutes_worked, :integer, default: 0
      add :time_reported, :boolean, default: false
      add :job_id, references(:jobs, on_delete: :delete_all)
      add :user_id, references(:users, type: :id, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:work_sessions, [:user_id])

    create index(:work_sessions, [:job_id])
  end
end
