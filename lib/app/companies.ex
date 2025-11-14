defmodule App.Companies do
  @moduledoc """
  The Companies context.
  """

  import Ecto.Query, warn: false
  alias App.Repo

  alias App.Companies.Company
  alias App.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any company changes.

  The broadcasted messages match the pattern:

    * {:created, %Company{}}
    * {:updated, %Company{}}
    * {:deleted, %Company{}}

  """
  def subscribe_companies(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(App.PubSub, "user:#{key}:companies")
  end

  defp broadcast_company(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(App.PubSub, "user:#{key}:companies", message)
  end

  @doc """
  Returns the list of companies.

  ## Examples

      iex> list_companies(scope)
      [%Company{}, ...]

  """
  def list_companies(%Scope{} = scope) do
    Repo.all_by(Company, user_id: scope.user.id)
    |> Company.copmanies_to_json()
  end

  @doc """
  Gets a single company.

  Raises `Ecto.NoResultsError` if the Company does not exist.

  ## Examples

      iex> get_company!(scope, 123)
      %Company{}

      iex> get_company!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_company!(%Scope{} = scope, id) do
    Repo.get_by!(Company, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a company.

  ## Examples

      iex> create_company(scope, %{field: value})
      {:ok, %Company{}}

      iex> create_company(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_company(%Scope{} = scope, attrs) do
    with {:ok, company = %Company{}} <-
           %Company{}
           |> Company.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_company(scope, {:created, company})
      {:ok, company}
    end
  end

  @doc """
  Updates a company.

  ## Examples

      iex> update_company(scope, company, %{field: new_value})
      {:ok, %Company{}}

      iex> update_company(scope, company, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_company(%Scope{} = scope, %Company{} = company, attrs) do
    true = company.user_id == scope.user.id

    with {:ok, company = %Company{}} <-
           company
           |> Company.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_company(scope, {:updated, company})
      {:ok, company}
    end
  end

  @doc """
  Deletes a company.

  ## Examples

      iex> delete_company(scope, company)
      {:ok, %Company{}}

      iex> delete_company(scope, company)
      {:error, %Ecto.Changeset{}}

  """
  def delete_company(%Scope{} = scope, %Company{} = company) do
    true = company.user_id == scope.user.id

    with {:ok, company = %Company{}} <-
           Repo.delete(company) do
      broadcast_company(scope, {:deleted, company})
      {:ok, company}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking company changes.

  ## Examples

      iex> change_company(scope, company)
      %Ecto.Changeset{data: %Company{}}

  """
  def change_company(%Scope{} = scope, %Company{} = company, attrs \\ %{}) do
    true = company.user_id == scope.user.id

    Company.changeset(company, attrs, scope)
  end
end
