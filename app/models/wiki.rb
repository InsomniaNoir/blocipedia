class Wiki < ActiveRecord::Base
  #include Searchable
  belongs_to :user
end
