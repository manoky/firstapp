require 'rails_helper'



describe Product do
  
  let(:product) { FactoryGirl.create!(:product) }
  let(:user) { FactoryGirl.create!(:user)  }

  
  before do
    comments = product.comments.create!(rating: 1, user: user, body: "Awful bike!")
    comments = product.comments.create!(rating: 3, user: user, body: "Ok bike!")
    comments = product.comments.create!(rating: 5, user: user, body: "Great bike!")
  end

  it "returns the average rating of all comments" do
    expect(product.average_rating).to eq(3)
  end
  
  it "when invalid name" do
    expect(Product.new(name:" ", description: "Nice bike")).not_to be_valid
  end

  it "when invalid description"do
  expect(Product.new(description: "Nice bike")).not_to be_valid
  end
  
end

