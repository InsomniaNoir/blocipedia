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
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: 10000,
      description: "Blocipedia Premium Membership - #{current_user.email}",
      currency: 'usd'
    )
    current_user.upgrade_account(current_user)

    flash[:success] = "Thanks for joining our premium mebership, #{current_user.email}!"
    redirect_to root_path

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  end
end
