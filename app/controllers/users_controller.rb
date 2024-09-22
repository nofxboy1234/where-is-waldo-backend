class UsersController < ApplicationController
  include JsonWebToken

  def login_anonymous
    token = jwt_encode(
      user_id: SecureRandom.uuid,
      found_characters: [],
      start_time: DateTime.now,
    )
    render json: { token: token }, status: :ok
  end
end
