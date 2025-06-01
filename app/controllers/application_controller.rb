class ApplicationController < ActionController::Base
  around_action :switch_locale
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # "/"にアクセスがあった時に、任意の言語のページにリダイレクトする処理
  def redirect_by_locale
    locale = extract_locale_from_accept_language_header || I18n.default_locale
    redirect_to "/#{locale}/lol"
  end

  private

  def switch_locale(&action)
    I18n.with_locale(locale, &action)
  end

  def locale
    @locale ||= params[:locale] || I18n.default_locale
  end

  # リクエストヘッダーからユーザーのロケールを推測して返す処理
  def extract_locale_from_accept_language_header
    lang = request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first
    I18n.available_locales.map(&:to_s).include?(lang) ? lang : nil
  end
end
