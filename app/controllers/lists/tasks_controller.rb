class Lists::TasksController < ApplicationController
  before_action :require_login

  expose(:facade) { Lists::TasksFacade.new(request) }

  def new
    @task ||= facade.list.tasks.build
  end

  def create
    result = facade.create_service.call

    if result.success?
      redirect_to(root_path, flash: { success: "Task created" })
    else
      @task = result.data.task
      flash[:error] = @task.errors.to_a.join(". ")
      render(:new)
    end
  end

  def update
    result = facade.update_service.call
    flash = result.success? ? { success: "Task updated" } : { error: result.data.task.errors.to_a.join(". ") }
    redirect_to(root_path, flash: flash)
  end

  def assign
    result = facade.assign_service.call
    redirect_to(root_path, flash: { success: "Task assigned" })
  end
end
