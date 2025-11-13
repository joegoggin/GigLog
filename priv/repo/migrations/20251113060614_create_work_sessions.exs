defmodule App.Repo.Migrations.CreateWorkSessions do
  use Ecto.Migration

  def change do
    create table(:work_sessions) do
      add :start_time, :time, null: true
      add :end_time, :time, null: true
      add :is_running, :boolean, default: false, null: false
      add :accumulated_paused_duration, :time
      add :paused_at, :time, null: true
      add :total_minutes_worked, :integer, default: 0
      add :job_id, references(:jobs, on_delete: :nothing)
      add :user_id, references(:users, type: :id, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:work_sessions, [:user_id])

    create index(:work_sessions, [:job_id])
  end
end
