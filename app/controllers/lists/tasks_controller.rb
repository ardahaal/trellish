class Lists::TasksController < ApplicationController
  before_action :require_login

  expose(:facade) { Lists::TasksFacade.new(request) }

  def new
    @task ||= facade.list.tasks.build
  end

  def create
    result = facade.create_service.call

    if result.success?
      redirect_to root_path
    else
      @task = result.data.task
      render :new
    end
  end

  def update
    result = facade.update_service.call
    redirect_to root_path
  end
end
