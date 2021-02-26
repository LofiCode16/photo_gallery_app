class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

    def facebook
        @user = User.from_omniauth(request.env['omniauth.auth'])

        set_oauth_user(@user, 'Facebook')
    end

    def google_oauth2
        @user = User.from_omniauth(request.env['omniauth.auth'])

        set_oauth_user(@user, 'Google')
    end

    private 
    def set_oauth_user(user, provider)
        if user.persisted?
            sign_in_and_redirect user
            set_flash_message(:notice, :success, kind: provider) if is_navigational_format?
        else
            redirect_to root_path, notice: "No se ha podido iniciar sesión con #{provider}"
        end
    end
end