class Task
  class UpdateService < ::Trellish::Service
    def initialize task, attributes
      @task = task
      @attributes = attributes
    end

    def call
      t = task
      t.attributes = attributes

      if t.save
        result(:success) {self.task = t}
      else
        result(:error) {self.task = t}
      end
    end

    private

    attr_reader :task, :attributes
  end
end
