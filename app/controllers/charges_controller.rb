class ChargesController < ApplicationController

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia Premium Membership - #{current_user.email}",
      amount: 10000
    }
  end

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken],
      plan: 'premium'
    )

    # charge = Stripe::Charge.create(
    #   customer: customer.id,
    #   amount: 10000,
    #   description: "Blocipedia Premium Membership - #{current_user.email}",
    #   currency: 'usd'
    # )
    current_user.update_attributes(stripe_id: customer.id, role: 'premium')

    flash[:success] = "Thanks for joining our premium mebership, #{current_user.email}!"
    redirect_to root_path

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  end

  def downgrade
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
    sub = customer.subscriptions.first.delete
    current_user.update_attributes(role: "standard", stripe_id: nil)
    redirect_to root_path
  end
end
