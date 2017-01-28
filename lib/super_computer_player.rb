require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def initialize
    @name = "super_computer_player"
  end
  def move(game, mark)
    root = TicTacToeNode.new(game.board, mark)
    children = root.children
    children.each do |child|
      return child.prev_move_pos if child.winning_node? mark
    end

    children.each do |child|
      return child.prev_move_pos unless child.losing_node? mark
    end

    raise("we should atleast be a able to draw")
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Bruk")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
