class Micropost < ActiveRecord::Base
  resourcify
  
  belongs_to :user
end
