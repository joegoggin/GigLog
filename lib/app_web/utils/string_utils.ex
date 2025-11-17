defmodule AppWeb.Utils.StringUtils do
  def to_boolean(string) do
    if string == "true" do
      true
    else
      false
    end
  end
end
