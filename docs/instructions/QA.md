# Instructions (QAs)

## Pre-requisites

Please fork this repo to your own GitHub account by following these steps:

1. Go to `https://github.com/KMBAL/interview-test-04-2025/fork`
2. Click "Create Fork"

Next, clone the forked repository to your local machine.

## Requirements

Please choose one of the following test cases to implement.

### Option 1: Integration Test (API)

Implement a simple integration test suite for the movie reviews API. This test
suite should assert the following scenarios:

1. A user should be able to submit a review using the `POST /api/v1/movies/:movieId/reviews`
   API endpoint
2. A user should not be able to submit more than one review for a given movie
   using the `POST /api/v1/movies/:movieId/reviews`

### Option 2: End-to-End Test (Web)

Implement a simple end-to-end test suite for the movie reviews web application.
This test suite should assert the following scenarios:

1. A user should be able to login to the web app using the login form at `/login`
2. A user should be able to update their password using the update password form
   at `/profile`.

### Option 3: End-to-End Test (Mobile)

Implement a simple end-to-end test suite for the movie reviews mobile application.
This test suite should assert the following cases

1. A user should be able to login to the mobile app
2. A user should be able to view the reviews for a movie in the mobile app

## Guidance

### Running the Backend & Web Application Locally

The backend and web application can be run locally with Docker. Run `docker compose build`
then `docker compose up` to start the web application. It will be accessible at
`http://localhost:8000`.

### Running the Mobile Application Locally

> [!NOTE]
> Running the mobile application locally is only required for Option 3.

There are many ways to run Flutter applications locally. If using Visual Studio
Code, it is recommended to use the official extension. You can find documentation
for this [here](https://docs.flutter.dev/tools/vs-code).

Note that developers should use the Flutter specified in `mobile/.fvmrc`. The
recommended way to do this is using [FVM](https://fvm.app/).


### API Endpoints

The available API endpoints are documented in a postman collecton. The collection
can be imported from `docs/postman/collection.json`.

For convenience, the `POST /api/qa/createTestUser` and `DELETE /api/qa/destroyAllTestUsers`
endpoints can be used in tests to create and destroy temporary test users. These
APIs can be used for setup and teardown of test scenarios.
