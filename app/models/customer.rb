class Customer < ApplicationRecord

  validates :name, :length  => { :maximum => 40 }

  has_many :projects
  belongs_to :user
end
