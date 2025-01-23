class Users::Create < ApplicationInteraction
  string :name, :email, :gender, :patronymic, :country, :surname, :nationality
  integer :age
  array :interests, default: []
  array :skills, default: []

  validates :name, :patronymic, :email, :age, :nationality, :country, :gender, presence: true
  validates :age, numericality: { greater_than: 0, less_than_or_equal_to: 90 }
  validates :gender, inclusion: { in: %w[male female] }
  validate :check_user_email

  def to_model
    User.new
  end

  def execute
    full_name = "#{surname} #{name} #{patronymic}".strip
    user = User.new(inputs.except(:interests, :skills).merge(full_name:))

    if user.save
      attach_interests(user)
      attach_skills(user)
    else
      errors.merge!(user.errors)
    end
    user
  end

  private

  def attach_interests(user)
    user.interests = Interest.where(name: interests)
  end

  def attach_skills(user)
    user.skills = Skill.where(name: skills)
  end

  def check_user_email
    User.where(email:).empty?
  end
end


# Нужно:
# 1. Использовать gem ActiveInteraction => https://github.com/AaronLasseigne/active_interaction отрефакторить класс Users::Create+
# 6. При рефакторнге кода использовать Декларативное описание(подход в программировании)+
# 2. Исправить опечатку Skil. Есть 2 пути решения. Описать оба. +
# 3. Исправить связи +
# 4. Поднять Rails приложение и в нем использовать класс Users::Create+
# 7. nestes attributes +
# 5. Написать тесты
