# frozen_string_literal: true

module Dashboard
  class ClaimsController < Dashboard::DashboardController
    def index
      @claimed_giveaways = current_user.claims.map(&:giveaway)
    end
  end
end
