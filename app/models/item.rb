class Item < ApplicationRecord
	attr_accessor :num

	has_many :carts
end
