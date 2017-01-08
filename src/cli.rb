require 'thor'
require 'fileutils'
require_relative './encryptor'

class Cli < Thor
  desc 'generate-keypair', 'Write public and private key files into the keys directory'
  option :environment, required: true
  def generate_keypair
    keypair = Encryptor.generate_keypair

    path = "keys/#{options[:environment]}"
    FileUtils.mkdir_p(path)
    Dir.chdir(path) do
      File.write('public.key', keypair.public_key)
      File.write('private.key', keypair.private_key)
    end
  end

  desc 'encrypt', 'Encrypt a value using the public key'
  option :key, required: true
  option :value, required: true
  option :environment, required: true
  def encrypt
    public_key_path = "keys/#{options[:environment]}/public.key"
    environment_path = "configuration/#{options[:environment]}"
    encrypted_value_path = "#{environment_path}/#{options[:key]}"

    encrypted_value = Encryptor.encrypt(options[:value], File.read(public_key_path))
    FileUtils.mkdir_p(environment_path)
    File.write(encrypted_value_path, encrypted_value)
  end

  desc 'decrypt', 'Decrypt a value using the private key'
  option :key, required: true
  option :environment, required: true
  def decrypt
    private_key_path = "keys/#{options[:environment]}/private.key"
    environment_path = "configuration/#{options[:environment]}"
    encrypted_value_path = "#{environment_path}/#{options[:key]}"

    encrypted_value = File.read(encrypted_value_path)
    puts Encryptor.decrypt(encrypted_value, File.read(private_key_path))
  end
end