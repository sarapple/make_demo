class User < ActiveRecord::Base
  belongs_to :state
  has_many :blogs
end
