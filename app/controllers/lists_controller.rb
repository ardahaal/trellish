class ListsController < ApplicationController
  before_action :require_login

  expose(:facade) { ListsFacade.new(request) }

  def new
    @list ||= List.new
  end

  def create
    result = facade.create_service.call

    if result.success?
      redirect_to root_path
    else
      @list = result.data.list
      render :new
    end
  end

  def archive
    facade.list.archived!
    redirect_to root_path
  end
end
