defmodule App.PaymentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `App.Payments` context.
  """

  @doc """
  Generate a payment.
  """
  def payment_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        expected_payout_date: ~D[2025-11-12],
        expected_transfer_date: ~D[2025-11-12],
        payment_received: true,
        payout_type: :paypal,
        tax_withholdings_covered: true,
        total: "120.5",
        transfer_initiated: true,
        transfer_received: true
      })

    {:ok, payment} = App.Payments.create_payment(scope, attrs)
    payment
  end
end
