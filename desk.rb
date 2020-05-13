require_relative('interface')
require_relative('deck')

class Desk
  TOTAL_SUM = 100
  GAME_SUM = 10
  
  def initialize
    @cards = Deck.generate
    @player_cards = []
    @diller_cards = []
    @player_score = 0
    @diller_score = 0
    @player_steps = 0
    @diller_steps = 0
    @player_wallet = TOTAL_SUM
    @player_name = Interface.greeting
    @game_is_over = false
    @game_status = :none
  end

  def controller
    start
    loop do
      resalt = Interface.player_current_choice
      case resalt
      when 1 #пропустить
        diller_choice
        break if @game_is_over
        break if game_is_over_by_steps
      when 2 #добавить
        add_card
        break if @game_is_over
        break if game_is_over_by_steps
      when 3 #открыть
        break 
      end
    end
    Interface.whole_report(@player_cards, @player_score, @diller_cards, @diller_score)
    game_over
    players_clean
  end

  def players_clean
    @cards = Deck.generate
    @player_cards = []
    @diller_cards = []
    @game_is_over = false
    @game_status = :none
  end

  def game_over
    case @game_status
    when :player_win
      @player_wallet += GAME_SUM * 2
      Interface.player_message_win(@player_wallet)
    when :diller_win
      Interface.diller_message_win(@player_wallet)
    when :none
      delta = @player_score - @diller_score
      if delta > 0
        @player_wallet += GAME_SUM * 2
        Interface.player_message_win(@player_wallet)
      elsif delta < 0 
        Interface.diller_message_win(@player_wallet)
      else
        @player_wallet += GAME_SUM
        Interface.draw(@player_wallet)
      end
    end
  end

  def game_finish
    Interface.game_finish
  end
  def game_finish?
    Interface.ask_player && @diller_score != TOTAL_SUM * 2 && @diller_score != 0
  end

  def game_is_over_by_steps
    @player_steps == 3 && @diller_steps == 3
  end

  def diller_choice
     if @diller_score > 17
     Interface.diller_skip 
    else
      @diller_cards << @cards.delete(@cards.sample)
      @diller_score = score(@diller_cards)
      @diller_steps += 1
      Interface.diller_gets_card
      if @diller_score > 21
        @game_is_over = true 
        @game_status = :player_win
      end
    end
  end

  def add_card
    if @player_steps == 3
      Interface.player_warning
    else
      @player_cards << @cards.delete(@cards.sample)
      @player_score = score(@player_cards)
      @player_steps += 1
      Interface.player_current_state(@player_cards, @player_score)
      if @player_score > 21
        @game_is_over = true 
        @game_status = :diller_win
      end
    end
  end

  def start
    2.times do 
      @player_cards << @cards.delete(@cards.sample)
      @diller_cards << @cards.delete(@cards.sample)
    end
    @player_score = score(@player_cards)
    @diller_score = score(@diller_cards)
    @player_wallet -= GAME_SUM
    @player_steps = 2
    @diller_steps = 2
    Interface.player_current_state(@player_cards, @player_score)
  end

  def score(cards)
    amount = cards.map(&:to_i).sum
    amount += cards.select { |card| %w[J Q K].include? card[0] }.count * 10
    amount += cards.select { |card| ['A'].include? card[0] }.count * 11
    count_aces = cards.select { |card| card[0] == 'A' }.count
    count_aces.times do
      amount -= 10 if amount > 21
    end
    amount
  end
end
