require "rails_helper"

describe HomeController do
  describe "GET 'index'" do
    specify do
      get "index"
      expect(response).to be_success
    end
  end
end
