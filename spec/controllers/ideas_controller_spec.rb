require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
  let(:user) {FactoryGirl.create(:user)}
  let(:idea) {FactoryGirl.create(:idea)}

  describe '#new' do
    subject {get :new}

    context "with no user signed in" do
      it "redirects to the sign in page" do
        subject
        expect(response).to(redirect_to(new_session_path))
      end
    end

    context 'with user signed in' do
      before {request.session[:user_id] = user.id}

      it 'redirects to the new ideas form' do
        subject
        expect(assigns(:idea)).to be_a_new(Idea)
      end
    end
  end

  describe '#create' do
    subject {post :create, params: {idea: FactoryGirl.attributes_for(:idea, title: 'valid title123', description: 'valid description456', user_id: user.id)}}

    context 'with no user signed in' do
      it 'redirects to the sign in page' do
        subject
        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'with user signed in' do
      before {request.session[:user_id] = user.id}

      context 'with valid attributes' do
        it 'creates a new idea' do
          expect{subject}.to change(Idea, :count).by(1)
        end

        it 'redirects to the idea show page' do
          subject
          expect(response).to redirect_to(Idea.last)
        end

        it 'sets a flash notice message' do
          subject
          expect(flash[:notice]).to eql("Successfully created!")
        end

        it 'associates the idea to the user' do
          subject
          expect(Idea.last.user).to eq(user)
        end
      end
    end
  end
  # describe "GET #new" do
  #   it "returns http success" do
  #     get :new
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe "GET #show" do
  #   it "returns http success" do
  #     get :show
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe "GET #destroy" do
  #   it "returns http success" do
  #     get :destroy
  #     expect(response).to have_http_status(:success)
  #   end
  # end
end
