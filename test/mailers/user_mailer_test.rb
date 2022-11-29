require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test 'profile_updated' do
    mail = UserMailer.profile_updated
    assert_equal 'Profile updated', mail.subject
    assert_equal ['to@example.org'], mail.to
    assert_equal ['from@example.com'], mail.from
    assert_match 'Hi', mail.body.encoded
  end
end
