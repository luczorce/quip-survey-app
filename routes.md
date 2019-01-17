# Routes and Description

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

#### `GET` A Results of a Survey

```
GET /surveys/:id/results

# :id is the Id of the Survey to delete
```

Will gather the results of the provided Survey, and return a `200`. The response will contain:

``` json
{
  "survey": {
    "id": 41,
    "name": "Friday Hair Survey",
    "created_at": "2019-01-05T00:33:39.461Z",
    "updated_at": "2019-01-05T00:33:39.461Z"
  },
  "questions": [
    // all questions from this survey, in order 
    {}, {}, {}
  ],
  "answers": {
    // all answers to the survey, separated by source quip 
    // answers include id and type of question they relate to
    "quipId1": [
      {}, {}, {}
    ],
    "quipId2": [
      {}, {}, {}
    ],
    "quipId3": [
      {}, {}, {}
    ]
  }
}
```

### Questions

The type of question you want to create determines the data you'll send over. You **must** provide the "question_type" value in the request body to ensure we can find the proper Question type to create/edit/delete. Valid values, and the applicable request body for type are:

| question_type | question | question\_helper | order  | options | option\_helpers | min | max |
|---------------|:---------|:-----------------|:-------|:--------|:---------------|:----|:----|
| number_input  | String   | String | Number | _do not include_ | _do not include_ | Number _(opt)_ | Number _(opt)_ |
| text_input    | String   | String | Number | _do not include_ |_do not include_ | _do not include_ | _do not include_ |
| textarea      | String   | String | Number | _do not include_ |_do not include_ | _do not include_ | _do not include_ |
| select        | String   | String | Number | Strings~~~Separated~~~With the Tildas | S~~~S~~~Tildas | _do not include_ | _do not include_ |
| radio         | String   | String | Number | Strings~~~Separated~~~With the Tildas | S~~~S~~~Tildas | _do not include_ | _do not include_ |
| checkbox      | String   | String | Number | Strings~~~Separated~~~With the Tildas | S~~~S~~~Tildas | _do not include_ | _do not include_ |

There is a special type of question handled here, and it's not a question at all. It's a header, intending to separate sections of the form. It is handled much the same way the questions are, since it lives like a question. You'll hit the same question routes, you just will include noticibly different data in payload.

| question_type | value  | order  |
|---------------|:-------|:-------|
| header        | String | Number |

#### `GET` Questions from a Certain Survey

```
GET /surveys/:survey_id/questions

# :survey_id is the Id of the Survey
# _question_type is not required here_
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
# include data in the body according to the question table above
```

Returns the newly created Question, with status of 202. If the "question_type" is not defined, returns a `404`. Otherwise, and error is returned with status `400`.

#### `PUT/PATCH` A Question to update

```
PUT /questions/:id

# :id is the Id of the Question
# include data in the body according to the question table above
```

Returns the updated question, or an error with either `404` or `400` error.

#### `DELETE` A Question to delete

```
DELETE /questions/:id

# :id is the Id of the Question
# include question_type in the body according to the question table above
```

Returns no content with `204` status, or an error with `404`.

### Answers

You **must** provide the "answer_type" value in the request body to ensure we can find the proper Answer type to create/edit/delete. Valid values, and the applicable request body for type are:

| answer_type   | quip_id | answer            |
|---------------|:--------|:------------------|
| number_input  | String  | Number            |
| text_input    | String  | String            |
| textarea      | String  | String            |
| select        | String  | String            |
| radio         | String  | String            |
| checkbox      | String  | String~~~And More |

#### `GET` Show a single Answer

```
GET /answers/:id

# :id is the Id of the Answer
# include the answer_type in the body
```

Returns the the answer details with status of `200`.

``` json
{
    "id": 1,
    "answer": "My considered response, expanded upon",
    "input_text_question_id": 2,
    "quip_id": "QuipIdFancyString",
    "created_at": "2018-12-20T23:36:24.959Z",
    "updated_at": "2018-12-20T23:51:02.107Z",
    "answer_type": "text_input"
}
```

Otherwise it returns an error message with either `400` or `404`

#### `POST` Create an Answer to a Question

Once again, the "type" value provided in the request body is essential to finding which type of question to create. 

```
POST /questions/:question_id/answers

# :question_id is the Id of the Associated Question
# include the answer_type, quip_id, and answer in the body
```

Returns the answer details, along with a status iof `201`. If there is an error it returns it with either status of `400` or `404`.

#### `PUT/PATCH` Update an Answer

Once again, the "answer_type" value provided in the request body is essential to finding which type of answer to update. 

```
PUT/PATCH /answers/:id

# :id is the Id of the Answer
# include the answer_type and answer in the body
```

Returns the answer details, along with a status iof `200`. If there is an error it returns it with either status of `400` or `404`.
