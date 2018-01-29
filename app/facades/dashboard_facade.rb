class DashboardFacade < ApplicationFacade
  def lists
    @lists ||=  if params[:task_filter].present?
                  List.active_search_for(params[:task_filter])
                else
                  List.active.eager_load(:tasks)
                end
  end

  def assignable_users_for(task)
    User.without_assignment_for(task)
  end

  def all_lists_but(list)
    List.without(list.id).active
  end
end
