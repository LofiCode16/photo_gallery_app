class ApplicationController < ActionController::Base
    before_action :authenticate_user!, only: :index
    before_action :configure_permitted_parameters, if: :devise_controller?

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: %i[name description])
        devise_parameter_sanitizer.permit(:account_update, keys: %i[name description])
    end
end
