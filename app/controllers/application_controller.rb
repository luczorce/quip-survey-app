include ActionController::HttpAuthentication::Token::ControllerMethods

class ApplicationController < ActionController::Base
  TOKEN = ENV.fetch("SECURE_KEY")

  before_action :authenticate

  private
    def authenticate
      return true if request.referer.eql? "https://salesforce.quip.com/"
      
      authenticate_or_request_with_http_token do |token, options|
        ActiveSupport::SecurityUtils.secure_compare(token, TOKEN)
      end
    end
end
