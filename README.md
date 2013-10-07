# Mr F

## For british eyes only

A libary for uploading gpg secrets with capistrano.

put your secrets in a gpg encrypted file. Ex: `config/secrets.{{Rails.env}}.yml.gpg`

Then add mrf to you deploy script like this

```ruby
require 'mrf/capistrano'
set :mrf_secrets_path, "myproject/config/secrets.#{rails env maybe?}.yml.gpg"
set :mrf_remote_config_dir, "myrelease/config"
after "deploy", "mrf:upload_secrets"
```

It will ask you for your gpg passphrase while deploying.
And upload the files listed in secrets to your server (file mode 0600 by default)

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

non_yaml_suff.key: |
  -----BEGIN PGP PRIVATE KEY BLOCK-----
  Version: GnuPG v1.4.14 (Darwin)

  lQH+BFI4SpEBBAC7culGRvKFA6mob902i8u4irg1jYP4WtJDtNMoMbCjhLrjE3kg
  Z8I9f0xpaBFZ2kHuD5Om7XH1w1OQ9G5EFiDBReCToe+xz7GLtFuJ/lDwLYLVHJiZ
  yPQKOv64kZ8F+063dr8j2NryBhKiJvcTIF2l0LWsI4OkfboLATVOUu1TqwARAQAB
  /gMDAremiA+pJjFcYPk8Ox0ynig50LCn1QuTja77+/ZjGoYsO9e7l11/6YcAGSb6
  e6zKkQqiSXUOLS912pRQk976Xl0mXLzQCLEufkdooh9SrQjfRoZVulwIjtrJj/CC
  r4iCSFyilrZOeSNIVGMXjkvSykHkiKc8XJiC3iXvaZa9nxJZOfvCVOW80NaNwDEv
  h7a1va+vlQAtlkiplXt/n2Y+4TfY2PjZnBC2hXn7FRxj45upOxuTo1B4RSEiN+8q
  IP3jbBSeq11Z7KMJXH/mEKRdjdxSFql9gnhX3XvWMifTULbw5ynur8ZKc8J99kGU
  /NYEo197z5KjvG5iBlHgiv7tGQOcpETaN635X2er95itKwdOhda0chJY2u4TybSn
  ali2e6GVk0qFmv5Q74I/j/YqzCX02K1LOkVsWvFS+7LE/tZejtovFSv8bTnXrxTa
  Q4lEjfIKPXH1Ckw08mLx2FtpQYbSdIrGLZxPmfMsKXH2tC1Ub2JpYXMgRnVua2Ug
  KE1yIEYpIDx0b2JpYXNAYmx1ZW1hbmdyb3VwLm9yZz6IuAQTAQIAIgUCUjhKkQIb
  AwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQcYQDPAkatwFLswP7BIViV0+9
  6EvKVULGRtHPO2vZil7AR+WL8BEk22bGlFmGjRxBYmfs4TTmzJPO+KSplSgsAz/h
  eXlyKYlHL3CgM01GUi00gqpqZ+ppMhvgs5l5gYmTo9s2iuIuNi1EFyNLf+ocwMgB
  tEQm2yzjhRqSOq4aTIbj+vG7sYGRNyREsZadAf0EUjhKkQEEAL+8DiuGPFj+gpmL
  qeJ13M9Kh9HG+dIK3vfWw4bW49UFB4xr2hugBuMqh5vlGvJvpqei3MZNiEWegHD0
  5dr7e/KA6qX0PlTgl4hovhU2G/2DKn3wXAmBFj8Y98y1GCiPG3e6+PeZkzveTmNb
  yWKFLunJSgbouvEpRREU3JabN7d1ABEBAAH+AwMCt6aID6kmMVxgiqLxlLOL1l53
  erOOeSIUMkGG9odtsVNCk/Ot/5nhMGbolZ5tZlCoatwC3T3ZBSbKG6pElTb53sXn
  ORGRUPD/bUxDHLe+6jF8BuW0l/SkpBQ2265MTyF9EQE59JVibm+75nHhA8DZzUaz
  fkKNXcEqQaB2oiBVD+BH5Io51aUFtZTcahSUtK+2GK1IKiSfRA/kF8ZkbjXMURcY
  qil68hGVR6CNXgoCtbDK5TFueGiGu+p9lsrMexmvp+zxPtpQN+ewaWsIajfpcXPg
  evl/Vw/5v/IPMJPMG3qiqZTEPaf/NWdO+wkCd1Q0CsIMiYQbBQmXgh7YOxK5y62q
  J7biPD+G2txFWT1xlDjW9FTIiTp0vOvpD4YQ/ehxyhWgMmDHoSb6ed5pLpAiLkgb
  /1TNVkdeigkRdO/2nu92uLMENJP2QSGKEH0cX5ao8jmiRz84T69pgOH9nyQeyy1C
  pSpEQlhITl0m/YifBBgBAgAJBQJSOEqRAhsMAAoJEHGEAzwJGrcBerkD/R5RkyKi
  8K4p+zX4dSYP/i9PhLZeVP0tjCYj48eTJg17fnyFbeK6VwZ30bMK7VYBJzPCCeza
  5xTiZlBAC/BByRZiSGWTEiec6U4y6GSpkdi8fWrWp8KkFhHm9yviJk0Up8g9QLo3
  a1W2egzD5CeUVPSYxEIj7FgEMA39UxYwVABv
  =NGkh
  -----END PGP PRIVATE KEY BLOCK-----
```

## Running the specs

```shell
bundle install # install deps
./scripts/import_test_keys
rake # runs the tests
```
