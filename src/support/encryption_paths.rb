module EncryptionPaths
  def self.keys(environment)
    "keys/#{environment}"
  end

  def self.public_key(environment)
    "keys/#{environment}/public.key"
  end

  def self.private_key(environment)
    "keys/#{environment}/private.key"
  end

  def self.environment(environment)
    "configuration/#{environment}"
  end

  def self.encrypted_value(environment, key)
    "configuration/#{environment}/#{key}"
  end
end