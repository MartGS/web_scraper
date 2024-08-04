require 'sequel'
require_relative '../config/database'

class Product < Sequel::Model
  plugin :validation_helpers

  def validate
    super
    validates_presence [:name, :price]
  end
end
