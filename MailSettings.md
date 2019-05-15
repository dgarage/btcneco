# Mail Settings

Currently BTCneco relies on email to send payment links, user credentials, and subscription extension reminders. 
It is strongly recommended that you connect BTCneco to an existing SMTP service. Popular choices include Gmail, Amazon SES, Sendgrid, Mailgun, etc.

### Gmail

1. Go to your Google Account page: https://myaccount.google.com
2. Go to the Security tab
3. Go to Signing in to Google -> App passwords
4. Add an app and generate a password

Change the following Mail Settings in the Admin Settings in BTCneco:

* Origin email: YOUR_PREFERRED_EMAIL_ADDRESS
* Mail user name: YOUR_GMAIL_ADDRESS
* Mail domain: YOUR_DOMAIN
* Mail password: YOUR_APP_PASSWORD_FROM_STEP_4
* Mail address: smtp.gmail.com
* Mail port: 465
* Mail authentication: plain
* Mail enable starttls auto: true

Reference: https://support.google.com/mail/answer/185833?hl=en

### Sendgrid

1. Go to Settings > API Keys
2. Create API Key

Change the following Mail Settings in the Admin Settings in BTCneco:

* Origin email: YOUR_PREFERRED_EMAIL_ADDRESS
* Mail user name: apikey
* Mail domain: YOUR_DOMAIN
* Mail password: YOUR_API_KEY_FROM_STEP_2
* Mail address: smtp.sendgrid.net
* Mail port: 465
* Mail authentication: plain
* Mail enable starttls auto: true

### Other SMTP Server (such as Amazon SES, etc.)

Generally follows the same parameters.
