# frozen_string_literal: true

module Dashboard
  class GiveawaysController < Dashboard::DashboardController
    before_action :find_giveaway, only: %i[show edit update destroy]
    before_action :giveaway_authorization, only: %i[show edit update destroy]

    def index # rubocop:disable Metrics/AbcSize
      @giveaways = current_user.giveaways.order(created_at: :desc)

      claims = Claim.all.uniq(&:giveaway_id)
      uniq_giveaways = claims.map(&:giveaway)

      @waiting_response_my_giveaways = uniq_giveaways.select do |giveaway|
        giveaway.user_id == current_user.id && giveaway.approved_to.nil?
      end

      @given_giveaways = uniq_giveaways.select do |given|
        given.user_id == current_user.id && !given.approved_to.nil?
      end

      @not_claimed_giveaways = @giveaways - @waiting_response_my_giveaways - @given_giveaways
    end

    def show
      @comments = @giveaway.comments.order(created_at: :desc)

      @comment = @giveaway.comments.build
    end

    def new
      @giveaway = Giveaway.new
    end

    def create
      @giveaway = Giveaway.new(giveaway_params)
      @giveaway.user_id = current_user.id

      if @giveaway.save
        redirect_to [:dashboard, @giveaway], notice: t('controllers.dashboard.giveaways.notice')
      else
        render :new
      end
    end

    def edit; end

    def update
      if @giveaway.update(giveaway_params)

        ApproveMailer.new_approve(@giveaway).deliver_now unless @giveaway.approved_to.nil?

        redirect_to [:dashboard, @giveaway], notice: 'Success!'
      else
        render :edit
      end
    end

    def destroy
      @giveaway.destroy

      redirect_to dashboard_giveaways_path, alert: t('controllers.giveaways.alert')
    end

    private

    def giveaway_params
      params.require(:giveaway).permit(:title, :description, :location, :approved_to, :search,
                                       pictures_attributes: %i[id title image _destroy])
    end

    def find_giveaway
      @giveaway = Giveaway.find(params[:id])
    end

    def giveaway_authorization
      authorize @giveaway
    end
  end
end
