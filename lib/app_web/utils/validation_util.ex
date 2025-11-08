defmodule AppWeb.Utils.ValidationUtils do
  @moduledoc """
  Utilities for validating required parameters in request handlers.
  """

  @doc """
  Validates that all required parameters are present and not blank.

  Takes a list of required parameter keys and a params map, checking each
  key to ensure it exists and contains a non-empty value.

  ## Parameters

    * `required_keys` - A list of atoms representing required parameter keys
    * `params` - A map of parameters to validate (typically from the request)

  ## Returns

    * `:ok` - If all required parameters are present and non-blank
    * `{:error, errors}` - If validation fails, where `errors` is a map of
      field names to error messages (e.g., `%{email: "is required"}`)

  ## Examples

      iex> validate_required_params([:email, :password], %{"email" => "user@example.com", "password" => "secret"})
      :ok

      iex> validate_required_params([:email, :password], %{"email" => "", "password" => "secret"})
      {:error, %{email: "is required"}}

      iex> validate_required_params([:email, :password], %{"email" => nil, "password" => nil})
      {:error, %{email: "is required", password: "is required"}}
  """
  def validate_required_params(required_keys, params) do
    errors =
      required_keys
      |> Enum.reduce(%{}, fn key, acc ->
        if blank?(params[Atom.to_string(key)]) do
          Map.put(acc, key, "is required")
        else
          acc
        end
      end)

    if Enum.empty?(errors) do
      :ok
    else
      {:error, errors}
    end
  end

  @doc false
  defp blank?(value) do
    is_nil(value) || (is_binary(value) && String.trim(value) == "")
  end
end
