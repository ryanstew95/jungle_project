class Category < ApplicationRecord
  # attr_accessor :name, :description
  has_many :products

end
