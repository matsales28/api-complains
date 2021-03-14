class Locale
  include Mongoid::Document
  include Mongoid::Timestamps
  field :city, type: String
  field :state, type: String
  field :country, type: String
  field :complains_count, type: Integer, default: 0

  validates_presence_of :city, :state, :country
  validates :city, uniqueness:  {scope: [:country, :state]}
  has_many :complains
end
