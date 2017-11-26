# README

To get started, clone this codebase, and in the project's directory in the terminal, run the following commands:

```
bundle
rake db:create
rake db:migrate
rake db:seed
```

You also need to create an application.yml file in the `config` folder. You must ask your project leader for the code for this file, as it contains sensitive information that cannot be published on Github.

This application makes extensive use of the Twilio API. Besides for making requests to the API, Twilio also makes web requests from this application (known as "webhooks"). This becomes difficult to test when developing locally, as Twilio will not be able to make a web request to your "localhost:3000." To get around this, we recommend using a tool like [ngrok](https://ngrok.com/download), which creates a url on the web that actually connects to localhost. Twilio itself has a [great blog post about this topic](https://www.twilio.com/blog/2015/09/6-awesome-reasons-to-use-ngrok-when-testing-webhooks.html).

There's also a good chance that you will need to log in to the Twilio console at some point; reach out to your project leader for credentials.  