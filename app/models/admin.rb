class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :goals
  has_many :tiers
  has_one :setting
  has_many :invoices

  # Overrides Create to add Settings when created
  after_create do
    s = Setting.create(
      admin_id: self.id,
      currency: 'USD',
    )
  end
end
