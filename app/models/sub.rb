class Sub < ApplicationRecord
  validates :title, :description, presence: true

  before_action :require_login

  belongs_to :moderator,
  foreign_key: :moderator_id,
  class_name: :Moderator

  has_many :posts

end
