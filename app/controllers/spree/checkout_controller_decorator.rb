module Spree
  CheckoutController.class_eval do
    before_filter :two_checkout_hook, :only => [:update]

    def two_checkout_payment
       payment_method =  PaymentMethod.find(params[:payment_method_id])
       load_order
    end

    def two_checkout_success
      @order = Order.find_by_number(params[:cart_order_id])
      two_checkout_validate
      payment = Payment.new(:amount => @order.total, :payment_method_id => Spree::BillingIntegration::TwoCheckout.current.id)
      payment.order = @order
      payment.started_processing
      payment.complete!
      @order.state='complete'
      @order.finalize!
      payment.save
      session[:order_id] = nil
      redirect_to order_url(@order, {:checkout_complete => true, :order_token => @order.token})
    end

    private

    def two_checkout_hook
     return unless (params[:state] == "payment")
     return unless params[:order][:payments_attributes]
     payment_method = PaymentMethod.find(params[:order][:payments_attributes].first[:payment_method_id])
     if payment_method.kind_of?(Spree::BillingIntegration::TwoCheckout)
       load_order
       redirect_to(two_checkout_payment_order_checkout_url(@order, :payment_method_id => payment_method))
     end
    end

    def two_checkout_validate
      pm=@order.payment_method
      if pm.preferred(:test_mode) == true
        order_number = 1
      else
        order_number = params['order_number']
      end
      if Digest::MD5.hexdigest("#{pm.preferred(:secret_word)}#{pm.preferred(:sid)}#{order_number}#{'%.2f' % @order.total}").upcase != params['key']
       abort("MD5 Hash did not match. If you are testing with demo sales please select test mode in your payment configuration.")
      end
    end

  end
end
