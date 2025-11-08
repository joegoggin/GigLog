defmodule AppWeb.AuthController do
  use AppWeb, :controller

  alias AppWeb.UserAuth
  alias AppWeb.Utils.ValidationUtils
  alias App.Accounts
  alias App.Notifications.Notification

  @doc """
    route: get /auth/sign-in

    Renders sign up page
  """
  def sign_up_page(conn, _params) do
    conn
    |> render_inertia("auth/SignUp")
  end

  @doc """
    route: post /auth/sign-in

    Creates account and sends confirmation emails
  """
  def sign_up(conn, params) do
    case Accounts.register_user(params) do
      {:ok, user} ->
        Accounts.deliver_login_instructions(
          user,
          &url(~p"/auth/log-in/#{&1}")
        )

        notifications = [
          Notification.new(
            :success,
            "Account Created!",
            "Check your email to confirm your account"
          )
        ]

        conn
        |> put_flash(:notifications, notifications)
        |> redirect(to: ~p"/auth/sign-up")

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> assign_errors(changeset)
        |> redirect(to: ~p"/auth/sign-up")
    end
  end

  @doc """
    route: get /auth/log-in/:token

    Attempts to log in user with magic link from email. if successful the user
    is redirected to `/set-password`. If log in fails an error screen is
    rendered.
  """
  def magic_link_log_in(conn, %{"token" => token}) do
    case Accounts.login_user_by_magic_link(token) do
      {:ok, {user, _expired_tokens}} ->
        conn
        |> UserAuth.log_in_user(user)
        |> redirect(to: ~p"/set-password")

      {:error, :not_found} ->
        conn
        |> render_inertia("auth/InvalidTokenError")
    end
  end

  @doc """
    route: get /auth/log-in

    Renders log in page
  """
  def log_in_page(conn, _params) do
    conn
    |> render_inertia("auth/LogIn")
  end

  @doc """
    route: post /auth/log-in

    Logs in user
  """
  def log_in(conn, %{"email" => email, "password" => password} = params) do
    required_params = [:email, :password]

    case ValidationUtils.validate_required_params(required_params, params) do
      {:error, errors} ->
        conn
        |> assign_errors(errors)
        |> redirect(to: ~p"/auth/log-in")

      :ok ->
        if user = Accounts.get_user_by_email_and_password(email, password) do
          conn
          |> UserAuth.log_in_user(user, params)
        else
          notifications = [
            Notification.new(:error, "Login Failed!", "Invalid email or password.")
          ]

          conn
          |> put_flash(:notifications, notifications)
          |> redirect(to: ~p"/auth/log-in")
        end
    end
  end
end
