require 'rails_helper'

RSpec.describe List, type: :model do
  subject { list }

  let(:list) { build(:list) }

  describe "validations" do
    context "correct attributes" do
      it {expect(subject).to be_valid }
    end

    context "blank name" do
      before { subject.name = nil }

      it "should not be valid" do
        expect(subject).not_to be_valid
        expect(subject.errors.details[:name]).to include({error: :blank})
      end
    end

    context "too long name" do
      before { subject.name = 'A' * 101 }

      it "should not be valid" do
        expect(subject).not_to be_valid
        expect(subject.errors.details[:name]).to include({error: :too_long, count: 100})
      end
    end
  end

  describe "status" do
    context "when active" do
      it { expect(subject.active?).to be_truthy }
    end

    context "when archived" do
      let(:list) { build(:archived_list) }

      it { expect(subject.archived?).to be_truthy }
    end
  end

  describe "associations" do
    context "tasks" do
      let(:task) { create(:task, list: subject) }

      before do
        subject.save && subject.reload
        task
      end

      it { expect(subject.tasks).to include(task) }
    end
  end
end
