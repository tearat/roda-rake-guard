require 'active_record'

class Book < ActiveRecord::Base
  belongs_to :shop
end
