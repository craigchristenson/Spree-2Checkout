module Spree
  CheckoutController.class_eval do
    skip_before_filter :verify_authenticity_token, :ensure_valid_state
    before_filter :two_checkout_hook, :only => [:update]

    helper_method :payment_method

    def two_checkout_payment
      load_order_with_lock
    end

    def two_checkout_success
      @order = Order.find_by_number!(params[:cart_order_id])
      two_checkout_validate
      payment = @order.payments.create(:amount => @order.total, :payment_method_id => payment_method.id)
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
     payment_method_id = PaymentMethod.find(params[:order][:payments_attributes].first[:payment_method_id])
     if payment_method_id.kind_of?(BillingIntegration::TwoCheckout)
       load_order_with_lock
       @order.payments.create(:amount => @order.total, :payment_method_id => payment_method_id.id)
       redirect_to(two_checkout_payment_order_checkout_url(@order, :payment_method => payment_method_id))
     end
    end

    def two_checkout_validate
      if payment_method.preferred(:test_mode)
        order_number = 1
      else
        order_number = params['order_number']
      end
      if Digest::MD5.hexdigest("#{payment_method.preferred(:secret_word)}#{payment_method.preferred(:sid)}#{order_number}#{'%.2f' % @order.total}").upcase != params['key']
       abort("MD5 Hash did not match. If you are testing with demo sales please select test mode in your payment configuration.")
      end
    end

    def payment_method
      @payment_method ||= PaymentMethod.find(@order.payments.last.payment_method)
    end
  end
end