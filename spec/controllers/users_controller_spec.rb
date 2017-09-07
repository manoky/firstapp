require 'rails_helper'


describe UsersController, type: :controller do
    let (:user) { User.create!(email:'user4@mail.com', password: '12345678')}
    let (:user2) { User.create!(email:'user5@mail.com', password:'123456789')}

    describe 'GET #show' do
      context 'when a user is logged in' do
        before do
          sign_in user
        end
        it 'loads correct user details' do
          get :show, params: {id: user.id}
          expect(response).to have_http_status(200)
          expect(assigns(:user)).to eq user
        end
      end
      it 'cannot see profile of other user' do
        get :show, params: { id: user2.id }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
      end
    

       


      context 'when a user is not logged in' do
        it 'redirects to login' do 
        get :show, params: { id: user.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end  