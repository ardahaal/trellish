require "rails_helper"

describe List::CreateService do
  let(:service) { described_class.new(attributes) }

  describe "#call" do
    subject { service.call }

    context "valid attributes" do
      let(:attributes) { {name: FFaker::Lorem.phrase} }

      it { expect(List.count).to eq(0) }
      it "should create new list" do
        expect(subject.success).to be_truthy
        expect(List.count).to eq(1)
        expect(subject.data.list.id).not_to be_nil
        expect(subject.data.list.name).to eq(attributes[:name])
      end
    end

    context "invalid attributes" do
      context "blank" do
        let(:attributes) { {name: ''} }

        it { expect(List.count).to eq(0) }
        it "should create new list" do
          expect(subject.success).to be_falsy
          expect(List.count).to eq(0)
          expect(subject.data.list.errors[:name]).to be_present
        end
      end

      context "too long name" do
        let(:attributes) { {name: 'A' * 101} }

        it { expect(List.count).to eq(0) }
        it "should create new list" do
          expect(subject.success).to be_falsy
          expect(List.count).to eq(0)
          expect(subject.data.list.errors[:name]).to be_present
        end
      end
    end
  end
end
