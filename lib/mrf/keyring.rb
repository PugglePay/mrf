require 'rubygems'
require 'bundler'
require 'gpgme'
require 'yaml'
require 'io/console'

module MrF
  class Keyring
    attr_accessor :path, :recipients
    attr_reader :gpg_passphrase

    def initialize (opts = {})
      @path = opts.fetch(:path)
      @gpg_passphrase = opts[:gpg_passphrase]
    end

    def data
      return @data if @data
      if File.exists?(path)
        raw_text = crypto.decrypt(File.open(path), passphrase_callback: method(:passfunc))
        @data = YAML.load(raw_text.to_s)
      else
        @data = {}
      end
    end

    def passfunc (obj, uid_hint, passphrase_info, prev_was_bad, fd)
      # Use known passphrase when given
      if @gpg_passphrase
        io = IO.for_fd(fd, 'w')
        io.puts(@gpg_passphrase)
        io.flush
        return
      end

      # Try from keychain
      key_id = passphrase_info.split(' ').first
      key_id = uid_hint[/<[^<>]*>$/].tr("<>", "")
      dump = `security -q find-generic-password -s "gpg-#{key_id}" -g 2>&1`
      password = dump[/password: "(.*)"/, 1]

      if password
        io = IO.for_fd(fd, 'w')
        io.puts(password)
        io.flush
        return
      end

      # Prompt user
      begin
        console = IO.console
        console.write("Passphrase for #{uid_hint}: ")
        console.noecho do |noecho|
          io = IO.for_fd(fd, 'w')
          io.puts(noecho.gets)
          io.flush
        end
        console.puts
      ensure
        (0 ... $_.length).each do |i| $_[i] = ?0 end if $_
      end
    end

    def crypto
      @crypto ||= GPGME::Crypto.new
    end
  end
end
