class Lists::TasksFacade < ApplicationFacade
  def create_service
    @create_service ||= ::Task::CreateService.new list, task_params
  end

  def list
    @list ||= List.find(params[:list_id])
  end

  private

  def task_params
    params.require(:task).permit(:title, :description)
  end
end
