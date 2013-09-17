require 'spec_helper'

module MrF
  describe Project do
    it 'can get secrets from a project' do
      Project.project_root = fixture_path('.')
      Project.gpg_passphrase = '1234'

      content = YAML.load(Project.file_io_secrets.first[:io].string)
      expect(content).to eq("production" => {
        "database-password" => 'password1'
      })
    end
  end
end
