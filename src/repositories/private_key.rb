require 'fileutils'
require_relative '../support/encryption_paths'

module PrivateKey
  def self.read(environment)
    private_key_path = EncryptionPaths.private_key(environment)
    File.read(private_key_path)
  end

  def self.write(private_key, environment)
    create_keys_directory(environment)
    private_key_path = EncryptionPaths.private_key(environment)
    File.write(private_key_path, private_key)
  end

  private

  def self.create_keys_directory(environment)
    keys_path = EncryptionPaths.keys(environment)
    FileUtils.mkdir_p(keys_path)
  end
end