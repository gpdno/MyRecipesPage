class Recipe <ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 5, maximum: 50 }
  validates :summary, presence: true, length: { minimum: 20, maximum: 150 }
  validates :description, presence: true, length: { minimum: 20, maximum: 500 }
end