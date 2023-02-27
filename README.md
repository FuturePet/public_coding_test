# GoFetch Coding Test

Welcome to the GoFetch coding test! Our goal is to get a sense of your backend and front-end skills in this assessment.

## About this test

We have an example application that is displaying a list of the current week's appointments for pets at their vet clinic. There is some functionality that needs to be filled out and some refactoring opportunities throughout the code.

On the backend we are currently returning all of the appointments from the DB, we need to update this to only query for the relevant appointments.

On the frontend we are displaying a list of appointments and have a dropdown to filter by the name of the doctor. We want these appointments to be displayed in date/time order and to update the app so that it only shows the selected doctor's appointments.

![Coding Test](https://user-images.githubusercontent.com/8868192/147288968-99123785-fe4c-460c-939c-5e679b33097c.png)


## Getting set up

There are two options to get set up with this assignment.
You can use the provided Repl (if you didn't get one, reach out over email and we'll get it set up!) or you can clone this repository, work on your changes locally, and then zip up the whole folder and email it back to us.

Repl is only here to make your life easier (so you don't have to install Elixir and other dependencies).
If you run into issues with it, feel free to reach out to us or follow the manual install instructions.
You can always start in the Repl and then download a zip of your changes to keep working locally.

### Repl install

Open the Repl, press the "Run" button at the top of the screen, wait a few minutes for everything to install, then start coding!

If an embedded webpage opens up in Repl, but is blank, you should be able to refresh the frame to load it.

### Manual Install

#### Requirements

1. Elixir, [Installation Instructions](https://elixir-lang.org/install.html)
2. After Elixir is installed, run `mix local.hex` to install hex

#### Starting the Pheonix Web/API server

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Install Node.js dependencies with `yarn install`
- Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Requirements

This is a set of base changes we'd like to see. There are a lot of ways you could improve your version, and we encourage you to show us what you know!

- Update the `get_appointments_by_date/1` function in `lib/go_fetch/application/appointment.ex` to return only the appointments within the given timeframe
- Update the dropdown in `assets/js/Home.js` to filter the displayed appointments by the name of the doctor selected.
- Update the appointments list in `assets/js/Home.js` to display by appointment date and time.
- Make any improvements/refactors to the code that you can.
- When you are complete, you must commit to a new branch in the Replit.
  - Open the version control tab, create a new branch, and commit & push to it.

If you're stuck thinking about what kinds of improvements you could make, consider our code structure, accessibility, security, etc. You can leave improvements as `TODO`s if you have clear & explicit ideas of what you'd change.

### Testing
This applicaiton is 100% tested! 📉

Run

- `mix test` to check tests.

or

- `mix coveralls.html` for fully coverage report!

### Relevant Files

Below is a list of relevant files in the project for reference when making improvements.

#### Backend

Most of the relevant backend files are under the `lib` folder.

- Under `lib/go_fetch/application.ex` we have a number of different models where we are returning some info.
- `lib/go_fetch_web/schema/application_types.ex` contains the GQL schema info for our queries and `lib/go_fetch_web/resolvers/application.ex` has the GQL resolver info.

#### Frontend

- `assets/js/Home.js` contains the main views and functionality for all the frontend code
- `assets/css/app.scss` contains the basic styling for the app.
