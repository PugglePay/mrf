module MrF
  module Project
    extend self

    attr_accessor :project_root
    attr_accessor :gpg_passphrase
    attr_writer :files
    attr_writer :env

    def configure
      yield self
    end

    def env
      @env || ENV['MRF_ENV'] || ENV['RAILS_ENV'] || 'production'
    end

    def files
      @files || { "config/app.#{env}.yml.gpg" => 'config/app.yml' }
    end

    def file_io_secrets
      files.map do |local_path, server_path|
        keyring = Keyring.new(
          path: File.join(root_path, local_path),
          gpg_passphrase: gpg_passphrase
        )

        { path: server_path, io: StringIO.new(YAML.dump(keyring.data)) }
      end
    end

    private

    def root_path
      project_root || Rails.root
    end
  end
end
