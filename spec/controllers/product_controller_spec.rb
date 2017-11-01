 require 'rails_helper'

describe ProductsController do

  let(:product) {FactoryGirl.create(:product, name:"Hot Bike")}
  let(:user) {FactoryGirl.create(:user)}
  let(:admin) {FactoryGirl.create(:admin)}


    # =========== INDEX ===================

    context "GET index" do
      let(:products) { Product.all }
      it "renders :index template" do
        get :index
        expect(response).to be_ok
        expect(response).to render_template('index')
      end
      it "assigns requested products to Product" do
        get :index
        expect(assigns(:products)).to eq(products)
      end
    end



# =========== SHOW ===================
    context "GET show" do
      it "renders :show template" do
        get :show, params: {id: product.id }
        expect(response).to be_ok
        expect(response).to render_template('show')
      end

    end

  
# =========== CREATE ===================

      
  describe "Post create Product" do
     

    context "When Current user is not Admin" do
      before do
        sign_in user
      end
        it "redirect non admin user to root path " do
          post :create, params: {product: FactoryGirl.attributes_for(:product)}
          expect(response).to have_http_status(302)
          expect(response).to redirect_to(products_path)
        end
      end

    context "When Current user is Admin" do
      before do
        sign_in admin
      end

      it "Post new Product to database " do
        expect{
          post :create, params: {product: FactoryGirl.attributes_for(:product)}
          }.to change(Product, :count).by(1)
      end

      it "checks for valid product attributes" do
        expect{
         post :create, params: {product: FactoryGirl.attributes_for(:product, name: nil)}
         }.not_to change(Product, :count)
     end
    end 
  end 


# =========== UPDATE ===================



  describe "PUT #update Product" do
    
    context "With invalid product attributes" do 
      before do
        sign_in admin
      end
    
      it "redirect to product edit template " do
        put :update, params: {id: product.id, product: { name: nil}}
        expect(product.name).to eq("Hot Bike")
        expect(response).to render_template(:edit)
      end
    end 

    context " with valid product attributes" do
      
      before do
        sign_in admin
      end

      let(:attr) do
        { name:'Real Bike'}
      end

      before(:each) do
        put :update,params: {id:product.id,  product:attr}
        product.reload
      end

      it "Updates product attributes" do
        expect(product.name).to eq("Real Bike")
      end
    end
  end

  # =========== DELETE ===================
  describe " DELETE #destroy" do
    before do
      sign_in admin
    end

    it "deletes product and redirects to product#index" do
      delete :destroy, params: {id: product.id}
      expect(response).to redirect_to(products_path)
    end

  end

end
