class List < ApplicationRecord
  STATUSES = %w(active archived)

  enum status:  [:active, :archived]

  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :name,   presence: true, length: { maximum: 100 }
end
