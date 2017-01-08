require 'thor'
require_relative './encryptor'

class Cli < Thor
  desc 'generate-keypair', 'Write public and private key files'
  def generate_keypair
    Encryptor.generate_keypair
  end

  desc 'encrypt', 'Encrypt a value using the public key'
  option :key, required: true
  option :value, required: true
  def encrypt
    encrypted_value = Encryptor.encrypt(options[:value])
    File.write(options[:key], encrypted_value)
  end

  desc 'decrypt', 'Decrypt a value using the private key'
  option :key, required: true
  def decrypt
    encrypted_value = File.read(options[:key])
    puts Encryptor.decrypt(encrypted_value)
  end
end