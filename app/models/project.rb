class Project < ApplicationRecord

  validates :name, :length  => { :maximum => 40 }
  validates :description, :length  => { :maximum => 240 }

  belongs_to :customer

end
