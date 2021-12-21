ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    panel 'Recent messages to team' do
      ul do
        Contact.order(created_at: :desc).first(5).map do |c|
          li link_to(c.message, admin_contact_path(c))
        end
      end
    end
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel 'Recent Giveaways' do
          ul do
            Giveaway.order(created_at: :desc).first(5).map do |g|
              li link_to(g.title, admin_giveaway_path(g))
            end
          end
        end
      end

      # column do
      #   panel 'Info' do
      #     para 'Welcome to ActiveAdmin.'
      #   end
      # end
    end
  end
end
