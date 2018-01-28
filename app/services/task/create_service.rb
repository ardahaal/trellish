class Task
  class CreateService < ::Trellish::Service
    def initialize list, attributes
      @list = list
      @attributes = attributes
    end

    def call
      return result(:error) {self.error = :list_not_found} unless list

      t = task
      if t.save
        result(:success) {self.task = t}
      else
        result(:error) {self.task = t}
      end
    end

    private

    attr_reader :list, :attributes

    def task
      @task ||= list.tasks.build.tap { |l| l.attributes = attributes }
    end
  end
end
