class Skill < ApplicationRecord
  has_and_belongs_to_many :users
  # Исправление опечатки Skil
  # 1 - переименовать в Skill и везде использовать Skill
  # 2 - использовать class_name: 'Skil' в ассоциации и в самой модели self.table_name = 'skills'
end
