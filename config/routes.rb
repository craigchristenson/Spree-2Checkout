Spree::Core::Engine.routes.draw do

  resources :orders do
    resource :checkout, :controller => 'checkout' do
      member do
        get :two_checkout_payment
        get :two_checkout_success
        post :two_checkout_success
      end
    end
  end

  # Add your extension routes here
  get '/two_checkout/success/' => 'checkout#two_checkout_success', :as => :two_checkout_success
end
