require "digest/sha1"
require "openssl"
require "base64"
require "uri"

class Security
  def self.generate_random_string(length)
    letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_-"
    result = ""
    length.times do
      index = rand(letters.length)
      result = result + letters[index]
    end
    return result
  end

  def self.hash_password(password, salt, count)
    result = ""

    hashed = salt + password;

    count.times do
      hashed = Digest::SHA2.hexdigest(hashed)
    end

    if hashed.length > 10
      result = hashed[5..hashed.length - 5]
    end

    return result
  end

  #this method is used to generate salt for users
  def self.generate_salt
    return self.generate_random_string(10)
  end

  # this method is used for hashing passwords of users
  def self.hash_pass(password, salt)
    return self.hash_password(password, salt, 200)
  end
  
  #this method is to check the entered password is correct
  def self.check_pass(password, salt, entered_password)
    hashed = self.hash_pass(entered_password, salt)
    return hashed == password
  end

  def self.encrypt(key, message)
    aes = OpenSSL::Cipher::Cipher.new("aes-256-cbc")

    aes.encrypt
    aes.key = key
    aes.iv = iv = aes.random_iv

    encrypted = aes.update(message) + aes.final
    encrypted = iv + encrypted
    return Base64.encode64(encrypted)
  end

  def self.decrypt(key, encrypted)
    aes = OpenSSL::Cipher::Cipher.new("aes-256-cbc")

    aes.decrypt
    aes.key = key

    encrypted = URI.unescape(encrypted)
    encrypted = Base64.decode64(encrypted)

    aes.iv = encrypted.slice!(0,16)

    decrypted = aes.update(encrypted) + aes.final
    return decrypted
  end
end

