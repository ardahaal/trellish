class Task
  class AssignService < ::Trellish::Service
    def initialize task, *user_ids
      @task = task
      @user_ids = user_ids.first.is_a?(User) ? user_ids : user_ids.first
    end

    def call
      t = task

      user_ids.each do |id|
        user = User.where(id: id).first
        t.assignments.create(user: user) if user && !t.users.include?(user)
      end

      result(:success) {self.task = t}
    end

    private

    attr_reader :task, :user_ids
  end
end
