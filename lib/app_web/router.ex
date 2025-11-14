defmodule AppWeb.Router do
  use AppWeb, :router

  import AppWeb.UserAuth
  alias AppWeb.Plugs

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {AppWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_scope_for_user
    plug Inertia.Plug
    plug Plugs.AssignUserProp
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # API Routers

  scope "/api", AppWeb do
    pipe_through :api
  end

  # Public router

  scope "/", AppWeb do
    pipe_through :browser

    get "/", PublicController, :home
  end

  # Authentication router

  scope "/auth", AppWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/sign-up", AuthController, :sign_up_page
    post "/sign-up", AuthController, :sign_up

    get "/log-in", AuthController, :log_in_page
    post "/log-in", AuthController, :log_in
    get "/log-in/:token", AuthController, :magic_link_log_in
  end

  scope "/auth", AppWeb do
    pipe_through [:browser, :require_authenticated_user]

    delete "/log-out", AuthController, :log_out
  end

  # Dashboard Router
  scope "/dashboard", AppWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/", DashboardController, :dashboard_page
  end

  # Companies Router
  scope "/companies", AppWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/", CompaniesController, :companies_page

    get "/:company_id", CompaniesController, :view_company_page
    delete "/:company_id", CompaniesController, :delete_company
  end

  # Jobs Router
  scope "/jobs", AppWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/", JobsController, :jobs_page

    get "/create", JobsController, :create_job_page
  end

  # Jobs Router
  scope "/payments", AppWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/", PaymentsController, :payments_page
  end

  # Settings Router
  scope "/settings", AppWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/", SettingsController, :settings_page

    get "/set-password", SettingsController, :set_password_page
    put "/set-password", SettingsController, :set_password
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:app, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: AppWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
