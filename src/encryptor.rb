require 'openssl'
require 'base64'

module Encryptor
  KEY_LENGTH = 4096  # Key size (in bits)

  def self.generate_keypair
    keypair = OpenSSL::PKey::RSA.new(KEY_LENGTH)

    public_key  = OpenSSL::PKey::RSA.new(keypair.public_key.to_pem)
    private_key  = OpenSSL::PKey::RSA.new(keypair.to_pem)

    File.write('public.key', public_key)
    File.write('private.key', private_key)
  end

  def self.encrypt(plaintext_value)
    public_key = OpenSSL::PKey::RSA.new(File.read("public.key"))

    encrypted_binary = public_key.public_encrypt(plaintext_value)
    Base64.encode64(encrypted_binary)
  end

  def self.decrypt(encrypted_value)
    private_key = OpenSSL::PKey::RSA.new(File.read("private.key"))

    encrypted_binary = Base64.decode64(encrypted_value)
    private_key.private_decrypt(encrypted_binary)
  end
end