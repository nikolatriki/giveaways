# frozen_string_literal: true

module Dashboard
  class PagesController < Dashboard::DashboardController
    def home
      claims = Claim.all.uniq(&:giveaway_id)
      uniq_giveaways = claims.map(&:giveaway)

      @given_giveaways = uniq_giveaways.select do |given|
        given.user_id == current_user.id
      end
      @claims = current_user.claims.each(&:giveaway)
    end
  end
end
