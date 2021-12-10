# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    layout 'dashboard', only: %i[edit update]

    # def create
    #   session["#{resource_name}_return_to"] = dashboard_root_path
    #   super
    # end This was my alternative method for redirecting user to dashboard after Sign up

    # GET /resource/sign_up
    # def new
    #   super
    # end

    # POST /resource
    # def create
    #   super
    # end

    # GET /resource/edit
    # def edit
    #   super
    # end

    # PUT /resource
    # def update
    #   super
    # end

    # DELETE /resource
    # def destroy
    #   resource.soft_delete
    #   Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    #   set_flash_message :notice, :destroyed
    #   yield resource if block_given?
    #   respond_with_navigational(resource) { redirect_to after_sign_out_path_for(resource_name) }
    # end

    # GET /resource/cancel
    # Forces the session data which is usually expired after sign
    # in to be expired now. This is useful if the user wants to
    # cancel oauth signing in/up in the middle of the process,
    # removing all OAuth session data.
    # def cancel
    #   super
    # end

    protected

    # # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_up_params
    #   devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])
    # end

    # # If you have extra params to permit, append them to the sanitizer.
    # def configure_account_update_params
    #   # byebug
    #   devise_parameter_sanitizer.permit(:account_update, keys: %i[name])
    # end

    # # The path used after sign up.
    def after_sign_up_path_for(resource)
      dashboard_root_path(resource)
    end

    # # The path used after sign up for inactive accounts.
    # # def after_inactive_sign_up_path_for(resource)
    # #   super(resource)
    # # end
  end
end
