# frozen_string_literal: true

ActiveAdmin.register Claim do

  permit_params :giveaway_id, :user_id

end
