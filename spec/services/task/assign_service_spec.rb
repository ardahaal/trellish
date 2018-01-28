require "rails_helper"

describe Task::AssignService do
  let!(:user_1)     { create(:user) }
  let!(:user_2)     { create(:user) }
  let!(:task)       { create(:task) }
  let(:service)     { described_class.new(task, attributes) }

  describe "#call" do
    subject { service.call }

    it { expect(task.assignments.count).to eq(0) }

    context "single User id" do
      let(:attributes) { user_1 }

      it { expect(subject.success?).to be_truthy }
      it { expect(subject.data.task.assignments.count).to eq(1) }
      it { expect(subject.data.task.assignments.first.user).to eq(user_1) }
    end

    context "multiple User ids" do
      let(:attributes) { User.all }

      it { expect(subject.success?).to be_truthy }
      it { expect(subject.data.task.assignments.count).to eq(2) }
    end
  end
end
