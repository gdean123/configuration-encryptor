require 'fileutils'
require_relative './paths'

module Keypair
  def self.read_public_key(environment)
    public_key_path = Paths.public_key(environment)
    File.read(public_key_path)
  end

  def self.read_private_key(environment)
    private_key_path = Paths.private_key(environment)
    File.read(private_key_path)
  end

  def self.write_public_key(public_key, environment)
    create_keys_directory(environment)
    public_key_path = Paths.public_key(environment)
    File.write(public_key_path, public_key)
  end

  def self.write_private_key(private_key, environment)
    create_keys_directory(environment)
    private_key_path = Paths.private_key(environment)
    File.write(private_key_path, private_key)
  end

  private

  def self.create_keys_directory(environment)
    keys_path = Paths.keys(environment)
    FileUtils.mkdir_p(keys_path)
  end
end