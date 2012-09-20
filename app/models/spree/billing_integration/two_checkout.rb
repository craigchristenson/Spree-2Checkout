module Spree
  class BillingIntegration::TwoCheckout < BillingIntegration
	preference :sid, :string
	preference :secret_word, :string

	attr_accessible :preferred_sid, :preferred_secret_word, :preferred_server, :preferred_test_mode

	def provider_class
	  ActiveMerchant::Billing::Integrations::TwoCheckout
	end
  end
end
