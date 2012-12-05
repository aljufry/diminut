class Tag < ActiveRecord::Base
  # attr_accessible :title, :body
  #has_and_belongs_to :entries
  
  validates_presence_of :title
  validates_length_of  :title, :maximum => 255
end
