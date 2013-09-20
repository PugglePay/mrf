require 'spec_helper'

module MrF
  describe Project do
    before do
      Project.configure do |p|
        p.project_root = fixture_path('.')
        p.gpg_passphrase = '1234'
      end
    end

    it "can unpack secrets" do
      files = Project.unpack_secrets

      expect(YAML.load(files["config/database.yml"].string)).
        to eq("production" => {"host" => "some_host"})

      expect(YAML.load(files["config/app.yml"].string)).
        to eq("production" => {"password" => "some_password"})
    end

    it "can unpack secrets in diferent env" do
      Project.env = "sandbox"
      files = Project.unpack_secrets

      expect(YAML.load(files["config/database.yml"].string)).
        to eq("password" => "some_sandbox_password")
    end
  end
end
