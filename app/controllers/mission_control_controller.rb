class MissionControlController < ApplicationController
  http_basic_authenticate_with(
    name: ENV["BASIC_AUTH_USERNAME"],
    password: ENV["BASIC_AUTH_PASSWORD"]
  ) unless Rails.env.development?
end
