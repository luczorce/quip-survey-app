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

### Questions

#### `GET` Questions from a Certain Survey

```
GET /surveys/:survey_id/questions

# :survey_id is the Id of the Survey
```

Returns the Questions in the Survey

``` json
[
  {
    "id": 1,
    "question": "Absolute First Question?",
    "order": 1,
    "survey_id": 2,
    "created_at": "2018-12-20T21:43:39.008Z",
    "updated_at": "2018-12-20T22:25:13.003Z"
  },
  {
    "id": 2,
    "question": "Second Question?",
    "order": 2,
    "survey_id": 2,
    "created_at": "2018-12-20T21:45:31.926Z",
    "updated_at": "2018-12-20T21:45:31.926Z"
  }
]
```

#### `POST` A new Question to a Survey

```
POST /surveys/:survey_id/questions

# :survey_id is the Id of the Survey
```

The type of question you want to create determines the data you'll send over. You **must** provide the "type" value in the request body to ensure we can find the proper Question type to create. Valid values, and the applicable request body for type are:

| type       | rest of request body                              |
|------------|---------------------------------------------------|
| text_input | question: "Unique String to Survey" <br>order: Number |

Returns the newly created Question, with status of 202. If the "type" is not defined, returns a `404`. Otherwise, and error is returned with status `400`.

#### `PUT/PATCH` A Question to update

Like with creating a new question, the "type" value provided in the request body is essential to finding which type of question to update. Follow the guidelines in the `POST` section above to see what your request body should include.

```
PUT /questions/:id

# :id is the Id of the Question
```

Returns the updated question, or an error with either `404` or `400` error.

#### `DELETE` A Question to delete

Like with creating a new question, the "type" value provided in the request body is essential to finding which type of question to delete. Follow the guidelines in the `POST` section above to see what your request body should include.

```
DELETE /questions/:id

# :id is the Id of the Question
```

Returns no content with `204` status, or an error with `404`.

## Development

Ensure you have at least Ruby 2.5 and Rails >5 installed. 

``` bash
cd quip_survey_app
bundle install
rails db:setup
rails server
```
