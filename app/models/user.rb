class User < ApplicationRecord
  has_and_belongs_to_many :interests
  has_and_belongs_to_many :skills
  accepts_nested_attributes_for :interests, :skills
end
