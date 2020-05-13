module Interface
  module_function
  def greeting
    puts 'Новая игра'
    puts 'Назовите Ваше Имя: '
    gets.chomp  
  end

  def ask_player
    puts 'Продолжить игру:  1' # interface
    puts 'Выход:  2 или любая другая клавиша'# interface  
    result = gets.chomp.to_i == 1 ? true : false
  end

  def game_finish
    puts "Спасибо за игру"
  end

  def player_warning
    puts 'У вас уже три карты'
  end

  def player_current_state(cards, score)
    puts "Ваши кары: #{cards} "
    puts "У Вас #{score} очков"
  end

  def diller_current_state(cards, score)
    puts "Диллера кары: #{cards} "
    puts "У Диллера #{score} очков"
  end

  def player_current_choice
    puts 'Сделайте Ваш выбор:'
    puts '1  --  Пропустить'
    puts '2  --  Добавить карту'
    puts '3  --  Открыть карты'
    choice = gets.chomp.to_i
    choice
  end

  def player_message_win(wallet)
    puts "Вы выиграли"
    puts "У Вас в кошелке #{wallet} $"
  end
  def diller_message_win(wallet)
    puts "Вы проиграли"
    puts "У Вас в кошелке #{wallet} $"
  end
  
  def draw(wallet)
    puts "Ничья"
    puts "У Вас в кошелке #{wallet} $"
  end

  def diller_skip
    puts 'Диллер пропускает'
  end

  def diller_gets_card
    puts 'Диллер взял карту'
  end

  def whole_report(player_cards, player_score, diller_cards, diller_score) 
    player_current_state(player_cards, player_score)
    diller_current_state(diller_cards, diller_score)   
  end
end
