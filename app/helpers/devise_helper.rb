module DeviseHelper
  def devise_errors
    return nil unless devise_errors?
    resource.errors.messages
  end

  def devise_errors?
    !resource.errors.empty?
  end

  def devise_errors_in_field?(field_name)
    return nil unless devise_errors?
    return nil unless devise_errors.key?(field_name)
    devise_errors[field_name].size > 0
  end

end