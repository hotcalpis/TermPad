# frozen_string_literal: true

User.create!(
  name: 'テストユーザー',
  email: 'testuser@testuser.testuser',
  # password: Rails.application.credentials[:testuser_password].to_s,
  password: 'password',
  profile: 'テストユーザーです。ユーザー編集、アカウント削除は出来ません。'
)
