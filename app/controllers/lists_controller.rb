class ListsController < ApplicationController
  before_action :require_login

  expose(:facade) { ListsFacade.new(request) }

  def new
    @list ||= List.new
  end

  def create
    result = facade.create_service.call

    if result.success?
      redirect_to(root_path, flash: { success: "List created" })
    else
      @list = result.data.list
      flash[:error] = @list.errors.to_a.join(". ")
      render(:new)
    end
  end

  def archive
    facade.list.archived!
    redirect_to(root_path, flash: { success: "List archived" })
  end
end
