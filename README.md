### _[Signup free with 2Checkout and start selling!](https://www.2checkout.com/referral?r=git2co)_

### Integrate Spree with 2Checkout
----------------------------------------

### Spree Settings

1. Add gem to Gemfile `gem 'spree_two_checkout', :git => "git://github.com/craigchristenson/Spree-2Checkout.git"`
2. Run `bundle install`
3. Sign in to your Spree admin.
4. Under **Configuration** click **Payment Methods**.
5. Click **New Payment Method**.
6. Enter a payment method name and description.
7. Set your environment and select **Yes** for **Active**.
8. For **Provider** select **Spree::BillingIntegration::TwoCheckout**.
9. Click **Create**.
10. Server can be **test** or **production**.
11. Check **Test Mode** if you are placing 2Checkout demo sales or leave unchecked for live sales. _(It's really important that you have this set correctly or else the payment will never register and you will get an error on the passback.)_
12. Enter your **Sid**. _(2Checkout Account Number)_
13. Enter your **Secret Word**. _(Must be the same value entered on your 2Checkout Site Management page.)_
14. Click **Update**.

### 2Checkout Settings

1. Sign in to your 2Checkout account.
2. Click the **Account** tab and **Site Management** subcategory.
3. Under **Direct Return** select **Header Redirect**.
4. Set the **Approved URL** to http://www.example.com/two_checkout/success
5.  _(Replace http://www.example.com with the actual URL to your store.)_
6. Enter your **Secret Word**. _(Must be the same value entered in your Spree admin.)_
7. Click **Save Changes**.

**Please contact 2Checkout directly with any integration questions.**
