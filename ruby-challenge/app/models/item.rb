class Item < ApplicationRecord
  enum status: [:pending, :read, :made, :filed,]
  paginates_per 1
end
