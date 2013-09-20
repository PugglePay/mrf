module MrF
  module Project
    extend self

    attr_accessor :project_root
    attr_accessor :gpg_passphrase
    attr_writer :env
    attr_writer :secrets_path

    def configure
      yield self
    end

    def env
      @env || ENV['MRF_ENV'] || ENV['RAILS_ENV'] || 'production'
    end

    def secrets_path
      @sercrets_path || "config/secrets.#{env}.yml.gpg"
    end

    def unpack_secrets
      keyring = Keyring.new(
        path: File.join(root_path, secrets_path),
        gpg_passphrase: gpg_passphrase
      )

      keyring.data.reduce({}) do |acc, (filename, data)|
        filepath = File.join(File.dirname(secrets_path), filename)
        content = StringIO.new(YAML.dump(data))
        acc.merge(filepath => content)
      end
    end

    private

    def root_path
      project_root || Rails.root
    end
  end
end
