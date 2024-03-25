class Person < ApplicationRecord
  belongs_to :membership
  has_many :emails, dependent: :destroy
  has_many :phones, dependent: :destroy
  has_many :addresses, dependent: :destroy
end
