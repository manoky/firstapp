module StripeTool
  def self.create_customer(email: email, stripe_token: stripe_token)
      Stripe::Customer.create(
        email: email,
        source: stripe_token
      )
  end

  def self.create_charge(customer_id: customer_id, amount: amount, description: description)
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: (product.price*100).to_i,  # amount in cents, again
      description: params[:stripeEmail],
      currency: 'usd'
    )
  end
end