require_relative 'tile'
class Board
  attr_accessor :bomb_index

  def self.populate_board
    @grid = Array.new(9){Array.new(9)}
  end

  def initialize(@grid = )
    @grid =
  end

  def self.place_bomb
    n = 0
    while n < num_of_bomb
      first_num = rand(8)
      second_num = rand(8)
      unless @bomb_index.include?([first_num, second_num])
        @bomb_index << [first_num, second_num]
        n += 1
      end
    end
  end

  def initialize_tiles
    @grid.each_with_index do |row, row_ind|
      row.each_with_index do |item, col_ind|
        make_tile(row_ind, col_ind)
      end
    end
  end

  def make_tile(row,col)
     @grid[row][col] = Tile.new(row,col, self)
  end

  def display
    @grid.each do |row|
      p row
    end
  end

  def check_if_won
    @won = true
    @board.each do |row|
      if row.include?("*")
        @won = false
      end
    end
    unless @flagged_index.length == @bomb_index.length
      @won == false
    end
    @won
  end


  def check_if_lost
    # @lost = true


  end

  def tile_at(pos)
    row, col = pos
      @grid[row][col]
  end
end
