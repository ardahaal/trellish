require 'rails_helper'

describe Lists::TasksController do
  let!(:user) { create(:user) }
  let!(:list) { create(:list) }
  let(:params) { {list_id: list.id} }

  describe "GET #new" do
    context "when not signed in" do
      before { get(:new, params: params) }

      it { expect(response).not_to be_success }
      it { expect(response).to redirect_to(sign_in_path) }
      it { expect(assigns(:task)).to be_nil }
    end

    context "when signed in" do
      before { sign_in_as(user) }

      context "when invalid List id" do
        it { expect{ get(:new, params: {list_id: 0}) }.to raise_error(ActiveRecord::RecordNotFound) }
      end

      context "when valid List id" do
        before { get(:new, params: params) }

        it { expect(response).to be_success }
        it { expect(response).not_to redirect_to(sign_in_path) }
        it { expect(assigns(:task)).to be_kind_of(Task) }
      end
    end
  end

  describe "POST #create" do
    let(:params)  {
                    {
                      list_id: list.id,
                      task: {
                        title:        FFaker::Lorem.phrase,
                        description:  FFaker::Lorem.paragraph
                      }
                    }
                  }

    context "when not signed in" do
      before { post(:create, params: params) }

      it { expect(response).not_to be_success }
      it { expect(response).to redirect_to(sign_in_path) }
    end

    context "when signed in but with invalid List id" do
      let(:params)  {
                      {
                        list_id: 0,
                        task: {
                          title:        FFaker::Lorem.phrase,
                          description:  FFaker::Lorem.paragraph
                        }
                      }
                    }
        before { sign_in_as(user) }

        it { expect{ post(:create, params: params) }.to raise_error(ActiveRecord::RecordNotFound) }
    end

    context "when signed in" do
      before do
        sign_in_as(user)
        post(:create, params: params)
      end

      context "with invalid params" do
        context "blanks" do
          let(:params)  {
                          {
                            list_id: list.id,
                            task: {
                              title:        '',
                              description:  ''
                            }
                          }
                        }

          it { expect(Task.count).to eq(0) }
          it { expect(response).to render_template(:new) }
          it { expect(assigns(:task).list_id).to eq(list.id) }
        end
      end

      context "with valid params" do
        it { expect(response).to redirect_to(root_path) }
        it { expect(Task.count).to eq(1) }
        it { expect(Task.first.title).to eq(params[:task][:title]) }
        it { expect(Task.first.list).to eq(list) }
      end
    end
  end
end
