class Task < ApplicationRecord
  belongs_to :list
  has_many   :assignments
  has_many   :users, through: :assignments, dependent: :destroy

  validates :title,       presence: true
  validates :description, presence: true
  validates :list_id,     presence: true

  scope :like, -> (query) { joins(:list).merge(List.active).where("title iLIKE '%#{query}%'") }
end
