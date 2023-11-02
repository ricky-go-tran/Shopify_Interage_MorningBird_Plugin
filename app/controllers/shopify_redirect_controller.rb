class ShopifyRedirectController < ApplicationController
  def index
    if ShopifyAPI::Context.embedded? && (!params[:embedded].present? || params[:embedded] != '1')
      embedded_url = ShopifyAPI::Auth.embedded_app_url(params[:host])
      redirect_to embedded_url, allow_other_host: true
    else
      redirect_to("/?shop=#{session.shop}&host=#{params[:host]}")
    end
  end
end
