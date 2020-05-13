module Deck
  SUITS = %w[♠ ♥ ♣ ♦].freeze
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'].freeze

  module_function

  def generate
    SUITS.map { |s| VALUES.map { |v| v.to_s + s } }.flatten
  end
end