# Rating App

[![Test](https://github.com/aristotelesbr/rating_app/actions/workflows/test.yaml/badge.svg)](https://github.com/aristotelesbr/rating_app/actions/workflows/test.yaml)

## Description

This is a simple rating app that allows users to rate teachers or any thing else.

## Features

### Users can rate teachers

![rate a teacher](https://raw.githubusercontent.com/aristotelesbr/rating_app/main/docs/images/rate_a_teacher.png)

### Users can view the number of ratings of a teacher

![View rating](https://raw.githubusercontent.com/aristotelesbr/rating_app/main/docs/images/view_ratings.png)

## Technologies

- Ruby
- Rack

## How to use

- Clone the repository

```bash
git clone https://github.com/aristotelesbr/rating-app.git
```

- Go to the project directory

```bash
cd rating-app
```

- Install the dependencies

```bash
bundle install
```

- Create the database

```bash
rub db/setup.rb
```

- Run the app

```bash
bundle exec rackup
```

- Open your browser and go to `http://localhost:9292`

## Author

👤 **Aristoteles Coutinho**
