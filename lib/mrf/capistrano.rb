require 'mrf'

Capistrano::Configuration.instance(:must_exist).load do
  namespace :mrf do
    desc("Uppload Secrets")
    task :upload_secrets do
      MrF::Project.file_io_secrets.each do |file|
        upload(file[:io], File.join(release_path, file[:path]))
      end
    end
  end
end
