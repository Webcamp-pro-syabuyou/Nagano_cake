class Genre < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :name ,presence: true
  # validates :is_active, presence: true
  # falseが入るとpresence: trueが反応する？
end
