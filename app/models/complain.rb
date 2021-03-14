class Complain
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :description, type: String
  field :company, type: String

  belongs_to :locale, counter_cache: true
  validates_presence_of :title, :description, :company, :locale
end
