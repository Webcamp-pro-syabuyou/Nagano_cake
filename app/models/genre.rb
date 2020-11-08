class Genre < ApplicationRecord
  has_many :products, dependent: :destroy
  
  enum is_active: {true: true, false: false}
  validates :name ,presence: true
  validates :is, presence: true
end
