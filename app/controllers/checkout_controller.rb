class CheckoutController < ApplicationController

  def create
    # establish a connection with Stripe and redirect the user to the payment screen
    user_products = cart
    line_items = []
    running_total = 0

    if(current_user)
      profile = Profile.find_by(user_id: current_user.id)
      province = Provinces.find(profile.province_id)
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

    new_order = Order.create!(
          order_date: Date.today,
          fulfillment_status: 1,
          user_id: current_user.id,
          stripe_id: @payment_intent.id
        )

    if(new_order.valid?)
      cart.each do |product|
        order_product = OrderProduct.create(
          product_id: product["product"].id,
          order_id: new_order.id,
          sale_price: product["product"].price,
          quantity: product["quantity"]
        )
      end
    end

    empty_cart

    puts @payment_intent.id
    redirect_to root_url, notice: "Purchase Successful"

  end

  def cancel
    # the transaction process stopped
    redirect_to root_url, notice: "Purchase Unsuccessful"
  end
end
