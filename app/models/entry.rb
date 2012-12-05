class Entry < ActiveRecord::Base
  
  KEY = "x5-p8fzo7juV2R4DOc5MQ3AF83oUe3t7"
  
  # attr_accessible :title, :body
  belongs_to :author, :class_name => "User", :foreign_key => "user_id"
  belongs_to :subnet
  #has_and_belongs_to :tags

  validates_presence_of :author
  validates_presence_of :subnet

  validates_presence_of :server_name
  validates_length_of  :server_name, :maximum => 255

  validates_presence_of :model
  validates_length_of  :model, :maximum => 255

  validates_presence_of :operating_system
  validates_length_of  :operating_system, :maximum => 100

  validates_presence_of :serial_number
  validates_length_of  :serial_number, :maximum => 255

  validates_presence_of :ip
  validates_length_of  :ip, :maximum => 15

  before_save :encrypt_username_password
  after_save :decrypt_username_password
  after_find :decrypt_username_password

  private
  
  def encrypt_username_password    
    if username != nil
      self.username = Security.encrypt(KEY, self.username)
    end
    if password != nil
      self.password = Security.encrypt(KEY, self.password)
    end
  end
  
  def decrypt_username_password
    key = "x5-p8fzo7juV2R4DOc5MQ3AF83oUe3t7"
    if username != nil
      self.username = Security.decrypt(key, self.username)
    end
    if password != nil
      self.password = Security.decrypt(key, self.password)
    end
  end
end
