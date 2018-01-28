class DashboardController < ApplicationController
  before_action :require_login

  expose(:facade) { DashboardFacade.new(request) }

  def index
  end
end
