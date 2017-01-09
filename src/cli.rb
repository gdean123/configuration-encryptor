require 'thor'
require_relative './encryptor'
require_relative './keypair'
require_relative './encrypted_value'

class Cli < Thor
  desc 'generate-keypair', 'Write public and private key files into the keys directory'
  option :environment, required: true
  def generate_keypair
    keypair = Encryptor.generate_keypair
    Keypair.write_public_key(keypair.public_key, options[:environment])
    Keypair.write_private_key(keypair.private_key, options[:environment])
  end

  desc 'encrypt', 'Encrypt a value using the public key'
  option :key, required: true
  option :value, required: true
  option :environment, required: true
  def encrypt
    public_key = Keypair.read_public_key(options[:environment])
    encrypted_value = Encryptor.encrypt(options[:value], public_key)
    EncryptedValue.write(options[:environment], options[:key], encrypted_value)
  end

  desc 'decrypt', 'Decrypt a value using the private key'
  option :key, required: true
  option :environment, required: true
  def decrypt
    private_key = Keypair.read_private_key(options[:environment])
    encrypted_value = EncryptedValue.read(options[:environment], options[:key])
    puts Encryptor.decrypt(encrypted_value, private_key)
  end
end