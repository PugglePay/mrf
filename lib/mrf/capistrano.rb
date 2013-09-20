require 'mrf'

Capistrano::Configuration.instance(:must_exist).load do
  namespace :mrf do

    desc("Uppload Secrets")
    task :upload_secrets do
      MrF::Project.unpack_secrets.each do |filepath, content|
        upload(content, File.join(release_path, filepath))
      end
    end

  end
end
