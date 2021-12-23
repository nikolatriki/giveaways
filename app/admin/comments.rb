ActiveAdmin.register Comment do

  permit_params :body, :giveaway_id, :user_id
  
end
