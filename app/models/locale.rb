class Locale
  include Mongoid::Document
  include Mongoid::Timestamps
  field :city, type: String
  field :state, type: String
  field :country, type: String

  validates_presence_of :city, :state, :country
  has_many :complains
end
