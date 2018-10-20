# Connect 4 
# Ref: https://en.wikipedia.org/wiki/Connect_Four
#
# Task
#  	The game consists of a grid (7 columns and 6 rows) and two players
#   that take turns to drop a plastic disc into the top of any chosen column.
#
#   The pieces fall straight down, occupying the next available space within the column.
#
#   The objective of the game is to be the first to form a horizontal, vertical, or
#   diagonal line of four of one's own discs.
#
# Your task is to create a Class called Connect4 that has a method called play,
# which takes one argument for the column where the player is going to place their disc.
# 
# Rules
#  	If a player successfully has 4 discs horizontally, vertically or diagonally
#   then you should return "Player n wins!” where n is the current player either 1 or 2.
#
# If a player attempts to place a disc in a column that is full then you should
# return ”Column full!” and the next move must be taken by the same player.
#
# If the game has been won by a player, any following moves should return ”Game has finished!”.
#
# Any other move should return ”Player n has a turn” where n is the current player either 1 or 2.
#
# Player 1 starts the game every time and alternates with player 2. Your class must
# keep track of who's turn it is.
#
# The columns are numbered 0-6 left to right.

class Connect4

  def initialize
    #your code here
    @cols = Array.new(7) { Array.new }
    @player = 1
    @finished = false
  end

  def play(column)
    # check to see if game already finished
    return "Game has finished!" if @finished
    # check if the column is full
    return "Column full!" if @cols[column].length >= 6
    # insert the player id into the column
    @cols[column] << @player
    row = @cols[column].length - 1
    # check each possible vector that includes the current move for a match 4
    if  hasWon(row, column, -1, 1) || # check diagonal
        hasWon(row, column, 1, 1) || # check other diagonal
        hasWon(row, column, 0, -1) || # check vertical
        hasWon(row, column, 1, 0)  # check horizontal
          @finished = true
          return "Player #{@player} wins!"
    end
    # switch player
    @player = 3 - @player
    return "Player #{3 - @player} has a turn"
  end  

  # Given the row and column of the current move and a vector, determine if there is a line of 4 tokens
  # by this player, including the current move. If so, then the player wins.
  def hasWon(row, column, vx, vy)
    sumRunLength(row, column, vx, vy) + sumRunLength(row, column, -vx, -vy) - 1 >= 4
  end

  private

  # Recursively sum continuous run of current player tokens along the given vector
  def sumRunLength(row_index, col_index, row_offset, col_offset)
    return 0 if col_index < 0 || row_index < 0 || @cols[col_index][row_index] != @player
    sumRunLength(row_index + row_offset, col_index + col_offset, row_offset, col_offset) + 1
  end

end


# start = Time.now
# 10000.times do
#   x = Connect4.new
#   x.play(1)
#   x.play(1)
#   x.play(2)
#   x.play(2)
#   x.play(3)
#   x.play(3)
#   x.play(4)
# end
# puts Time.now - start
