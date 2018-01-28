class DashboardFacade < ApplicationFacade
  def lists
    @lists ||= List.active
  end
end
