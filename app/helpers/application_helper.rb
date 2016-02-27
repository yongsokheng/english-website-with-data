module ApplicationHelper
   def full_title page_title = ""
      base_title = t "titles.header"
      if page_title.empty?
        base_title
      else
        "#{page_title} | #{base_title}"
      end
  end

  def flash_class level
    case level
    when :notice then "alert-info"
    when :error then "alert-error"
    when :alert then "alert-warning"
    when :success then "alert-success"
    end
  end

  def flash_message flash_type
    t "flashs.messages.#{flash_type}", model_name: controller_name.classify
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def active? controller_name
    if controller.controller_name == controller_name
      "active"
    end
  end

  def current_user? user
    user == current_user
  end

  def correct_user? user
    redirect_to admin_root_path unless current_user? user
  end
end
