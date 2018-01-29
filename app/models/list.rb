class List < ApplicationRecord
  STATUSES = %w(active archived)

  has_many :tasks, dependent: :destroy

  enum status:  [:active, :archived]

  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :name,   presence: true, length: { maximum: 100 }

  scope :without,           -> (id)    { where.not(id: id) }
  scope :with_task_like,    -> (query) { eager_load(:tasks).where("tasks.title iLIKE '%#{query}%'") }
  scope :active_search_for, -> (query) { with_task_like(query).active }
end
