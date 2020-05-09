require_relative('desk')
game = Desk.new
game.start
loop do 
  puts 'Продолжить игру:  1'
  puts 'Выход:  2'
  menu = gets.chomp.to_i
  case menu
  when 1
# game = Desk.new
    game.start
    
  when 2
    break
  end
end
  puts 'Игра Закончена'
