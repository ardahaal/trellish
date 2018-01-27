require 'rails_helper'

RSpec.describe User, type: :model do
  subject { user }

  let(:user) { build(:user) }

  describe "validations" do
    context "correct attributes" do
      it { expect(subject).to be_valid }
    end

    context "blank attributes" do
      it "should not be valid" do
        %i(name email password).each do |attr|
          subject.send("#{attr}=", nil)
          expect(subject).not_to be_valid
          expect(subject.errors.details[attr]).to include({error: :blank})
        end
      end
    end

    context "password doesn't match regex" do
      it "should not be valid" do
        ["ABC123", "abc123", "ABCabc"].each do |password|
          subject.password = password
          expect(subject).not_to be_valid
          expect(subject.errors[:password]).to be_present
        end
      end
    end
  end

  describe "associations" do
    context "assignments and tasks" do
      let(:user) { create(:user, :with_assignments, number_of_tasks: 10) }

      it { expect(subject).to be_valid }
      it { expect(subject.tasks.count).to eq(10) }
      it { expect(subject.assignments.count).to eq(10) }
    end
  end
end
