# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { minimum: 6, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10, maximum: 3000 }
  has_many :article_categories, dependent: :destroy
  has_many :categories, through: :article_categories
  has_rich_text :description
end
