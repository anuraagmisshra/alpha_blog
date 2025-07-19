# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    include AuthenticateWithOtpTwoFactor

    # prepend_before_action :authenticate_with_otp_two_factor,
    #                       if: -> { action_name == 'create' && otp_two_factor_enabled? }

    protect_from_forgery with: :exception, prepend: true, except: :destroy
    prepend_before_action :check_captcha, only: [:create] # Change this to be any actions you want to protect.

    private

    def check_captcha
      return if verify_recaptcha # verify_recaptcha(action: 'login') for v3

      self.resource = resource_class.new sign_in_params

      respond_with_navigational(resource) do
        flash.discard(:recaptcha_error) # We need to discard flash to avoid showing it on the next page reload
        render :new
      end
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_in, keys: [:otp_attempt])
    end
  end
end
