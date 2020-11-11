class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_products, dependent: :destroy
  has_many :in_cart_products, through: :cart_products, source: :product

  has_many :orders, dependent: :destroy
  has_many :order_products, through: :orders
  has_many :purchased_products, through: :order_products, source: :product

  has_many :addresses, dependent: :destroy

  # ログインする時に退会済み(is_deleted==true)のユーザーを弾くアクション
  def active_for_authentication?
    super && (self.is_deleted == false)
  end



  # バリデーション---------------------------------------------------
  validates :family_name, presence: true
  validates :first_name, presence: true
  validates :address, presence: true
  validates :tel, presence: true
  validates :postalcode, format: {with: /\A[0-9]{7}\z/}
  validates :family_name_kana, presence: true, format: {
                  with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/
                }
  validates :first_name_kana, presence: true, format: {
                  with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/
                }


  # validates :postalcode ,presence: :true, format: {
  #               with: / \A[0-9０-９]+\z/
  #               }
  # validates :address ,presence: :true
  # validates :tel ,presence: :true, format: {
  #               with: /\A[0-9０-９]+\z/
  #               }
  # -------------------------------------------------------------------
end