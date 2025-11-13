defmodule App.JobsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `App.Jobs` context.
  """

  @doc """
  Generate a job.
  """
  def job_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        hourly_rate: 120.5,
        number_of_payouts: 42,
        payment_type: :hourly,
        payout_amount: 120.5,
        title: "some title"
      })

    {:ok, job} = App.Jobs.create_job(scope, attrs)
    job
  end
end
