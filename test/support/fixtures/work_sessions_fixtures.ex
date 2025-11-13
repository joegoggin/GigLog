defmodule App.WorkSessionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `App.WorkSessions` context.
  """

  @doc """
  Generate a work_session.
  """
  def work_session_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        accumulated_paused_duration: ~T[14:00:00],
        end_time: ~T[14:00:00],
        is_running: true,
        paused_at: ~T[14:00:00],
        start_time: ~T[14:00:00],
        total_minutes_worked: 42
      })

    {:ok, work_session} = App.WorkSessions.create_work_session(scope, attrs)
    work_session
  end
end
