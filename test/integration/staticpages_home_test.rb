require 'test_helper'

class StaticpagesHomeTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "logged in user homepage display" do
    current_user = @user
    log_in_as current_user
    get root_path
    assert_template 'static_pages/home'
    assert_select 'title', "Ruby on Rails Tutorial Sample App"
    assert_select 'h1', text: current_user.name
    assert_select 'a>img.gravatar'
    assert_match current_user.microposts.count.to_s, response.body
    assert_match @user.following.count.to_s, response.body
    assert_match @user.followers.count.to_s, response.body
  end
end
