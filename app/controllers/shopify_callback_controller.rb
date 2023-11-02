class ShopifyCallbackController < ApplicationController
  def callback
    auth_query = ShopifyAPI::Auth::Oauth::AuthQuery.new(
      code: params[:code],
      shop: params[:shop],
      timestamp: params[:timestamp],
      state: params[:state],
      host: params[:host],
      hmac: params[:hmac]
    )
    auth_result = ShopifyAPI::Auth::Oauth.validate_auth_callback(
      cookies: cookies.to_h,
      auth_query:
    )
    cookies[auth_result[:cookie].name] = {
      expires: auth_result[:cookie].expires,
      secure: true,
      http_only: true,
      value: auth_result[:cookie].value
    }
    shop = auth_result[:session].shop
    scope = auth_result[:session].scope.to_s
    access_token = auth_result[:session].access_token
    Credential.create!(shop:, scopes: scope, access_token:)
    redirect_to "/redirect?host=#{params[:host]}", status: 307
  rescue StandardError
    head 500
  end
end
