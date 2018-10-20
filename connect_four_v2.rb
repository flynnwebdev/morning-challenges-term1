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
  
  # Describe the token connection lines in terms of an offset vector
  # The line going in the opposite direction is simply the negative of the vector
  # North is up, and north and west are positive offsets
  @@connect_lines = [
    [0, 1],     # north-south vertical
    [1, 0],     # east-west horizontal
    [1, 1],     # northeast-southwest diagonal
    [-1, 1]     # northwest-southeast diagonal
  ]

  def initialize
    @cols = Array.new(7) { Array.new }
    @player = 1
    @finished = false
  end

  def play(column)
    # check to see if game already finished
    return "Game has finished!" if @finished
    # check if the column is full
    return "Column full!" if @cols[column].length >= 6
    # create a data structure to represent the token
    token = {
      player: @player,
      runlengths: Array.new(4) { 1 }
    }
    # insert token into column
    @cols[column] << token    
    row = @cols[column].length - 1
    @@connect_lines.each_with_index do |offset, index|
      updateTokens(token, getNeighbour(column + offset[0], row + offset[1]), index)
      updateTokens(token, getNeighbour(column - offset[0], row - offset[1]), index)
      if token[:runlengths].max == 4
        @finished = true
        return "Player #{@player} wins!"
      end
    end
    # switch player
    @player = 3 - @player
    return "Player #{3 - @player} has a turn"
  end

  private

  def updateTokens(token, neighbour, index)
    if neighbour
      token[:runlengths][index] += neighbour[:runlengths][index]
      neighbour[:runlengths][index] = token[:runlengths][index]
    end
  end

  def getNeighbour(col, row)
    return nil if col < 0 || row < 0 || @cols[col][row][:player] != @player
    @cols[col][row]
  rescue
    nil
  end

end

start = Time.now
10000.times do
  x = Connect4.new
  x.play(1)
  x.play(1)
  x.play(2)
  x.play(2)
  x.play(3)
  x.play(3)
  x.play(4)
end
puts Time.now - start
