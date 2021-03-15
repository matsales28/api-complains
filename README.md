# Complains Api

A Ruby on Rails API using MongoDB.

# What can my project do?

I create an API REST that allow creating complains and getting some data of it.

I've been studying an architeture pattern for Rails projects that add two new abstractions — Repository and Operation (don’t be afraid — it is quite easy to understand), but remove complexity from other abstractions.

This is a good project to apply that knowledge, and put into practice the pros and cons of this architectural pattern.

Repository is a PORO(Plain Old Ruby Object) which used as a connection between business logic and database. That’s the place where you put all your code which is responsible for querying(such as scopes) and managing entities(like creating and updating). The main rule here is that all the queries and changes that happen in the repository should affect only the model it is related to. In this projects we have two Repositories(LocaleRepository and ComplainRepository)

Operation is also a plain Ruby class which contain a code related to one business operation, we also have two Operations on this project(ComplainsOperations/Create and ComplainsOperations/Search) that are main responsible for the logic behind this project.

Basically, we have two entities, Locale and Complain.
I decided to make Locales a new entitie for go further in this project and make new endpoints to generate a better insight about complains and locales.

![Entity_Diagram](https://user-images.githubusercontent.com/54689845/111093412-9bd37280-8517-11eb-9e01-d0590e3ef2b9.png)

This application is deployed to [Heroku](https://api-complains.herokuapp.com/) and has an monitoring application on Airbrake.
![Airbrake](https://user-images.githubusercontent.com/54689845/111095919-38e4da00-851d-11eb-8636-df7ddd93f2b3.png)


The project is **100%** covered by tests, you can get more details of this at coverage_report artifact on Github Action and has a **Score: 97.93** out of 100 on Rubycritic, you can check this by running
`$ rubycritic`

# Deployment and Development Proccess

The development proccess was mainly done with TDD, I struggled a little to make Github's actions work and also to deploy to Heroku.
Heroku did not have an addon (free) for MongoDB banks, so I had to create a cluster in Atlas to be able to connect.

The repository is configured with the actions of Github, and all CI / CD is done by him. The linter (rubocop), code quality check (skunk and rubycritic) are run, in addition to the suite of tests in every commit and pull request.

# Dependencies

## Ruby version

2.6.5p114

## Rails version

Rails 6.0.3.4

# How to use it

1. Clone the repository

```
   $ git clone https://github.com/Instituto-Atlantico/matheus-sales.git
```

2. Running with Docker(jump to step 5 if not using docker)

```
   $ docker-compose build
```

3. Starting the server

```
   $ docker-compose up
```

3. Create Database

```
   $ docker-compose run api-complains rake db:create
```
3. Seed database

```
   $ docker-compose run api-complains rake db:seed
```


4. Running tests

```
   $ docker-compose run -e "RAILS_ENV=test" api-complains rails test
```

5. Running without docker

```
   $ bundle install
```

6. Run the local server

```
   $ rails s
```

7. For running tests

```
   $ rake test
```

# Documentation

This API consists of two endpoints they're all explained on [this]: https://www.getpostman.com/collections/7d8aa39a68dba4669a86 Postman Documentation

### API Resources

- [GET /api/v1/search](#get-search)
- [GET /api/v1/create?](#get-create)

### GET /api/v1/search

In this all parameters are optional. You need to provide at least one for it perform the search. If two or more are provided it will search a match for all.
Request body:

```json
{
  "complain": {
    "company": "ReclameAqui",
    "city": "São Paulo",
    "state": "SP",
    "country": "Brazil",
  }
}
```

Response body:

```json
{
  "total_complains": 2 
}
```

### GET /api/v1/create

In this endpoint all parameters are required
Request body:

```json
{
  "complain": {
      "description": "Did not like the product",
      "title": "Bad product",
      "company": "Gocase",
      "locale": {
          "city": "Fortaleza",
          "state": "CE",
          "country": "Brazil"
      }
  }
}
```

Response body: 

```json
{
    "_id": {
        "$oid": "604ec16e2a80a900044c8ce1"
    },
    "company": "Gocase",
    "created_at": "2021-03-15T02:07:42.600Z",
    "description": "Did not like the product",
    "locale_id": {
        "$oid": "604ec16e2a80a900044c8ce0"
    },
    "title": "Bad product",
    "updated_at": "2021-03-15T02:07:42.600Z"
}
```



# To improve

1. Improve queries on MongoDB using indexes(first time using NoSql database for storage)
2. Create system tests
3. Build a simple frontend for this API.


# Learnings

1. First project using a NoSQL database for storage, was very nice to see how it's actually work outside just caching.
2. Github Actions, I used to build CI/CD pipelines on Gitlab and was very nice to study and learn how to do it on Github, for sure will use on my next projects.
3. Cluster on Atlas, making the process of deploying on heroku was very easy for me using MySQL databases, it has several facilities that make the deployment very easy. In this case, I was using a database that I don't dominate and also the addon that Heroku had to facilitate the deployment was paid. I had to study a little to understand how to set up the database manually, it was really cool.
