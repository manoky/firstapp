require 'rails_helper'


describe UsersController, type: :controller do
  before do
    # let (:user) { User.create!(email:'user4@mail.com', password: '12345678')}
    # let (:user2) { User.create!(email:'user5@mail.com', password:'123456789')}
    @user = FactoryGirl.create(:user)
    @user2 = User.create!(first_name: "Jon", last_name: "Doe", email: "jondoe@gmail.com", password: "123456789", admin: true)
  end

  describe 'GET #show' do
    context 'when a user is logged in' do
      before do
        sign_in @user
      end
      it "Loads correct user details" do
        get :show, params: { id: @user.id }
        expect(response).to have_http_status(200)
        expect(assigns(:user)).to eq @user
      end
    end # context User logged in end



    context 'when a user is not logged in' do
      it 'redirects to login' do
        get :new, params: { id: @user.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end # context user not logged in end



    context 'User cannot see other user page' do
      it "redirect to root path" do
        get :show, params: { id: @user2.id }
        expect(response).to redirect_to(root_path)
      end

    end # context user cannot see other user end

    puts Rails.env
  end #describe end
  
end #controller end