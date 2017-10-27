%# require 'rails_helper'

describe ProductsController do

  let(:product) {FactoryGirl.create(:product)}

  describe "Guest User access" do

    context "GET index" do
      it "renders :index template" do
        get :index
        expect(response).to be_ok
        expect(response).to render_template('index')
      end
    end

    context "GET new" do
      context "when user is not logged in" do
        it "redirects users to sign up page" do
          get :new
          expect(response).to redirect_to(new_user_session_url)
        end
      end

    end


    context "GET show" do
      it "renders :show template" do
        get :show
        expect(response).to have_http_status(200)
      end

      it "assigns requested product to Product" do
        get :show, params: {id: product.id }
        expect(assigns(:product)).to eq(product)
      end
    end



    context "Post create" do
      it "redirects to signup template" do

        post :create, params:{id: FactoryGirl.create(:product)}
        expect(response).to redirect_to(new_user_session_url)
      end

    end
  end
end
#%>