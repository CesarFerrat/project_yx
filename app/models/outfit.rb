class Outfit < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :client
  has_many :items

  has_attached_file :outfit_picture, styles: { full: '1200x1200>', medium: '300x300>', thumb: '100x100>' }, default_url: '/images/:style/missing.png'

  validates_attachment_content_type :outfit_picture, content_type: /\Aimage\/.*\Z/
  validates_attachment_size :outfit_picture, less_than: 15.megabytes

  def self.without_deleted  #in order to display outfitss without the ones we soft deleted
    where(deleted_at: nil)
  end

  def self.search(search) #categrory filter for client's items
    if search
     where('category LIKE ?', "%#{search}%")
    else
     all
    end
  end


end
