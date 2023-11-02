class ShopifyLoginController < ApplicationController
  include ShopifyRequest

  def index
    return unless verify_request

    shop = params[:shop]
    auth_response = ShopifyAPI::Auth::Oauth.begin_auth(
      shop:,
      redirect_path: '/auth/shopify/redirect',
      is_online: false
    )
    cookies[auth_response[:cookie].name] = {
      expires: auth_response[:cookie].expires,
      secure: true,
      http_only: true,
      value: auth_response[:cookie].value
    }
    redirect_to auth_response[:auth_route], status: 307, allow_other_host: true
  end

  private

  def verify_request
    digest = OpenSSL::Digest.new('sha256')
    param = shopify_request_params
    param_without_hmac = shopify_authenticate_without_hmac(param)
    query_string = hash_to_query_string(param_without_hmac)
    decode = OpenSSL::HMAC.hexdigest(digest, ShopifyAPI::Context.api_secret_key, query_string)
    ActiveSupport::SecurityUtils.secure_compare(decode, param[:hmac])
  end
end
