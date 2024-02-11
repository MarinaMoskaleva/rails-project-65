class Web::ProfileController < Web::ApplicationController
  before_action :check_if_user_authorized

  def index
    @bulletins = Bulletin.where(user: current_user)
  end

end
