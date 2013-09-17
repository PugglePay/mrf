# Mr F

## For british eyes only

A libary for uploading gpg secrets with capistrano.

```ruby
# Put in your deploy.rb

require 'mrf/capistrano'

after "deploy", "mrf:upload_secrets"
# This will upload config/app.production.yml.gpg to config/app.yml on your server
# or if you have some other deploy env
```

## Configuration

The above example is the default behavior you can configure it with `MrF::Project.configure`

```ruby
MrF::Project.configure do |project|
  project.project_root = Rails.root
  project.gpg_passphrase = '1234' # default is to ask you for it with the console
  project.files = { "config/app.production.yml.gpg" => 'config/app.yml' }
  project.env = 'sandbox' # default is to use MRF_ENV or RAILS_ENV
end
```

## Running the specs

```shell
bundle install # install deps
./scripts/import_test_keys
rake # runs the tests
```
