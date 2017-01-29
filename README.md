# Configuration Encryptor

This tool enables developers to encrypt and decrypt configuration data so that it can be stored safely in version control.

## Installation

Install the required gems with `bundle install`

## Synopsis

```
./bin/encryptor generate-keypair --environment staging
./bin/encryptor encrypt --key DATABASE_URL --value http://localhost:5432 --environment staging
./bin/encryptor decrypt --key DATABASE_URL --environment staging
./bin/encryptor show --environment staging
./bin/encryptor keys --environment staging
```

## Usage

### Keypair Generation

Run `./bin/encryptor generate-keypair --environment <environment>` to generate a public and private key pair and store them in `keys/<environment>/public.key` and `keys/<environment>/private.key`.

For instance `./bin/encryptor generate-keypair --environment production` will generate `keys/production/public.key` and `keys/production/private.key`.

### Encryption

Run `./bin/encryptor encrypt --key <key> --value <value> --environment <environment>` to encrypt the given key/value pair using the public key and store the output file in configuration/<environment>/<key>.

For instance, running `./bin/encryptor encrypt --key DATABASE_URL --value http://some-database-server.com:5432 --environment staging` will create a `configuration/staging/DATABASE_URL` file containing the encrypted value of `http://some-database-server.com:5432`.

It assumes that the public key is stored in `keys/<environment>/public.key`.

### Decryption

Run `./bin/encryptor decrypt --key <key> --environment <environment>` to decrypt the value of the given key for the given environment using the private key and print it to stdout.

For instance, running './bin/encryptor decrypt --key DATABASE_URL --environment development' will decrypt the file at `configuration/development/DATABASE_URL` and print the decrypted value to stdout.

It assumes that the private key is stored in `keys/<environment>/private.key`.
