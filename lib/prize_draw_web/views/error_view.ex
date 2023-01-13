defmodule PrizeDrawWeb.ErrorView do
  use PrizeDrawWeb, :view

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".

  def render("not_allowed_to_execute_past_draws.json", _) do
    %{error: "User are not allowed to execute past draws"}
  end

  def render("not_allowed_after_date.json", _) do
    %{error: "User are not allowed to assign past draws"}
  end

  def render("already_in_a_draw.json", _) do
    %{error: "User are not allowed to reassign to a draw"}
  end

  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end
end
