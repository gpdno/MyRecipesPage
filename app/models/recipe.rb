class Recipe <ActiveRecord::Base
  belongs_to :chef
  has_many :likes
  validates :chef_id, presence: true
  validates :name, presence: true, length: { minimum: 5, maximum: 50 }
  validates :summary, presence: true, length: { minimum: 20, maximum: 150 }
  validates :description, presence: true, length: { minimum: 20, maximum: 500 }
  mount_uploader :picture, PictureUploader
  validate :picture_size
  default_scope -> { order(created_at: :desc) }
  
  def thumbs_up_total
    self.likes.where(like: true).size
  end
  
  def thunbs_down_total
    self.likes.where(like: false).size
  end
  
  private
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end