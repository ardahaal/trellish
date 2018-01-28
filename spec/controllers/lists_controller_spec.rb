require 'rails_helper'

describe ListsController do
  let!(:user) { create(:user) }

  describe "GET #new" do
    context "when not signed in" do
      before { get(:new) }

      it { expect(response).not_to be_success }
      it { expect(response).to redirect_to(sign_in_path) }
      it { expect(assigns(:list)).to be_nil }
    end

    context "when signed in" do
      before do
        sign_in_as(user)
        get(:new)
      end

      it { expect(response).to be_success }
      it { expect(response).not_to redirect_to(sign_in_path) }
      it { expect(assigns(:list)).to be_kind_of(List) }
    end
  end

  describe "POST #create" do
    context "when not signed in" do
      let(:params) { {list: {name: FFaker::Lorem.phrase}} }
      before { post(:create, params: params) }

      it { expect(response).not_to be_success }
      it { expect(response).to redirect_to(sign_in_path) }
    end

    context "when signed in" do
      before do
        sign_in_as(user)
        post(:create, params: params)
      end

      context "with invalid params" do
        context "blank name" do
          let(:params) { {list: {name: ''}} }

          it { expect(List.count).to eq(0) }
          it { expect(response).to render_template(:new)  }
          it { expect(assigns(:list).name).to eq(params[:list][:name]) }
        end

        context "too long name" do
          let(:params) { {list: {name: 'A' * 101}} }

          it { expect(List.count).to eq(0) }
          it { expect(response).to render_template(:new)  }
          it { expect(assigns(:list).name).to eq(params[:list][:name]) }
        end
      end

      context "with valid params" do
        let(:params) { {list: {name: FFaker::Lorem.phrase}} }

        it { expect(response).to redirect_to(root_path) }
        it { expect(List.count).to eq(1) }
        it { expect(List.first.name).to eq(params[:list][:name]) }
      end
    end
  end

  describe "POST #archive" do
    let!(:list) { create(:list, status: :active) }
    let(:params) { {id: list.id} }

    it { expect(List.active.count).to eq(1) }
    it { expect(List.archived.count).to eq(0) }

    context "when not signed in" do
      before { post(:archive, params: params) }

      it { expect(response).not_to be_success }
      it { expect(response).to redirect_to(sign_in_path) }
    end

    context "when signed in" do
      context "with invalid List id" do
        let(:params) { {id: 0} }
        before { sign_in_as(user) }

        it { expect{ post(:archive, params: params) }.to raise_error(ActiveRecord::RecordNotFound) }
      end

      context "with valid List id" do
        before do
          sign_in_as(user)
          post(:archive, params: params)
        end

        it { expect(List.active.count).to eq(0) }
        it { expect(List.archived.count).to eq(1) }
        it { expect(response).to redirect_to(root_path) }
      end
    end
  end
end
