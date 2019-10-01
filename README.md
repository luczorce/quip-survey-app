# Quip Survey API

This is a Rails API app to manage survey data coming from Quip live apps.

## Development

Ensure you have at least Ruby 2.5 and Rails >5 installed. Create a .env file locally, and set the following:

```
RACK_ENV=development
PORT=3000
SECURE_KEY=whateveryouwantlocally
QUIP_TOKEN=your_quip_token
```

Then you can install and run the app locally with Heroku:

``` bash
cd quip_survey_app
bundle install
rails db:setup
heroku local -f Procfile.local
```

### Need Local SSL?

1. Read this [helpful tutorial](https://madeintandem.com/blog/rails-local-development-https-using-self-signed-ssl-certificate/)
2. Generate the certificates for local use
   ```
   openssl req -x509 -sha256 -nodes -newkey rsa:2048 -days 365 -keyout localhost.key -out localhost.crt
   ```
3. Replace the web value in the `Procfile` with:
   ```
   web: rails s -b 'ssl://localhost:3000?key=localhost.key&cert=localhost.crt'
   ```
4. Continue on with `heroku local`

_Alternative_: instead of changing the `Procile` you can also run `heroku local -f Profile.local`

### Cleaning up old answers

We'll have a job running on Heroku that will go through each documented quip thread (stored as `quip_id` under each answer type), see if it's valid, and delete any answers that have an invalid thread. To run this locally, use:

``` bash
heroku local:run rake validate_thread_ids
```

### Make sure you migrate any database scheme updates!

```
heroku run -a eio-qi-survey rails db:migrate
heroku run -a deio-qi-survey rails db:migrate
```