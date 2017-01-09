require 'fileutils'
require_relative './paths'

module EncryptedValue
  def self.read(environment, key)
    encrypted_value_path = Paths.encrypted_value(environment, key)
    File.read(encrypted_value_path)
  end

  def self.write(environment, key, encrypted_value)
    create_environment_directory(environment)
    encrypted_value_path = Paths.encrypted_value(environment, key)
    File.write(encrypted_value_path, encrypted_value)
  end

  private

  def self.create_environment_directory(environment)
    environment_path = Paths.environment(environment)
    FileUtils.mkdir_p(environment_path)
  end
end