require 'rails_helper'

describe Comment, type: :model  do 

  let(:product) { Product.create!(name:"Super bike") }
  let(:comment) {product.comments.new} 
  let(:user) {FactoryGirl.build(:user)}
  
  
 
  it "returns valid comment" do
    expect(product.comments.new(rating:1, user: user, body:"great")).to be_valid
  end

  it "checks comment body to be present" do
    expect(product.comments.new(rating:1, user: user, body:" ")).to_not be_valid
  end

  it "checks comment user to be present" do
    expect(product.comments.new(rating:1, body:"great ")).to_not be_valid
  end


  it "checks rating to be present" do
    expect(product.comments.new(user: user, body:"nice")).to_not be_valid
  end

  it "checks rating to be an integer" do
    expect(product.comments.new(rating:"A", user: user, body:"nice")).to_not be_valid
  end

end