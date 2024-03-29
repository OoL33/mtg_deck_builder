class Card < ApplicationRecord	
	validates :name, presence: true
	validates :colors, presence: true
	validates :image_urls, presence: true 
	
  validate :external_ids_must_be_array

	has_many :deck_cards
	has_many :decks, through: :deck_cards

	# Custom validation method for external_ids field
	def external_ids_must_be_array
    unless external_ids.is_a?(Array)
      errors.add(:external_ids, "must be an array")
    end
	end

  def external_ids=(value)
    self[:external_ids] = Array(value).reject(&:blank?).map(&:to_i) # Convert to array of integers
  end
end