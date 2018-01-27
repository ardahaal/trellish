require 'rails_helper'

RSpec.describe Task, type: :model do
  subject { task }

  let(:task) { build(:task) }

  describe "validations" do
    context "correct attributes" do
      it {expect(subject).to be_valid }
    end

    context "blank attributes" do
      it "should not be valid" do
        %i(title description).each do |attr|
          subject.send("#{attr}=", nil)
          expect(subject).not_to be_valid
          expect(subject.errors.details[attr]).to include({error: :blank})
        end
      end
    end
  end

  describe "associations" do
    context "users" do
      let(:users) { create_list(:user, 2) }

      before do
        subject.save && subject.reload
        users.each { |u| u.assignments << create(:assignment, task: subject, user: u) && u.save! }
      end

      it { expect(subject.users.count).to eq(2) }
    end
  end

  describe "scopes" do
    context "#like" do
      let!(:archived_list)  { create(:archived_list) }
      let!(:task_1)         { create(:task, title: "Test") }
      let!(:task_2)         { create(:task, title: "Test", list: archived_list) }
      let!(:task_3)         { create(:task, title: "ABC") }

      it "setup" do
        expect(List.archived.count).to eq(1)
        expect(List.active.count).to eq(2)
        expect(Task.count).to eq(3)
      end

      it "should return proper results (regardless lowercase or uppercase letters)" do
        expect(Task.like("es").count).to eq(1)
        expect(Task.like("es")).to include(task_1)

        expect(Task.like("B").count).to eq(1)
        expect(Task.like("B")).to include(task_3)

        expect(Task.like("xx").count).to eq(0)
      end
    end
  end
end
