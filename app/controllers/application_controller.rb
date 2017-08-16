class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  #redirects to app index page from the cancan default error page.
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, alert: exception.message
  end
end
