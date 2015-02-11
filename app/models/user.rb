class User < ActiveRecord::Base
  	belongs_to :state
  	has_many :blogs
	has_secure_password
end
