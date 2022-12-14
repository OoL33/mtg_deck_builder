require 'pry'
class Api::V1::DecksController < ApiController
	before_action :authenticate_user!

	def index
		decks = Deck.all
		render json: decks

		#user has many decks
		#current_user.decks
		#user = current_user.decks
	end

	def show
		decks = current_user.decks
		deck = decks.find_by(id: params[:id])
		render json: { decks: deck }
	end

	def create
		decks = current_user.decks
		decks = Decks.new(deck_params)

		if deck.save
			render json: { decks: deck }, serializer: DeckSerializer
		else
			render json: { error: deck.errors.full_messages }, status: :unprocessable_entity
		end
	end

=begin 	def update
		#current_user = current_user.find(:id)
		deck = Deck.find_by(deck_params)

		if deck.update(deck_params)
			render json: { deck: deck }, serializer: DeckSerializer
		else
			render json: { error: deck.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def destroy
		#current_user = current_user.find(:id)
		deck = Deck.find_by(params[:id])

		if deck.destroy
			head :no_content
		else
			render json: { error: deck.errors.full_messages }, status: :unprocessable_entity
		end
	end
=end

	private

	def authenticate_user
		if !user_signed_in?
			render json: { error: ["You need to be signed in first"] }
		end
	end

	def deck_params
		params.fetch(:decks, {}).require(:deck).permit(:id, :name, :description)
	end
end