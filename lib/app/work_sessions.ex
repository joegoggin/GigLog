defmodule App.WorkSessions do
  @moduledoc """
  The WorkSessions context.
  """

  import Ecto.Query, warn: false
  alias App.Repo

  alias App.WorkSessions.WorkSession
  alias App.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any work_session changes.

  The broadcasted messages match the pattern:

    * {:created, %WorkSession{}}
    * {:updated, %WorkSession{}}
    * {:deleted, %WorkSession{}}

  """
  def subscribe_work_sessions(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(App.PubSub, "user:#{key}:work_sessions")
  end

  defp broadcast_work_session(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(App.PubSub, "user:#{key}:work_sessions", message)
  end

  @doc """
  Returns the list of work_sessions.

  ## Examples

      iex> list_work_sessions(scope)
      [%WorkSession{}, ...]

  """
  def list_work_sessions(%Scope{} = scope) do
    Repo.all_by(WorkSession, user_id: scope.user.id)
  end

  @doc """
  Gets a single work_session.

  Raises `Ecto.NoResultsError` if the Work session does not exist.

  ## Examples

      iex> get_work_session!(scope, 123)
      %WorkSession{}

      iex> get_work_session!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_work_session!(%Scope{} = scope, id) do
    Repo.get_by!(WorkSession, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a work_session.

  ## Examples

      iex> create_work_session(scope, %{field: value})
      {:ok, %WorkSession{}}

      iex> create_work_session(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_work_session(%Scope{} = scope, attrs) do
    with {:ok, work_session = %WorkSession{}} <-
           %WorkSession{}
           |> WorkSession.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_work_session(scope, {:created, work_session})
      {:ok, work_session}
    end
  end

  @doc """
  Updates a work_session.

  ## Examples

      iex> update_work_session(scope, work_session, %{field: new_value})
      {:ok, %WorkSession{}}

      iex> update_work_session(scope, work_session, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_work_session(%Scope{} = scope, %WorkSession{} = work_session, attrs) do
    true = work_session.user_id == scope.user.id

    with {:ok, work_session = %WorkSession{}} <-
           work_session
           |> WorkSession.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_work_session(scope, {:updated, work_session})
      {:ok, work_session}
    end
  end

  @doc """
  Deletes a work_session.

  ## Examples

      iex> delete_work_session(scope, work_session)
      {:ok, %WorkSession{}}

      iex> delete_work_session(scope, work_session)
      {:error, %Ecto.Changeset{}}

  """
  def delete_work_session(%Scope{} = scope, %WorkSession{} = work_session) do
    true = work_session.user_id == scope.user.id

    with {:ok, work_session = %WorkSession{}} <-
           Repo.delete(work_session) do
      broadcast_work_session(scope, {:deleted, work_session})
      {:ok, work_session}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking work_session changes.

  ## Examples

      iex> change_work_session(scope, work_session)
      %Ecto.Changeset{data: %WorkSession{}}

  """
  def change_work_session(%Scope{} = scope, %WorkSession{} = work_session, attrs \\ %{}) do
    true = work_session.user_id == scope.user.id

    WorkSession.changeset(work_session, attrs, scope)
  end
end
