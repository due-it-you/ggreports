class ApplicationController < ActionController::Base
  around_action :switch_locale
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def switch_locale(&action)
    I18n.with_locale(locale, &action)
  end

  def locale
    @locale ||= params[:locale] || I18n.default_locale
  end
end
