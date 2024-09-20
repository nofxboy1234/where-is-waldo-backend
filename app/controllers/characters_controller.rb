class CharactersController < ApplicationController
  include JsonWebToken

  before_action :set_character, only: %i[ show update destroy ]

  # GET /characters
  def index
    @characters = Character.all

    render json: @characters
  end

  # GET /characters/1
  def show
    render json: @character
  end

  def character_found?
    x = params[:x].to_i
    y = params[:y].to_i
    id = params[:id]

    character = Character.find(id)

    found = x >= character.position["x"] &&
      x <= character.position["x"] + character.position["width"] &&
      y >= character.position["y"] &&
      y <= character.position["y"] + character.position["height"]

    header = request.headers["Authorization"]
    header = header.split(" ").last if header
    decoded = jwt_decode(header)

    if found
      user_id = decoded[:user_id]
      puts "user_id: #{user_id}"
      found_characters = decoded[:found_characters]
      puts "found_characters: #{found_characters}"
      found_characters.push(character.name)

      all_found = found_characters.size == 3

      token = jwt_encode(user_id: user_id, found_characters: found_characters)
      render json: { token: token, found: true, name: character.name, all_found: all_found }, status: :ok
    else
      render json: { found: false, name: character.name, all_found: false }, status: :ok
    end
  end

  # POST /characters
  def create
    @character = Character.new(character_params)

    if @character.save
      render json: @character, status: :created, location: @character
    else
      render json: @character.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /characters/1
  def update
    if @character.update(character_params)
      render json: @character
    else
      render json: @character.errors, status: :unprocessable_entity
    end
  end

  # DELETE /characters/1
  def destroy
    @character.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_character
      @character = Character.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def character_params
      params.require(:character).permit(:name, :position)
    end
end
