class ListsFacade < ApplicationFacade
  def create_service
    @create_service ||= List::CreateService.new list_params
  end

  def list
    @list ||= List.find(params[:id])
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
