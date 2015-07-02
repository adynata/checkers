class Player
  attr_reader :color
  ALL_COLORS = [:b, :r]

  def initialize(color)
    @color = color
  end

  def opponent_color
    if self.color == :r
      return :b
    else
      return :r
    end
    raise "player has no color"
  end
end



# Bill = Player.new(:b)
#
# Julie = Player.new(:r)
#
# puts "Bill's opponent's color is #{Bill.opponent_color}"
#
# p Bill.color
