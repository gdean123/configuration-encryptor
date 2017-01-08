require 'openssl'
require 'base64'
require_relative './keypair'

module Encryptor
  KEY_LENGTH = 4096

  def self.generate_keypair
    keypair = OpenSSL::PKey::RSA.new(KEY_LENGTH)

    Keypair.new(
      OpenSSL::PKey::RSA.new(keypair.public_key.to_pem),
      OpenSSL::PKey::RSA.new(keypair.to_pem)
    )
  end

  def self.encrypt(plaintext_value, public_key_content)
    public_key = OpenSSL::PKey::RSA.new(public_key_content)

    encrypted_binary = public_key.public_encrypt(plaintext_value)
    Base64.encode64(encrypted_binary)
  end

  def self.decrypt(encrypted_value, private_key_content)
    private_key = OpenSSL::PKey::RSA.new(private_key_content)

    encrypted_binary = Base64.decode64(encrypted_value)
    private_key.private_decrypt(encrypted_binary)
  end
end