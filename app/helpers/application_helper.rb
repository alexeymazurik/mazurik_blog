module ApplicationHelper
  def active_link_to(title, path, controller)
    "<li class=#{'active' if controller_name == controller}>
      #{link_to title, path}
    </li>".html_safe
  end
end
