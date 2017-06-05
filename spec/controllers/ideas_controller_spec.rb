require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
  let(:user) {FactoryGirl.create(:user)}
  let(:idea) {FactoryGirl.create(:idea)}


  describe '#new' do

    context "with no user signed in" do
      it "redirects to the sign in page" do
        get :new
        expect(response).to(redirect_to(new_session_path))
      end
    end # close context

    context 'with user signed in' do
      before {request.session[:user_id] = user.id}
      it 'redirects to the new ideas form' do
        get :new
        expect(assigns(:idea)).to be_a_new(Idea)
      end
    end # close context
  end # close describe #new


  describe '#create' do
    context 'with no user signed in' do
      it 'redirects to the sign in page' do
        get :new
        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'with user signed in' do
      before {request.session[:user_id] = user.id}

      context 'with valid attributes' do

        def valid_request
          post :create, params: { idea: FactoryGirl.attributes_for(:idea, title:'valid title123', description:'valid description456', user_id: user.id)}
        end

        it 'creates a new idea' do
          count_before = Idea.count
          valid_request
          count_after = Idea.count
          expect(count_after).to eq(count_before + 1)
        end

        it 'redirects to the idea show page' do
          valid_request
          expect(response).to redirect_to(Idea.last)
        end

        it 'sets a flash notice message' do
          valid_request
          expect(flash[:notice]).to be
        end

        it 'associates the idea to the user' do
          valid_request
          expect(Idea.last.user).to eq(user)
        end

      end # close context valid attribute
    end # close context signed in
  end # close describe create


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
