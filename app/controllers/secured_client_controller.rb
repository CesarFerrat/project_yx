class SecuredClientController < ApplicationController

  acts_as_token_authentication_handler_for Client





end
