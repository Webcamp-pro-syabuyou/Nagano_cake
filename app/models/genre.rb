class Genre < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :name ,presence: true
  validates :is_active, inclusion: [true, false]
  # validates :is_active, presence: true　falseが入るとfalseが入ったときに弾かれてしまうので上の記述に変更
end
