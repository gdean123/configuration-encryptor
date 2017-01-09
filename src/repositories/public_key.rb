require 'fileutils'
require_relative '../support/encryption_paths'

module PublicKey
  def self.read(environment)
    public_key_path = EncryptionPaths.public_key(environment)
    File.read(public_key_path)
  end

  def self.write(public_key, environment)
    create_keys_directory(environment)
    public_key_path = EncryptionPaths.public_key(environment)
    File.write(public_key_path, public_key)
  end

  private

  def self.create_keys_directory(environment)
    keys_path = EncryptionPaths.keys(environment)
    FileUtils.mkdir_p(keys_path)
  end
end