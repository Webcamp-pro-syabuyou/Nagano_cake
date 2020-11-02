class Genre < ApplicationRecord
  has_many :product, dependent: :destroy
end
