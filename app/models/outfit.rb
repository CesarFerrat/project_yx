class Outfit < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :client
  has_many :items


end
