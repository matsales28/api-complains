class Complain
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :title, type: String
  field :description, type: String
  field :company, type: String
  
  validates_presence_of :title, :description, :company
end