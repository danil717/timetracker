class Project < ApplicationRecord

  validates :name, :length  => { :maximum => 40 }
  validates :description, :length  => { :maximum => 240 }

  belongs_to :customer
  has_many :tasks

  def self.search_by(search_term)
    where("LOWER(name) LIKE :search_term OR LOWER(description) LIKE :search_term", search_term: "%#{search_term.downcase}%")  	
  end

end
