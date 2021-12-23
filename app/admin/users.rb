# frozen_string_literal: true

ActiveAdmin.register User do
  index do
    selectable_column
    column :id
    column :name
    column :email
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :name
      row :email
      row :created_at
      row :updated_at
      row :reset_password_token
      row :reset_password_sent_at
      row :remember_created_at
      row :giveaways
      row :claims
      row :comments
    end
  end

  permit_params :name, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at
end
