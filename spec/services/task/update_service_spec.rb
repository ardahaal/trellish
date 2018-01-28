require "rails_helper"

describe Task::UpdateService do
  let!(:list)       { create(:list) }
  let!(:task)       { create(:task) }
  let(:service)     { described_class.new(task, attributes) }
  let(:attributes)  {
                      {
                        title:        "New title",
                        description:  "New description",
                        list_id:      list.id
                      }
                    }

  describe "#call" do
    subject { service.call }

    context "valid attributes" do
      it "should update given task" do
        expect(subject.success?).to be_truthy
        expect(subject.data.task.title).to eq(attributes[:title])
        expect(subject.data.task.description).to eq(attributes[:description])
        expect(subject.data.task.list).to eq(list)
      end
    end

    context "invalid attributes" do
      context "blanks" do
        let(:attributes)  {
                            {
                              title:        '',
                              description:  ''
                            }
                          }

        it "should not update task" do
          expect(subject.success?).to be_falsy
          expect(subject.data.task.errors[:title]).to be_present
          expect(subject.data.task.errors[:description]).to be_present
        end
      end
    end
  end
end
