class Group < ActiveRecord::Base
  resourcify
  
  has_many :users, dependent: :destroy
end
