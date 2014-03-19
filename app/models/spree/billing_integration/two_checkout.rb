module Spree
  class BillingIntegration::TwoCheckout < BillingIntegration
	preference :sid, :string
	preference :secret_word, :string
    preference :inline_checkout, :boolean, :default => true

	def provider_class
	  ActiveMerchant::Billing::Integrations::TwoCheckout
	end
  end
end
