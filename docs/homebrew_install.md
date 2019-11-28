## Install the app
- Make sure [homebrew](https://brew.sh/) is installed
- Fork/clone this repo
- Set ENV vars (below)
- Run `sh scripts.sh install_with_brew`
- Visit http://localhost:3000
- For subsequent server starts just run `sh scripts.sh start`

### Setting ENV vars

#### Required:
- `CIPHER_KEY`: Secret key used in encrypting. It needs to be 32 bytes base 64 encoded. Generate with `Base64.encode64(SecureRandom.random_bytes(32))`.
- `SHARING_TOKEN_CIPHER_IV`: This is to make sure sharing token IVs are
the same so we can find posts from a public route parameter. It needs to be 16 bytes base 64 encoded. Generate with `Base64.encode64(SecureRandom.random_bytes(16))`.

#### For login email alerts (optional):
- `ALERT_EMAIL_RECIPIENT`: Where the alert gets sent to. If this
is missing, emailing will be skipped.
- `SENDGRID_USERNAME`
- `SENDGRID_PASSWORD`
- `MAILER_DOMAIN`
