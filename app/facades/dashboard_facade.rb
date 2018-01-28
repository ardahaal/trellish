class DashboardFacade < ApplicationFacade
  def lists
    @lists ||= List.active.eager_load(:tasks)
  end
end
