class Customer < ApplicationRecord

  validates :name, :length  => { :maximum => 40 }


 
  has_many :projects

end
