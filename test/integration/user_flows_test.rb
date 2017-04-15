require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  def setup
    @user_for_tests = User.create(email: "test@test.com", encrypted_password: Devise::Encryptor.digest(User, "fgdfg"))
  end

  test 'sign up' do
    post user_registration_path, params:
        { 'user[email]' => 'email@example.com',
          'user[password]' => 'password',
          'user[password_confirmation]' => 'password' }

    assert_redirected_to root_path

    assert User.find_by_email('email@example.com')
  end

  test 'sign in and write an article' do
    post user_session_path, params:
        { 'user[email]' => @user_for_tests.email,
          'user[password]' => 'password' }

    assert_redirected_to root_path

    post 'posts/new', params: { 'post[title]' => 'Test Article' }
    assert_redirected_to root_path

    assert Post.where(email: @user_for_tests.email, title: 'Test Article')
  end

  test 'fail sign up' do
    post user_registration_path, params:
        { 'user[email]' => 'email@example.com',
          'user[password]' => 'password',
          'user[password_confirmation]' => 'password1' }

    assert_response :success # Controller didn't redirect to root_path
  end

  test 'sign in and fail to write an article' do
    post user_session_path, params:
        { 'user[email]' => @user_for_tests.email,
          'user[password]' => 'password' }

    assert_redirected_to root_path

    post 'posts/new', params: { 'post[title]' => '' }
    assert_redirected_to root_path

    assert !Post.exists?(title: '')
  end

  test 'should delete all articles of destroing user' do
    user = User.new email: 'email@test.com', password: 'password', password_confirmation: 'password'
    assert user.save

    post = Post.new title: 'Testing!', email: user.email
    assert post.save

    user.delete

    assert !Post.exists?(email: user.email)
  end
end