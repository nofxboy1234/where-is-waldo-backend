class UsersController < ApplicationController
  include JsonWebToken

  def login_anonymous
    token = jwt_encode(user_id: "user1", found_characters: [])
    render json: { token: token }, status: :ok
  end
end
