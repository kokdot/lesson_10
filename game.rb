require_relative('desk')
require_relative('interface')
game = Desk.new
game.controller
while game.game_finish? do 
  game.controller
end
game.game_finish
