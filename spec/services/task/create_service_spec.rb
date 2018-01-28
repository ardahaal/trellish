require "rails_helper"

describe Task::CreateService do
  let!(:list)       { create(:list) }
  let(:service)     { described_class.new(list, attributes) }
  let(:attributes)  {
                      {
                        title:        FFaker::Lorem.phrase,
                        description:  FFaker::Lorem.paragraph
                      }
                    }

  describe "#call" do
    subject { service.call }

    context "valid attributes" do
      it { expect(Task.count).to eq(0) }
      it "should create new task" do
        expect(subject.success?).to be_truthy
        expect(Task.count).to eq(1)
        expect(subject.data.task.id).not_to be_nil
        expect(subject.data.task.title).to eq(attributes[:title])
        expect(subject.data.task.list).to eq(list)
      end
    end

    context "invalid attributes" do
      context "invalid List id" do
        let!(:list) { nil }

        it { expect(Task.count).to eq(0) }
        it "should not create new list" do
          expect(subject.success?).to be_falsy
          expect(Task.count).to eq(0)
          expect(subject.data.error).to eq(:list_not_found)
        end
      end

      context "blanks" do
        let(:attributes)  {
                            {
                              title:        '',
                              description:  ''
                            }
                          }

        it { expect(Task.count).to eq(0) }
        it "should not create new list" do
          expect(subject.success?).to be_falsy
          expect(Task.count).to eq(0)
          expect(subject.data.task.errors[:title]).to be_present
          expect(subject.data.task.errors[:description]).to be_present
        end
      end
    end
  end
end
