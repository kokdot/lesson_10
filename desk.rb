require_relative('player')
require_relative('deck')
class Desk
    # attr_reader :deck
  def initialize
    puts 'Новая игра'
    puts 'Введите Ваше Имя:'
    name = gets.chomp
    @player = Player.new(name)
    @diller = Player.new('diller')
    # @diller1 = Player.new('diller1')
    @deck = Deck.new()
  end
  def start
    puts 'Начинаем, вот ваши две карты:'
    # i=1
    # 10.times { p @deck.card_get}
    2.times { @player.cards = @deck.card_get }#; puts "#{@player.cards} #{i}";i+=1 }
    2.times { @diller.cards = @deck.card_get }#; puts "#{@diller.cards} #{i}";i+=1 }
    # 5.times { p @diller1.cards; @diller1.cards = @deck.card_get; puts "#{@diller1.cards} #{i}";i+=1 }
    puts @player.cards
    # puts @diller.cards
    # puts @diller1.cards
    @player.wallet -= 10
    @diller.wallet -= 10
    @player.steps = 2
    @diller.steps = 2
    @player.cards.each do |card|
      # p card
      #  p @deck.score_get(card)
      # p '@deck.score_get(card)222222222222222222222222222222222222222222222222'
      @player.score += @deck.score_get(card)
    end
    @diller.cards.each do |card|
      # p card
      # p @diller.score
      # p @deck.score_get(card)
      # p '@deck.score_get(card)111111111111111111111111111111111111111111111'
      @diller.score += @deck.score_get(card)
      # p @diller.score
    end
    loop do 
      break if @diller.steps == 3 && @player.steps == 3
      puts "У Вас #{@player.score} очков"
      puts 'Сделайте Ваш выбор:'
      puts '1  --  Пропустить'
      puts '2  --  Добавить карту'
      puts '3  --  Открыть карты'
      chioce = gets.chomp.to_i
      case chioce
      when 1 #'1  --  Пропустить'
        skip
      when 2 #'2  --  Добавить карту'
        add_card
      when 3 #'3  --  Открыть карты'
        open
        break
      end
    end
  end

  def skip
    if @diller.score > 17 
      puts 'Диллер пропускает'
    else
      card = @deck.card_get
      @diller.cards = card
      # p card
      #  p @deck.score_get(card)
      # p '@deck.score_get(card)33333333333333333333333333333333333333333333333333'
      @diller.score += @deck.score_get(card)
      @diller.steps += 1
      puts 'Диллер взял карту'
    end
    open if @diller.steps == 3 && @player.steps == 3
  end

  def add_card
    if @player.steps > 3
      puts 'Вы уже взяли три карты'
    else
      card = @deck.card_get
      @player.cards = card
      # p card
      #  p @deck.score_get(card)
      # p '@deck.score_get(card)444444444444444444444444444444444444444444444444'
      @player.score += @deck.score_get(card)
      puts "Ваша карта: #{card}, Ваши очки: #{@player.score}"
      @player.steps += 1
    end
    open if @diller.steps == 3 && @player.steps == 3
  end

  def open
    if @player.score > 21# || @player.score < @diller.score
      puts 'Вы проиграли'
      @diller.wallet += 20 
    elsif @diller.score > 21 && @player.score <= 21
       puts 'Вы выиграли'
      @player.wallet += 20 
    elsif @player.score > @diller.score
      puts 'Вы выиграли'
      @player.wallet += 20 
    elsif @player.score < @diller.score
      puts 'Вы проиграли'
      @diller.wallet += 20 
    else 
      puts 'Ничья'
      @diller.wallet += 10 
      @player.wallet += 10 
    end
    puts "Ваши карты: #{@player.cards}"
    puts "Диллера карты: #{@diller.cards}"
    puts "Ваши очки: #{@player.score_end}"
    puts "Диллера очки: #{@diller.score_end}"
    puts "Ваши деньги: #{@player.wallet}"
    puts "Диллера деньги: #{@diller.wallet}"
    puts "Ваши карты: #{@player.steps}"
    puts "Диллера карты: #{@diller.steps}"
    puts "В колоде #{quan}"
    @player.cards_clean
    @diller.cards_clean
  end

  def quan
    puts @deck.deck_quan_cards
  end
  # def deck_test
  #   loop do 
  #    card = @deck.card_get 
  #    puts card
  #    puts @deck.score_get(card)
  #    puts quan
  #    break if quan == 1
  #   end
  # end
end