require 'mrf'

Capistrano::Configuration.instance(:must_exist).load do
  namespace :mrf do

    desc("Uppload Secrets")
    task :upload_secrets do
      secret_path = fetch(:mrf_secrets_path)
      config_dir = fetch(:mrf_remote_config_dir, File.join(release_path, "config"))

      MrF::Project.new(
        secrets_path: secret_path
      ).unpack_secrets.each do |filepath, content|
        upload(content, File.join(config_dir, filepath))
      end
    end
  end
end
