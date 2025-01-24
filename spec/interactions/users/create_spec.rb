require 'rails_helper'

RSpec.describe Users::Create, type: :interaction do
  let!(:interest1) { create(:interest, name: 'Reading') }
  let!(:interest2) { create(:interest, name: 'Gaming') }
  let!(:skill1) { create(:skill, name: 'Ruby') }
  let!(:skill2) { create(:skill, name: 'Rails') }

  let(:valid_user_params) do
    {
      name: 'Maxim',
      surname: 'Petrov',
      patronymic: 'Andreevich',
      email: 'max@example.com',
      age: 30,
      nationality: 'Russian',
      country: 'Russia',
      gender: 'male',
      interests: ['Reading', 'Gaming'],
      skills: ['Ruby', 'Rails']
    }
  end

  context 'when params are valid' do
    it 'creates a user with correct attributes' do
      result = described_class.run(valid_user_params)

      expect(result.valid?).to be_truthy
      expect(result.result).to be_a(User)
      expect(result.result.interests.pluck(:name)).to match_array(['Reading', 'Gaming'])
      expect(result.result.skills.pluck(:name)).to match_array(['Ruby', 'Rails'])
    end
  end

  context 'when params are valid' do
    it 'creates a user with correct attributes wo associations' do
      result = described_class.run(valid_user_params.except(:interests, :skills))

      expect(result.valid?).to be_truthy
      expect(result.result).to be_a(User)
      expect(result.result.interests.size).to eq(0)
      expect(result.result.skills.size).to eq(0)
    end
  end

  context 'when any param is invalid' do
    it 'not creates user when name is blank' do
      result = described_class.run(valid_user_params.merge(name: ''))

      expect(result.valid?).to be_falsey
      expect(result.errors.full_messages).to include("Name can't be blank")
    end

    it 'not creates user when email is blank' do
      result = described_class.run(valid_user_params.merge(email: ''))

      expect(result.valid?).to be_falsey
      expect(result.errors.full_messages).to include("Email can't be blank")
    end

    it 'not creates user when patronymic is blank' do
      result = described_class.run(valid_user_params.merge(patronymic: ''))

      expect(result.valid?).to be_falsey
      expect(result.errors.full_messages).to include("Patronymic can't be blank")
    end

    it 'not creates user when country is blank' do
      result = described_class.run(valid_user_params.merge(country: ''))

      expect(result.valid?).to be_falsey
      expect(result.errors.full_messages).to include("Country can't be blank")
    end

    it 'not creates user when age is blank' do
      result = described_class.run(valid_user_params.merge(age: ''))

      expect(result.valid?).to be_falsey
      expect(result.errors.full_messages).to include("Age is required")
    end

    it 'not creates user when age invalid' do
      result = described_class.run(valid_user_params.merge(age: 99))

      expect(result.valid?).to be_falsey
      expect(result.errors.full_messages).to include("Age must be less than or equal to 90")
    end

    it 'not creates user when age invalid' do
      result = described_class.run(valid_user_params.merge(age: 0))

      expect(result.valid?).to be_falsey
      expect(result.errors.full_messages).to include("Age must be greater than 0")
    end

    it 'not creates user when nationality is blank' do
      result = described_class.run(valid_user_params.merge(nationality: ''))

      expect(result.valid?).to be_falsey
      expect(result.errors.full_messages).to include("Nationality can't be blank")
    end

    it 'not creates user when gender is blank' do
      result = described_class.run(valid_user_params.merge(gender: ''))

      expect(result.valid?).to be_falsey
      expect(result.errors.full_messages).to include("Gender can't be blank")
    end

    it 'not creates user when gender is incorrect' do
      result = described_class.run(valid_user_params.merge(gender: 'fmale'))

      expect(result.valid?).to be_falsey
      expect(result.errors.full_messages).to include("Gender is not included in the list")
    end

    it 'not creates user with same email' do
      user_with_same_email = create(:user, email: 'max@example.com')
      result = described_class.run(valid_user_params)

      expect(result.valid?).to be_falsey
      expect(result.errors.full_messages).to include("Email already exists")
    end
  end
end
