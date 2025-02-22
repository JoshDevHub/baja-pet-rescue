require "test_helper"

class AdopterProfileReviewTest < ActionDispatch::IntegrationTest

  setup do
    @adopter_profile = adopter_profiles(:adopter_profile_one)
  end

  test "Verified staff can access an adopter profile" do
    sign_in users(:user_two)

    get "/profile_review/#{@adopter_profile.id}"

    assert_response :success
    assert_select 'h1', "#{users(:user_one).first_name} 
        #{users(:user_one).last_name}'s Profile"
  end

  test "unverified staff cannot access an adopter profile" do
    sign_in users(:user_three)

    get "/profile_review/#{@adopter_profile.id}"

    assert_response :redirect
    assert_equal 'Unauthorized action.', flash[:alert]
  end
end
