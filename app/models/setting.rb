class Setting < ApplicationRecord
  belongs_to :admin

  has_one_attached :profile_pic
  has_one_attached :header_pic
end
