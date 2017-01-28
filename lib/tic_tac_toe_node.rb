require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if board.over?
      return false if board.winner == evaluator || board.tied?
      return true if board.winner != evaluator
    end

    results = []
    children.each do |child|
      results << child.losing_node?(evaluator)
    end

    if next_mover_mark == evaluator
      return false if results.include? false
    elsif next_mover_mark != evaluator
      return true if results.include? true
    end

    next_mover_mark == evaluator ? true : false
  end


  def winning_node?(evaluator)
    if board.over?
      return true if board.winner == evaluator
      return false if board.winner != evaluator || board.tied
    end

    results = []
    children.each do |child|
      results << child.losing_node?(evaluator)
    end

    if next_mover_mark == evaluator
      return true if results.include? true
    elsif next_mover_mark != evaluator
      return false if results.include? false
    end

    next_mover_mark == evaluator ? true : false
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    board.rows.each_with_index do |row, i|
      row.each_with_index do |mark, j|
        unless mark
          child_board = board.dup
          child_board[[i, j]] = next_mover_mark
          children << TicTacToeNode.new(child_board, other_mark, [i, j])
        end
      end
    end

    children
  end

  def other_mark
    next_mover_mark == :x ? :o : :x
  end
end
