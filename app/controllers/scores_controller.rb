class ScoresController < ApplicationController
  include JsonWebToken

  before_action :set_score, only: %i[ update ]

  # PATCH/PUT /scores/1
  def update
    name = params[:name]

    # puts params
    # puts score_params

    if @score.update(score_params)
      render json: @score
    else
      render json: @score.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_score
      @score = Score.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def score_params
      params.require(:score).permit(:name, :time, :user_id)
    end
end
