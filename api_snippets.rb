class API < Sinatra::Base
  def initialize
    @ledger = Ledger.new
    super
  end
end