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

  # API routes

  scope "/api", AppWeb do
    pipe_through :api
  end

  # public routes

  scope "/", AppWeb do
    pipe_through :browser

    get "/", PublicController, :home
  end

  # private routes

  scope "/", AppWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/dashboard", PrivateController, :dashboard_page

    get "/set-password", PrivateController, :set_password_page
    put "/set-password", PrivateController, :set_password

    delete "/log-out", PrivateController, :log_out

    # get "/users/settings", UserSettingsController, :edit
    # put "/users/settings", UserSettingsController, :update
    # get "/users/settings/confirm-email/:token", UserSettingsController, :confirm_email
  end

  # Authentication routes

  scope "/auth", AppWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/sign-up", AuthController, :sign_up_page
    post "/sign-up", AuthController, :sign_up

    get "/log-in", AuthController, :log_in_page
    post "/log-in", AuthController, :log_in
    get "/log-in/:token", AuthController, :magic_link_log_in
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
