# frozen_string_literal: true

module Dashboard
  class ClaimsController < Dashboard::DashboardController
    def index
      @claims = current_user.claims.each(&:giveaway)
    end
  end
end
