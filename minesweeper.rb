require_relative 'board'

class MineSweeperGame

  def initialize(num_of_bombs)
    @board = Board.new
    @num_of_bombs = num_of_bombs
    @bomb_index = []
    @explored_index = []
    @flagged_index = []
  end

  def play

      until @won == true || @lost == true #check win condition
        turn
      end
  end

  def turn
    @board.display
    puts "Please select a space: 'r,c'"
    space = gets.chomp.split(",").map(&:to_i)
    puts "Reveal or Place Flag? 'r/f' "
    choice = gets.chomp
      if choice == "r"

      else #choice == "f"
        @board[space[0]][space[1]].place_flag
      end
  end

end


b = Board.new
b.initialize_tiles
b.tile_at([0,0]).reveal
b.display
