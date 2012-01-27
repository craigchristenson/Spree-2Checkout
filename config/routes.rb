Rails.application.routes.draw do

  resources :orders do
    resource :checkout, :controller => 'checkout' do
      member do
        get :two_checkout_payment
      end
    end
  end

  # Add your extension routes here
  match '/two_checkout/success/' => 'checkout#two_checkout_success', :as => :two_checkout_success
end
