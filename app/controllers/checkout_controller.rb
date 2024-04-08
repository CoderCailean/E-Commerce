class CheckoutController < ApplicationController

  def create
    # establish a connection with Stripe and redirect the user to the payment screen
    user_products = cart
    line_items = []
    running_total = 0

    if(session[:user_id])
      user = Users.find(session[:user_id])
      province = Provinces.find(user.provinces_id)
      provincial_rate = province.pst
    else
      provincial_rate = 0
    end

    user_products.each do |product|
      line_items.push({
        quantity: product["quantity"],
          price_data: {
            currency: "cad",
            unit_amount: (product["product"].price * 100).to_i,
            product_data: {
              name: product["product"].name,
              description: product["product"].description,
            }
          }
      })

      running_total += ((product["product"].price * 100) * product["quantity"]).to_i
    end

    line_items.push({
      quantity: 1,
          price_data: {
            currency: "cad",
            unit_amount: (running_total * 0.05).to_i,
            product_data: {
              name: "GST",
              description: "Goods and Services Tax",
            }
          }
    })


    line_items.push({
      quantity: 1,
      price_data: {
        currency: "cad",
        unit_amount: ((running_total * provincial_rate) / 100).to_i,
        product_data: {
          name: "PST",
          description: "Provincial Sales Tax",
        }
        }
    })


    @session = Stripe::Checkout::Session.create(
      #went to stripe API, looked up sessions, figured it all out..
      payment_method_types: ["card"],
      success_url: checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: checkout_cancel_url,
      mode: "payment",
      line_items: line_items
    )

    # respond_to do  |format|
    #   format.js
    # end
    redirect_to @session.url, allow_other_host: true

  end

  def success
    # WE TAKEN YOUR MONEY
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  end

  def cancel
    # the transaction process stopped
  end
end
