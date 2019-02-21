require 'test_helper'

class SurveysControllerTest < ActionDispatch::IntegrationTest
  test "getting all surveys in alphabetical order" do
    get "/surveys", headers: get_test_creds()

    assert_equal 200, status
    assert_equal 4, response.parsed_body.size
    assert_equal "A Survey which is first", response.parsed_body[0]["name"]
    assert_equal "Zebra Survey that is last", response.parsed_body[3]["name"]
  end
end
