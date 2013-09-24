require 'spec_helper'

module MrF
  describe Project do
    before do
      @project = Project.new(
        secrets_path: fixture_path("config/secrets.production.yml.gpg"),
        gpg_passphrase: '1234'
      )
    end

    it "can unpack secrets" do
      files = @project.unpack_secrets

      expect(YAML.load(files["database.yml"].string)).
        to eq("production" => {"host" => "some_host"})

      expect(YAML.load(files["app.yml"].string)).
        to eq("production" => {"password" => "some_password"})

      expect(files["secret.key"].string).
        to eq("two lines\nof information")
    end

    it "raises error if file does not exist" do
      @project.secrets_path = "not_found"
      expect { @project.unpack_secrets }.to raise_error
    end
  end
end
