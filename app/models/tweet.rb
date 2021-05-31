class Tweet < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :company
  belongs_to :texture
  belongs_to :user
  has_many_attached :images
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :company_id
    validates :texture_id
  end

  with_options presence: true do
    validates :text
    validates :name
  end

  def self.search(search)
    if search != ''
      Tweet.where('name LIKE(?)', "%#{search}%")
    else
      Tweet.all
    end
  end
end
