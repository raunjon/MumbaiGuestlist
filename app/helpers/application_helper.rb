module ApplicationHelper
  def is_namespace_admin?
    controller.class.name.split("::").first=="Admin"
  end
end
