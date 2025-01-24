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
    errors.add(:email, 'already exists') if User.where(email:).present?
  end
end
