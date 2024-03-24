class Person < ApplicationRecord
  belongs_to :membership
  has_many :emails
  has_many :phones
  has_many :addresses
end
