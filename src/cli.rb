require 'thor'
require_relative './encryptor'
require_relative './keypair'
require_relative './encrypted_value'
require_relative './encryption_paths'

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
    encrypt_value(options[:key], options[:value], options[:environment])
  end

  desc 'decrypt', 'Decrypt a value using the private key'
  option :key, required: true
  option :environment, required: true
  def decrypt
    puts decrypt_value(options[:key], options[:environment])
  end

  desc 'keys', 'Show all keys for an environment'
  option :environment, required: true
  def keys
    puts keys_for_environment(options[:environment])
  end

  desc 'show', 'Show all key/value pairs for an environment'
  option :environment, required: true
  def show
    keys = keys_for_environment(options[:environment])
    keys.each do |key|
      value = decrypt_value(key, options[:environment])
      puts "#{key} = #{value}"
    end
  end

  private

  def encrypt_value(key, value, environment)
    public_key = Keypair.read_public_key(options[:environment])
    encrypted_value = Encryptor.encrypt(options[:value], public_key)
    EncryptedValue.write(options[:environment], options[:key], encrypted_value)
  end

  def decrypt_value(key, environment)
    private_key = Keypair.read_private_key(environment)
    encrypted_value = EncryptedValue.read(environment, key)
    Encryptor.decrypt(encrypted_value, private_key)
  end

  def keys_for_environment(environment)
    keys_path = EncryptionPaths.environment(environment)
    Dir.entries("#{keys_path}").select {|file| !File.directory? file}
  end
end