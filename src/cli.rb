require 'thor'
require 'fileutils'
require_relative './encryptor'
require_relative './paths'

class Cli < Thor
  desc 'generate-keypair', 'Write public and private key files into the keys directory'
  option :environment, required: true
  def generate_keypair
    keypair = Encryptor.generate_keypair

    keys_path = Paths.keys(options[:environment])
    FileUtils.mkdir_p(keys_path)
    File.write(Paths.public_key(options[:environment]), keypair.public_key)
    File.write(Paths.private_key(options[:environment]), keypair.private_key)
  end

  desc 'encrypt', 'Encrypt a value using the public key'
  option :key, required: true
  option :value, required: true
  option :environment, required: true
  def encrypt
    public_key_path = Paths.public_key(options[:environment])
    environment_path = Paths.environment(options[:environment])
    encrypted_value_path = Paths.encrypted_value(options[:environment], options[:key])

    encrypted_value = Encryptor.encrypt(options[:value], File.read(public_key_path))
    FileUtils.mkdir_p(environment_path)
    File.write(encrypted_value_path, encrypted_value)
  end

  desc 'decrypt', 'Decrypt a value using the private key'
  option :key, required: true
  option :environment, required: true
  def decrypt
    private_key_path = Paths.private_key(options[:environment])
    environment_path = Paths.environment(options[:environment])
    encrypted_value_path = Paths.encrypted_value(options[:environment], options[:key])

    encrypted_value = File.read(encrypted_value_path)
    puts Encryptor.decrypt(encrypted_value, File.read(private_key_path))
  end
end