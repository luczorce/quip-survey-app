# Quip Survey API

This is a Rails API app to manage survey data coming from Quip live apps.

## Routes and Description

### Surveys

#### `GET` Surveys

```
GET /surveys
```

Returns all the Surveys

#### `POST` A New Survey

Adds a new Survey

```
POST /surveys

# data to send over:
# name: "A String to Name the Survey"
```

Returns the saved Survey data, with `201` status. If unsuccessful, returns `400` with an error message:

``` json
{
  "name": [
    "can't be blank"
  ]
}
```

#### `GET` A Single Survey

Get a single survey.

```
GET /surveys/:id

# :id is the Id of the Survey to get
```

Returns the survey data, with a status `200`.

```
{
  "id": 2,
  "name": "December Firs Test A Survey",
  "created_at": "2018-12-20T18:01:05.752Z",
  "updated_at": "2018-12-20T19:25:45.179Z"
}
``` 

If the survey can't be found, then returns `404` with a message:

```
"Couldn't find Survey with 'id'=1"
```

#### `POST/PUT` A Survey to Update

```
GET /surveys/:id

# :id is the Id of the Survey to update
# data to send over:
# name: "A String to rename the Survey"
```

Returns the updated Survey data (same as getting a single Survey), with status of `200`. If the survey isn't found, then returns a `404` and error message. If the survey can't be updated, returns `400` with an error message, such as: 

```
{
  "name": [
    "has already been taken"
  ]
}
```

#### `DELETE` A Single Survey

```
GET /surveys/:id

# :id is the Id of the Survey to delete
```

Will delete the Survey, and return a `204`, with no content.

## Development

Ensure you have at least Ruby 2.5 and Rails >5 installed. 

``` bash
cd quip_survey_app
bundle install
rails db:setup
rails server
```
