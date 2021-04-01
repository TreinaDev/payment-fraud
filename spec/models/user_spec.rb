require 'rails_helper'

describe User, type: :model do
  context 'validation' do
    it 'attributes connet be blank' do
      user = User.new

      expect(user.valid?).to eq false
      expect(user.errors.count).to eq 4
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end
end
