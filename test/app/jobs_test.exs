defmodule App.JobsTest do
  use App.DataCase

  alias App.Jobs

  describe "jobs" do
    alias App.Jobs.Job

    import App.AccountsFixtures, only: [user_scope_fixture: 0]
    import App.JobsFixtures

    @invalid_attrs %{title: nil, payment_type: nil, number_of_payouts: nil, payout_amount: nil, hourly_rate: nil}

    test "list_jobs/1 returns all scoped jobs" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      job = job_fixture(scope)
      other_job = job_fixture(other_scope)
      assert Jobs.list_jobs(scope) == [job]
      assert Jobs.list_jobs(other_scope) == [other_job]
    end

    test "get_job!/2 returns the job with given id" do
      scope = user_scope_fixture()
      job = job_fixture(scope)
      other_scope = user_scope_fixture()
      assert Jobs.get_job!(scope, job.id) == job
      assert_raise Ecto.NoResultsError, fn -> Jobs.get_job!(other_scope, job.id) end
    end

    test "create_job/2 with valid data creates a job" do
      valid_attrs = %{title: "some title", payment_type: :hourly, number_of_payouts: 42, payout_amount: 120.5, hourly_rate: 120.5}
      scope = user_scope_fixture()

      assert {:ok, %Job{} = job} = Jobs.create_job(scope, valid_attrs)
      assert job.title == "some title"
      assert job.payment_type == :hourly
      assert job.number_of_payouts == 42
      assert job.payout_amount == 120.5
      assert job.hourly_rate == 120.5
      assert job.user_id == scope.user.id
    end

    test "create_job/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Jobs.create_job(scope, @invalid_attrs)
    end

    test "update_job/3 with valid data updates the job" do
      scope = user_scope_fixture()
      job = job_fixture(scope)
      update_attrs = %{title: "some updated title", payment_type: :payouts, number_of_payouts: 43, payout_amount: 456.7, hourly_rate: 456.7}

      assert {:ok, %Job{} = job} = Jobs.update_job(scope, job, update_attrs)
      assert job.title == "some updated title"
      assert job.payment_type == :payouts
      assert job.number_of_payouts == 43
      assert job.payout_amount == 456.7
      assert job.hourly_rate == 456.7
    end

    test "update_job/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      job = job_fixture(scope)

      assert_raise MatchError, fn ->
        Jobs.update_job(other_scope, job, %{})
      end
    end

    test "update_job/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      job = job_fixture(scope)
      assert {:error, %Ecto.Changeset{}} = Jobs.update_job(scope, job, @invalid_attrs)
      assert job == Jobs.get_job!(scope, job.id)
    end

    test "delete_job/2 deletes the job" do
      scope = user_scope_fixture()
      job = job_fixture(scope)
      assert {:ok, %Job{}} = Jobs.delete_job(scope, job)
      assert_raise Ecto.NoResultsError, fn -> Jobs.get_job!(scope, job.id) end
    end

    test "delete_job/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      job = job_fixture(scope)
      assert_raise MatchError, fn -> Jobs.delete_job(other_scope, job) end
    end

    test "change_job/2 returns a job changeset" do
      scope = user_scope_fixture()
      job = job_fixture(scope)
      assert %Ecto.Changeset{} = Jobs.change_job(scope, job)
    end
  end
end
