# frozen_string_literal: true

ActiveAdmin.register Contact do
  
  permit_params :name, :email, :message

end
