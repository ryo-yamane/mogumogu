class Tweet < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :company
  belongs_to :texture
  belongs_to :user
  has_one_attached :image

  with_options numericality: { other_than: 1 } do
  validates :category_id
  validates :company_id
  validates :texture_id
  end

  with_options presence: true do
    validates :text
    validates :name
  end
end
