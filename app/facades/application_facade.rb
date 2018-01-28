class ApplicationFacade
  attr_reader :request

  def initialize request
    @request = request
  end

  protected

  def params
    @params ||= ActionController::Parameters.new request.params
  end
end
