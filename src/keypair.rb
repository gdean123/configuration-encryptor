class Keypair
  attr_accessor :public_key
  attr_accessor :private_key

  def initialize(public_key, private_key)
    @public_key = public_key
    @private_key = private_key
  end
end