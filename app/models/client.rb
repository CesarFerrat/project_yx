class Client < ActiveRecord::Base
  include PublicActivity::Common
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
acts_as_token_authenticatable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # validates_formatting_of :zip_code, using: :us_zip
  # validates_formatting_of :phone_number, using: :us_phone
  # validates_formatting_of :email, using: :email
  # validates_uniqueness_of :email


  belongs_to :user
  has_many :items
  has_many :outfits

  has_attached_file :avatar, styles: { full: '500x500#', medium: '300x300#', thumb: '100x100#' }, default_url: '/images/:style/missing.png'

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates_attachment_size :avatar, less_than: 15.megabytes

end
