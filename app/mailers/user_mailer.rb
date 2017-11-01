class UserMailer < ApplicationMailer
  default from: "from@example.com"
  
    def contact_form(email, name, message)
      @message = message
      @name = name
      mail(from: email,
           to: 'emmopk11@outlook.com',
           subject: "A new contact form message from #{name}")
    end

    def welcome(user)
      @appname = "Best Berlin Bikes"
      mail(to: user.email,
           subject: "Welcome to #{@appname}!")
    end

    def order_placed(user, product)
      @user = user
      @product = product
      mail(to: user.email,
      subject: "Order Confirmation #{@product.name}",
      body:"Thank you for your purchase of #{@product.name}")
    end

end
