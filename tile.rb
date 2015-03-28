
class Tile
  attr_accessor :location, :value, :bombed, :flagged, :bomb_count, :reveal

  def initialize(row, col, board)
    @board = board
    @location = [row,col]
    @bombed = false
    @flagged = false
    @revealed = false
    @value = "*"
    @bomb_count = 0
  end

  def define_bomb_value
    @board.bomb_index.each do |arr|
      @board[arr[0]][arr[1]].bombed = true
    end
  end

  def inspect
    @value
  end

  def reveal
    r = @location[0]
    c = @location[1]

    if @board.tile_at(@location).bomb_count > 0
      @board.tile_at(@location).value = "#{@bomb_count}"
    else
      @board.tile_at(@location).neighbors
      @adj.each do |neigh|
        neigh = @board.tile_at(neigh)
        if neigh.value == "*" && neigh.bomb_count < 1 && neigh
          neigh.value = "_"
          neigh.reveal
        end
      end
    end
  end

  def neighbors
    @adj = []
    r = @location[0]
    c = @location[1]

    @adj << [r - 1, c + 1] unless r - 1 < 0 || c + 1 > (8)
    @adj << [r - 1, c    ] unless r - 1 < 0
    @adj << [r - 1, c - 1] unless r - 1 < 0 || c - 1 < 0
    @adj << [r    , c - 1] unless              c - 1 < 0
    @adj << [r    , c + 1] unless              c + 1 > 8
    @adj << [r + 1, c - 1] unless r + 1 > (8) || c-1 < 0
    @adj << [r + 1, c    ] unless r + 1 > (8)
    @adj << [r + 1, c + 1] unless r + 1 > (8) || c + 1 > (8)
  end

  def neighbor_bomb_count
    @adj.each do |pos|
      if @board[pos[0], pos[1]].bombed == true
        @bomb_count += 1
      end
    end
  end

  def place_flag
    @flagged = true
    @value = "f"
  end
end
