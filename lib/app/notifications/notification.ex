defmodule App.Notifications.Notification do
  @moduledoc """
  Represents a notification that can be displayed to the user.

  Notifications are used to provide feedback to users about the result of an action,
  such as info messages, success messages, warnings, or error messages. They are typically sent as
  flash messages and rendered on the frontend.

  ## Examples

      iex> Notification.new(:success, "Success", "Post created successfully!")
      %Notification{type: :success, title: "Success", message: "Post created successfully!"}

      iex> Notification.new(:error, "Error", "Something went wrong")
      %Notification{type: :error, title: "Error", message: "Something went wrong"}
  """

  @doc """
  A notification struct containing type, title, and message.

  ## Fields

    * `:type` - The notification type (`:info`, `:warning`, `:success`, `:error`)
    * `:title` - The notification title displayed to the user
    * `:message` - The notification message displayed to the user
  """
  @derive Jason.Encoder
  defstruct type: :info, title: "", message: ""

  @type notification_type :: :info | :warning | :success | :error

  @type t :: %__MODULE__{
          type: notification_type,
          title: String.t(),
          message: String.t()
        }

  @doc """
  Creates a new notification with the given type, title, and message.

  ## Parameters

    * `type` - One of `:info`, `:warning`, `:success`, or `:error`
    * `title` - A string title for the notification
    * `message` - A string message for the notification

  ## Returns

    A `Notification` struct.

  ## Examples

      iex> Notification.new(:success, "Success", "Item created")
      %Notification{type: :success, title: "Success", message: "Item created"}

      iex> Notification.new(:error, "Error", "Failed to save")
      %Notification{type: :error, title: "Error", message: "Failed to save"}
  """
  @spec new(notification_type, String.t(), String.t()) :: t()
  def new(type, title, message) do
    %__MODULE__{type: type, title: title, message: message}
  end
end
