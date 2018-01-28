class Lists::TasksFacade < ApplicationFacade
  def create_service
    @create_service ||= ::Task::CreateService.new list, task_params.except(:list_id)
  end

  def update_service
    @update_service ||= ::Task::UpdateService.new task, task_params
  end

  def list
    @list ||= List.find(params[:list_id])
  end

  def task
    @task ||= Task.find(params[:id])
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :list_id)
  end
end
