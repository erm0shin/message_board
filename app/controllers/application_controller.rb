class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  before_action :set_locale

  def after_sign_in_path_for(resource)
    root_path
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end
end
