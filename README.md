Installation
------------

Install ruby version 2.2.2 using rvm .
```sh
rvm install ruby-2.2.2
```
Use ruby verion 2.2.2 with a new gemset
```sh
rvm use ruby-2.2.2@mobile-offers-app --create
```
Install bundle.
```sh
bundle install
```
Now the setup is complete.

Start server
------------
```sh
rvm use ruby-2.2.2@mobile-offers-app
bundle exec rails s
```
You can now go to http://localhost:3000/

Unit Testing
------------

```sh
bundle exec rspec
```
