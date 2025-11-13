defmodule App.WorkSessionsTest do
  use App.DataCase

  alias App.WorkSessions

  describe "work_sessions" do
    alias App.WorkSessions.WorkSession

    import App.AccountsFixtures, only: [user_scope_fixture: 0]
    import App.WorkSessionsFixtures

    @invalid_attrs %{is_running: nil, start_time: nil, end_time: nil, accumulated_paused_duration: nil, paused_at: nil, total_minutes_worked: nil}

    test "list_work_sessions/1 returns all scoped work_sessions" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      work_session = work_session_fixture(scope)
      other_work_session = work_session_fixture(other_scope)
      assert WorkSessions.list_work_sessions(scope) == [work_session]
      assert WorkSessions.list_work_sessions(other_scope) == [other_work_session]
    end

    test "get_work_session!/2 returns the work_session with given id" do
      scope = user_scope_fixture()
      work_session = work_session_fixture(scope)
      other_scope = user_scope_fixture()
      assert WorkSessions.get_work_session!(scope, work_session.id) == work_session
      assert_raise Ecto.NoResultsError, fn -> WorkSessions.get_work_session!(other_scope, work_session.id) end
    end

    test "create_work_session/2 with valid data creates a work_session" do
      valid_attrs = %{is_running: true, start_time: ~T[14:00:00], end_time: ~T[14:00:00], accumulated_paused_duration: ~T[14:00:00], paused_at: ~T[14:00:00], total_minutes_worked: 42}
      scope = user_scope_fixture()

      assert {:ok, %WorkSession{} = work_session} = WorkSessions.create_work_session(scope, valid_attrs)
      assert work_session.is_running == true
      assert work_session.start_time == ~T[14:00:00]
      assert work_session.end_time == ~T[14:00:00]
      assert work_session.accumulated_paused_duration == ~T[14:00:00]
      assert work_session.paused_at == ~T[14:00:00]
      assert work_session.total_minutes_worked == 42
      assert work_session.user_id == scope.user.id
    end

    test "create_work_session/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = WorkSessions.create_work_session(scope, @invalid_attrs)
    end

    test "update_work_session/3 with valid data updates the work_session" do
      scope = user_scope_fixture()
      work_session = work_session_fixture(scope)
      update_attrs = %{is_running: false, start_time: ~T[15:01:01], end_time: ~T[15:01:01], accumulated_paused_duration: ~T[15:01:01], paused_at: ~T[15:01:01], total_minutes_worked: 43}

      assert {:ok, %WorkSession{} = work_session} = WorkSessions.update_work_session(scope, work_session, update_attrs)
      assert work_session.is_running == false
      assert work_session.start_time == ~T[15:01:01]
      assert work_session.end_time == ~T[15:01:01]
      assert work_session.accumulated_paused_duration == ~T[15:01:01]
      assert work_session.paused_at == ~T[15:01:01]
      assert work_session.total_minutes_worked == 43
    end

    test "update_work_session/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      work_session = work_session_fixture(scope)

      assert_raise MatchError, fn ->
        WorkSessions.update_work_session(other_scope, work_session, %{})
      end
    end

    test "update_work_session/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      work_session = work_session_fixture(scope)
      assert {:error, %Ecto.Changeset{}} = WorkSessions.update_work_session(scope, work_session, @invalid_attrs)
      assert work_session == WorkSessions.get_work_session!(scope, work_session.id)
    end

    test "delete_work_session/2 deletes the work_session" do
      scope = user_scope_fixture()
      work_session = work_session_fixture(scope)
      assert {:ok, %WorkSession{}} = WorkSessions.delete_work_session(scope, work_session)
      assert_raise Ecto.NoResultsError, fn -> WorkSessions.get_work_session!(scope, work_session.id) end
    end

    test "delete_work_session/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      work_session = work_session_fixture(scope)
      assert_raise MatchError, fn -> WorkSessions.delete_work_session(other_scope, work_session) end
    end

    test "change_work_session/2 returns a work_session changeset" do
      scope = user_scope_fixture()
      work_session = work_session_fixture(scope)
      assert %Ecto.Changeset{} = WorkSessions.change_work_session(scope, work_session)
    end
  end
end
