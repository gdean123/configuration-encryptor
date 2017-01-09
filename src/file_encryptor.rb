require_relative './value_encryptor'
require_relative './keypair'
require_relative './encrypted_value'

module FileEncryptor
  def self.generate_keypair(environment)
    keypair = ValueEncryptor.generate_keypair
    Keypair.write_public_key(keypair.public_key, environment)
    Keypair.write_private_key(keypair.private_key, environment)
  end

  def self.encrypt_value(key, value, environment)
    public_key = Keypair.read_public_key(environment)
    encrypted_value = ValueEncryptor.encrypt(value, public_key)
    EncryptedValue.write(environment, key, encrypted_value)
  end

  def self.decrypt_value(key, environment)
    private_key = Keypair.read_private_key(environment)
    encrypted_value = EncryptedValue.read(environment, key)
    ValueEncryptor.decrypt(encrypted_value, private_key)
  end
end