defmodule AppWeb.JobsController do
  use AppWeb, :controller

  def jobs_page(conn, _params) do
    conn
    |> render_inertia("jobs/Jobs")
  end
end
