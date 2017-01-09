require_relative './value_encryptor'
require_relative './repositories/public_key'
require_relative './repositories/private_key'
require_relative './repositories/encrypted_value'

module FileEncryptor
  def self.generate_keypair(environment)
    keypair = ValueEncryptor.generate_keypair
    PublicKey.write(keypair.public_key, environment)
    PrivateKey.write(keypair.private_key, environment)
  end

  def self.encrypt_value(key, value, environment)
    public_key = PublicKey.read(environment)
    encrypted_value = ValueEncryptor.encrypt(value, public_key)
    EncryptedValue.write(environment, key, encrypted_value)
  end

  def self.decrypt_value(key, environment)
    private_key = PrivateKey.read(environment)
    encrypted_value = EncryptedValue.read(environment, key)
    ValueEncryptor.decrypt(encrypted_value, private_key)
  end
end