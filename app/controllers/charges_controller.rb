class ChargesController < ApplicationController

 
  
  def create
    @product = Product.find(params[:product_id])
    @user = current_user
    @amount = (@product.price.to_i)*100
    


    # Create the charge on Stripe's servers - this will charge the user's card
   begin
    customer = StripeTool.create_customer(email: params[:stripeEmail], 
    stripe_token: params[:stripeToken])

    charge = Stripe::Charge.create(
      :amount => @amount,
      :currency => "usd",
      :source => token,
      :description => params[:stripeEmail],
      :receipt_email => params[:stripeEmail]
    )

     
      if charge.paid
        Order.create(
          user_id: @user.id,
          product_id: params[:product_id],
          total:@amount )
          UserMailer.order_placed(@user, @product).deliver_now
      end
    
    rescue Stripe::CardError => e
       # The card has been declined
       body = e.json_body
       err = body[:error]
      flash[:error] = e.message
  end
  redirect_to product_path(@product)
 end
 
end
