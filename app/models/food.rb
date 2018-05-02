class Food < ApplicationRecord
  belongs_to :user
  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
  validates :ate_at, presence: true, length: { maximum: 255 }
  validates :fat, presence: true, length: { maximum: 255 }
end
