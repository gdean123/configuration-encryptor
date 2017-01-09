require 'thor'
require_relative './file_encryptor'
require_relative './environment'

class Cli < Thor
  desc 'generate-keypair', 'Write public and private key files into the keys directory'
  option :environment, required: true
  def generate_keypair
    FileEncryptor.generate_keypair(options[:environment])
  end

  desc 'encrypt', 'Encrypt a value using the public key'
  option :key, required: true
  option :value, required: true
  option :environment, required: true
  def encrypt
    FileEncryptor.encrypt_value(options[:key], options[:value], options[:environment])
  end

  desc 'decrypt', 'Decrypt a value using the private key'
  option :key, required: true
  option :environment, required: true
  def decrypt
    puts FileEncryptor.decrypt_value(options[:key], options[:environment])
  end

  desc 'keys', 'Show all keys for an environment'
  option :environment, required: true
  def keys
    puts Environment.keys(options[:environment])
  end

  desc 'show', 'Show all key/value pairs for an environment'
  option :environment, required: true
  def show
    Environment.key_value_pairs(options[:environment]).each do |key_value_pair|
      puts "#{key_value_pair.key} = #{key_value_pair.value}"
    end
  end
end