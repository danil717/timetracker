class Project < ApplicationRecord

  validates :name, :length  => { :maximum => 40 }
  validates :description, :length  => { :maximum => 240 }

  belongs_to :customer
  has_many :tasks

  scope :projects_for_customer, -> {
  	select('projects.*').joins(:customer)
  }
end
