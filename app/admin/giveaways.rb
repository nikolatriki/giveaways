# frozen_string_literal: true

ActiveAdmin.register Giveaway do
  
  filter :title
  filter :location
  filter :user
  filter :created_at
  

  index do
    selectable_column
    column :id
    column :title
    column :description
    column :location
    column :user
    column :created_at
    actions
  end

  permit_params :title, :description, :location, :user_id
  
end
