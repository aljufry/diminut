class User < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :username, :viewer, :editor, :name
  attr_protected :password, :salt
    
  attr_accessor :plain_password    
  
  has_many :entries
  has_many :subnets
  
  #validates_presence_of :username
  validates_length_of  :username, :minimum => 4, :maximum => 25  
  #validates_presence_of :password
  #validates_length_of  :password, :maximum => 255
  #validates_confirmation_of :password  
  validates_length_of  :plain_password, :within => 8..50, :on => :create  
  validates_uniqueness_of :username
  validates_format_of :username, :with => /^[A-Za-z\d_]+$/
  
  before_save :hash_plain_password
  after_save :clear_plain_password
  
  def self.authenticate(uname, pass)
    user = User.find_by_username(uname)
    if (user != nil)
      hashed_password = Security.hash_pass(pass, user.salt)      
      if hashed_password == user.password
        return user
      end
    end
    return false
  end
  
  private
  
  def hash_plain_password
    unless plain_password.blank?
      self.salt = Security.generate_salt
      self.password = Security.hash_pass(plain_password, salt)
    end    
  end
    
  def clear_plain_password
    self.plain_password = nil
  end
  
end
