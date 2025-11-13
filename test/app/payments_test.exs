defmodule App.PaymentsTest do
  use App.DataCase

  alias App.Payments

  describe "payments" do
    alias App.Payments.Payment

    import App.AccountsFixtures, only: [user_scope_fixture: 0]
    import App.PaymentsFixtures

    @invalid_attrs %{total: nil, payout_type: nil, expected_payout_date: nil, expected_transfer_date: nil, transfer_initiated: nil, payment_received: nil, transfer_received: nil, tax_withholdings_covered: nil}

    test "list_payments/1 returns all scoped payments" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      payment = payment_fixture(scope)
      other_payment = payment_fixture(other_scope)
      assert Payments.list_payments(scope) == [payment]
      assert Payments.list_payments(other_scope) == [other_payment]
    end

    test "get_payment!/2 returns the payment with given id" do
      scope = user_scope_fixture()
      payment = payment_fixture(scope)
      other_scope = user_scope_fixture()
      assert Payments.get_payment!(scope, payment.id) == payment
      assert_raise Ecto.NoResultsError, fn -> Payments.get_payment!(other_scope, payment.id) end
    end

    test "create_payment/2 with valid data creates a payment" do
      valid_attrs = %{total: "120.5", payout_type: :paypal, expected_payout_date: ~D[2025-11-12], expected_transfer_date: ~D[2025-11-12], transfer_initiated: true, payment_received: true, transfer_received: true, tax_withholdings_covered: true}
      scope = user_scope_fixture()

      assert {:ok, %Payment{} = payment} = Payments.create_payment(scope, valid_attrs)
      assert payment.total == Decimal.new("120.5")
      assert payment.payout_type == :paypal
      assert payment.expected_payout_date == ~D[2025-11-12]
      assert payment.expected_transfer_date == ~D[2025-11-12]
      assert payment.transfer_initiated == true
      assert payment.payment_received == true
      assert payment.transfer_received == true
      assert payment.tax_withholdings_covered == true
      assert payment.user_id == scope.user.id
    end

    test "create_payment/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Payments.create_payment(scope, @invalid_attrs)
    end

    test "update_payment/3 with valid data updates the payment" do
      scope = user_scope_fixture()
      payment = payment_fixture(scope)
      update_attrs = %{total: "456.7", payout_type: :cash, expected_payout_date: ~D[2025-11-13], expected_transfer_date: ~D[2025-11-13], transfer_initiated: false, payment_received: false, transfer_received: false, tax_withholdings_covered: false}

      assert {:ok, %Payment{} = payment} = Payments.update_payment(scope, payment, update_attrs)
      assert payment.total == Decimal.new("456.7")
      assert payment.payout_type == :cash
      assert payment.expected_payout_date == ~D[2025-11-13]
      assert payment.expected_transfer_date == ~D[2025-11-13]
      assert payment.transfer_initiated == false
      assert payment.payment_received == false
      assert payment.transfer_received == false
      assert payment.tax_withholdings_covered == false
    end

    test "update_payment/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      payment = payment_fixture(scope)

      assert_raise MatchError, fn ->
        Payments.update_payment(other_scope, payment, %{})
      end
    end

    test "update_payment/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      payment = payment_fixture(scope)
      assert {:error, %Ecto.Changeset{}} = Payments.update_payment(scope, payment, @invalid_attrs)
      assert payment == Payments.get_payment!(scope, payment.id)
    end

    test "delete_payment/2 deletes the payment" do
      scope = user_scope_fixture()
      payment = payment_fixture(scope)
      assert {:ok, %Payment{}} = Payments.delete_payment(scope, payment)
      assert_raise Ecto.NoResultsError, fn -> Payments.get_payment!(scope, payment.id) end
    end

    test "delete_payment/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      payment = payment_fixture(scope)
      assert_raise MatchError, fn -> Payments.delete_payment(other_scope, payment) end
    end

    test "change_payment/2 returns a payment changeset" do
      scope = user_scope_fixture()
      payment = payment_fixture(scope)
      assert %Ecto.Changeset{} = Payments.change_payment(scope, payment)
    end
  end
end
