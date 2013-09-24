require 'yaml'
module MrF
  class Project
    attr_accessor :gpg_passphrase
    attr_accessor :secrets_path

    def initialize (opts={})
      @secrets_path   = opts.fetch(:secrets_path)
      @gpg_passphrase = opts.fetch(:gpg_passphrase, nil)
    end

    def unpack_secrets
      raise "File not found: #{secrets_path}" unless File.exists?(secrets_path)
      keyring = Keyring.new(
        path: secrets_path,
        gpg_passphrase: gpg_passphrase
      )

      keyring.data.reduce({}) do |acc, (filename, data)|
        content = StringIO.new(yaml_file?(filename) ? YAML.dump(data) : data)
        acc.merge(filename => content)
      end
    end

    def yaml_file? (path)
      path =~ /\A.*\.yml\Z/
    end
  end
end
