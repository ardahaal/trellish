class List
  class CreateService < ::Trellish::Service
    def initialize attributes
      @attributes = attributes
    end

    def call
      l = list
      if l.save
        result(:success) {self.list = l}
      else
        result(:error) {self.list = l}
      end
    end

    private

    attr_reader :attributes

    def list
      @list ||= ::List.new.tap { |l| l.attributes = attributes }
    end
  end
end
