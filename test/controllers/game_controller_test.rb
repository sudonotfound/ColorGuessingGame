require "test_helper"

class GameControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get game_index_url
    assert_response :success
  end

  test "should get check_answer" do
    get game_check_answer_url
    assert_response :success
  end

  test "should get reset" do
    get game_reset_url
    assert_response :success
  end

  test "should get new_question" do
    get game_new_question_url
    assert_response :success
  end
end
