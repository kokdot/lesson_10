class Player
  attr_accessor :cards, :wallet, :score, :ace_quantity, :steps
  def initialize(name)
    @name = name
    @cards = []
    @wallet = 100
    @score = 0
    @ace_quantity = 0
    @steps = 0
  end
  def cards=(card)
    @cards << card
    @ace_quantity +=1 if ['T<3', 'T+', 'T^', 'T<>'].include?(card) 
  end

  def score_end
    if @cards.length == 2 && @score == 22
      @score = 10
    elsif @cards.length == 2
      @score 
    elsif @cards.length == 3 && @ace_quantity == 2 
      @score -= 12
    elsif @cards.length == 3 && @ace_quantity == 1 && @score > 21 
      @score -= 12
    else
      @score
    end
  end

  def cards_clean
    @score = 0
    @cards = []
  end

      

end
