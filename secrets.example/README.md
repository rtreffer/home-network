Secrets
-------

Encrypted (passphrase) secrets for uci defaults.
The secrets will be available as `/etc/secrets/env` in each image and should
be a valid shell environment file.

See env.example as an starting point.

```
cp secrets.example secrets
make encrypt
```
