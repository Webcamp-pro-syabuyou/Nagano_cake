class Genre < ApplicationRecord
  has_many :products, dependent: :destroy
  
  enum is_genres_status: {true: true, false: false}
  validates :name ,presence: true
  validates :is_genres_status, presence: true
end
