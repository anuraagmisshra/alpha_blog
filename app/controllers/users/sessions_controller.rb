# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    # include AuthenticateWithOtpTwoFactor

    # prepend_before_action :authenticate_with_otp_two_factor,
    #                          if: -> { action_name == 'create' && otp_two_factor_enabled? }

    protect_from_forgery with: :exception, prepend: true, except: :destroy
    prepend_before_action :check_captcha, only: [:create]
    before_action :configure_permitted_parameters

    private

    def check_captcha
      Rails.logger.info '=== CAPTCHA CHECK ==='
      return if verify_recaptcha

      Rails.logger.info 'Captcha failed, rendering form with error'
      self.resource = resource_class.new
      resource.email = params[:user][:email] if params[:user] && params[:user][:email]

      respond_with_navigational(resource) do
        flash.now[:alert] = 'Please complete the reCAPTCHA verification.'
        render :new, status: :unprocessable_entity
      end
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_in, keys: [:otp_attempt])
    end
  end
end
