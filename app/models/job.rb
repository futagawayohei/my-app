class Job < ApplicationRecord
  belongs_to :user
  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
  validates :burn_at, presence: true, length: { maximum: 255 }
  validates :calorie, presence: true, length: { maximum: 255 }
end
