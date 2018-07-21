GPG:=gpg2 --no-keyring --no-auto-key-locate --no-auto-key-retrieve --no-default-keyring --yes

env: env.enc
	$(GPG) --output env --decrypt env.enc

env.enc: env
	$(GPG) --output env.enc --symmetric env

keys:
	$(GPG) --list-keys

decrypt: env

encrypt: env.enc
