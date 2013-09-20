# Mr F

## For british eyes only

A libary for uploading gpg secrets with capistrano.

put your secrets in a gpg encrypted file.
In rails the default is `config/secrets.{{Rails.env}}.yml.gpg`

Then add mrf to you deploy script like this

```ruby
require 'mrf/capistrano'

after "deploy", "mrf:upload_secrets"
```

This will upload the files listed in secrets to the same folder as your secrets
file but on the server.

## A Example secrets file

```yaml
database.yml:
  production:
    adapter: mysql
	database: my_db
	username: 0a1cd3bc-96fa-71d1-4338-27092ca4cfa5
	password: 070f1f0b-2454-3ffa-4aa2-d6e0652d03fe

other_service.yml:
  production:
    password: 115024d2-7c74-326e-c9ec-064f42d08b31
	username: 1e27a053-60a4-af61-f38d-9f1f123740d6
```

## Configuration

The above example is the default behavior but you can configure it with `MrF::Project.configure`

```ruby
MrF::Project.configure do |project|
  project.project_root = Rails.root
  project.gpg_passphrase = '1234' # default is to ask you for it with the console
  project.env = 'sandbox' # default is to use MRF_ENV or RAILS_ENV
end
```

## Running the specs

```shell
bundle install # install deps
./scripts/import_test_keys
rake # runs the tests
```
