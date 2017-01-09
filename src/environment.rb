require 'ostruct'
require_relative './file_encryptor'
require_relative './encryption_paths'

module Environment
  def self.key_value_pairs(environment)
    Environment.keys(environment).map { |key| OpenStruct.new(
      key: key,
      value: FileEncryptor.decrypt_value(key, environment)
    )}
  end

  def self.keys(environment)
    keys_path = EncryptionPaths.environment(environment)
    Dir.entries("#{keys_path}").select {|file| !File.directory? file}
  end
end