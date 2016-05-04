[![Code Climate](https://codeclimate.com/github/andela-gogbara/lifelist-api/badges/gpa.svg)](https://codeclimate.com/github/andela-gogbara/lifelist-api)
[![Coverage Status](https://coveralls.io/repos/github/andela-gogbara/lifelist-api/badge.svg?branch=master)](https://coveralls.io/github/andela-gogbara/lifelist-api?branch=master)
[![Circle CI](https://circleci.com/gh/andela-gogbara/lifelist-api.svg?style=svg)](https://circleci.com/gh/andela-gogbara/lifelist-api)

## Introduction
Lifelist-api is an API for creating bucketlist of things you which to complete in your lifetime, e.g Books to read, Places to travel and so many other fascinating things. Lifelist-api also gives your the ability to add items to your bucketlists.

## Getting Started

To run this application locally, you will need to either clone this repository or fork it. You can also download the entire repository as a zip package and run locally.

## Features

Lifelist-api is an API service that allows users create bucketlists to store items. Bucketlists are initialized with a name. Items are stored under bucketlists, with a name and a done-status indicating whether item has been completed or not.

For full access to the API, a user account is required. After registration, an initial request is made to log in to user account. This request generates a JSON Web Token, which is returned in the response. This token is used to authenticate subsequent requests to the API.

## Dependencies

This application runs on Rails which is a Ruby powered framework built to make developing web applications faster. If you intend to run this application locally, you must make sure you have the following installed:

* [Install Ruby](http://www.ruby-lang.org)
* [Install Rails](http://rubyonrails.org)
* [Install Rails API](https://github.com/rails-api/rails-api)
* [Install RubyGems](https://rubygems.org/pages/download)
* [Install Bundler](http://bundler.io/)

That should get you all set up for running locally. If you run into any issues installing any of the above, your safest bet is to google it as there is already a solution on-line.

Once you have a copy of this project and it's dependencies installed, you are good to go. run `bundle install` to install all the required external dependencies.

## Database Setup

Run the following command from the terminal:
```
rake db:create db:migrate
```
Create the database for the test environment as well:
```
rake db:create db:migrate RAILS_ENV=test
```

## Running the tests

Run the following command from the terminal to get all tests running
```
rspec spec
```

<<<<<<< 88de387d08fa8120dbafe7c25bf3807befe5f590
## API EndPoint
=======
## API EndPoints
>>>>>>>  feat(readme): add read me file

The following endpoints are available

| EndPoint                                |   Functionality                      |
| --------------------------------------- | ------------------------------------:|
| POST /auth/login                        | Logs a user in                       |
| GET /auth/logout                        | Logs a user out                      |
| POST /bucketlists/                      | Create a new bucket list             |
| GET /bucketlists/                       | List all the created bucket lists    |
| GET /bucketlists/:id                    | Get single bucket list               |
| PUT /bucketlists/:id                    | Update this bucketlist               |
| DELETE /bucketlists/:id                 | Delete this single bucketlist        |
| POST /bucketlists/:id/items/            | Create a new item in bucketlist      |
| PUT /bucketlists/:id/items/:item_id     | Update a bucketlist item             |
| DELETE /bucketlists/:id/items/:item_id  | Delete an item in a bucket lists     |


## Versioning
Changes and upgrades are made from time to time in this API. The API is versioned to avoid code breaking. New changes are implemented under a new version.

## Limitations
The API only responds with json, and does not yet have support for xml and other response types.

OAuth not yet implemented.

## API Documentation

The full documentation for the API and all available endpoints is explained [here](http://lifelist-api.herokuapp.com)

## Contributing

1. Fork it: [Fork a-bucketlist on Github](https://github.com/andela-gobara/lifelist-api/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

note: I might not respond to pull requests immediately as I am usually quite busy.
