defmodule App.Payments do
  @moduledoc """
  The Payments context.
  """

  import Ecto.Query, warn: false
  alias App.Repo

  alias App.Payments.Payment
  alias App.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any payment changes.

  The broadcasted messages match the pattern:

    * {:created, %Payment{}}
    * {:updated, %Payment{}}
    * {:deleted, %Payment{}}

  """
  def subscribe_payments(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(App.PubSub, "user:#{key}:payments")
  end

  defp broadcast_payment(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(App.PubSub, "user:#{key}:payments", message)
  end

  @doc """
  Returns the list of payments.

  ## Examples

      iex> list_payments(scope)
      [%Payment{}, ...]

  """
  def list_payments(%Scope{} = scope) do
    Repo.all_by(Payment, user_id: scope.user.id)
  end

  @doc """
  Gets a single payment.

  Raises `Ecto.NoResultsError` if the Payment does not exist.

  ## Examples

      iex> get_payment!(scope, 123)
      %Payment{}

      iex> get_payment!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_payment!(%Scope{} = scope, id) do
    Repo.get_by!(Payment, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a payment.

  ## Examples

      iex> create_payment(scope, %{field: value})
      {:ok, %Payment{}}

      iex> create_payment(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_payment(%Scope{} = scope, attrs) do
    with {:ok, payment = %Payment{}} <-
           %Payment{}
           |> Payment.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_payment(scope, {:created, payment})
      {:ok, payment}
    end
  end

  @doc """
  Updates a payment.

  ## Examples

      iex> update_payment(scope, payment, %{field: new_value})
      {:ok, %Payment{}}

      iex> update_payment(scope, payment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_payment(%Scope{} = scope, %Payment{} = payment, attrs) do
    true = payment.user_id == scope.user.id

    with {:ok, payment = %Payment{}} <-
           payment
           |> Payment.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_payment(scope, {:updated, payment})
      {:ok, payment}
    end
  end

  @doc """
  Deletes a payment.

  ## Examples

      iex> delete_payment(scope, payment)
      {:ok, %Payment{}}

      iex> delete_payment(scope, payment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_payment(%Scope{} = scope, %Payment{} = payment) do
    true = payment.user_id == scope.user.id

    with {:ok, payment = %Payment{}} <-
           Repo.delete(payment) do
      broadcast_payment(scope, {:deleted, payment})
      {:ok, payment}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking payment changes.

  ## Examples

      iex> change_payment(scope, payment)
      %Ecto.Changeset{data: %Payment{}}

  """
  def change_payment(%Scope{} = scope, %Payment{} = payment, attrs \\ %{}) do
    true = payment.user_id == scope.user.id

    Payment.changeset(payment, attrs, scope)
  end
end
