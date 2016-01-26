class Offer
  attr_accessor :title, :payout, :thumbnail

  def initialize(attrs = {})
    self.title      = attrs[:title]
    self.payout     = attrs[:payout]
    self.thumbnail  = attrs[:thumbnail]
  end
end