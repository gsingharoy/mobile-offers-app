# mobile-offers-app

Description
-------------
This is a simple UI solution to search for mobile offers using the [Fyber api](http://developer.fyber.com/content/current/ios/offer-wall/offer-api/).

Installation
------------

Install ruby version 2.3.0 using rvm .
```sh
rvm install ruby-2.3.0
```
Use ruby verion 2.3.0 with a new gemset
```sh
rvm use ruby-2.3.0@mobile-offers-app --create
```
Install bundle.
```sh
bundle install
```
Now the setup is complete.

Start server
------------
```sh
rvm use ruby-2.3.0@mobile-offers-app
bundle exec rails s
```
You can now go to http://localhost:3000/

Unit Testing
------------

```sh
bundle exec rspec
```

Project notes
-------------
1. There is a library class, [ApiClients::Fyber::MobileOffers](https://github.com/gsingharoy/mobile-offers-app/blob/master/lib/api_clients/fyber/mobile_offers.rb), which is responsible for fetching the data from the Fyber API. All the magic, like having the parameters in the correct order and generating a proper hashkey, happens here.
2. Default API parameter values can be configured in a [YAML File](https://github.com/gsingharoy/mobile-offers-app/blob/master/config/api_clients/fyber/mobile_offers.yml).
3. An interactor class, [RetrieveOffers](https://github.com/gsingharoy/mobile-offers-app/blob/master/app/interactors/retrieve_offers.rb), is responsible for retrieving offers and generating appropiate errors if it encounters any. This design is useful as the same interactor can be used for future mobile APIs and removes the code from controllers.
