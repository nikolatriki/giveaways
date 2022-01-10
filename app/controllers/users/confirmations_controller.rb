# frozen_string_literal: true

module Users
  class ConfirmationsController < Devise::ConfirmationsController
    private

    def after_confirmation_path_for(_resource_name, _resource)
      # sign_in(_resource) # In case you want to sign in the user
      new_user_session_path
    end
  end
end
