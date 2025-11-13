defmodule App.WorkSessions.WorkSession do
  use Ecto.Schema
  import Ecto.Changeset

  alias App.Jobs
  alias App.Accounts

  schema "work_sessions" do
    field :start_time, :utc_datetime
    field :end_time, :utc_datetime
    field :is_running, :boolean, default: false
    field :accumulated_paused_duration, :integer, default: 0
    field :paused_at, :utc_datetime
    field :total_minutes_worked, :integer, default: 0
    field :time_reported, :boolean, default: false

    belongs_to :job, Jobs.Job
    belongs_to :user, Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(work_session, attrs, user_scope) do
    work_session
    |> cast(attrs, [
      :start_time,
      :end_time,
      :is_running,
      :accumulated_paused_duration,
      :paused_at,
      :total_minutes_worked,
      :time_reported,
      :job_id
    ])
    |> validate_required([
      :job_id
    ])
    |> put_change(:user_id, user_scope.user.id)
  end
end
