# GoFetch Coding Test

# Manual Install

## Requirements

1. Elixir, [Installation Instructions](https://elixir-lang.org/install.html)
2. After Elixir is installed, run `mix local.hex` to install hex

## To start the Phoenix server:

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Install Node.js dependencies with `yarn install`
- Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

# Replit Install

Run the repl.it to get started!

# Test Info

We have an example application that is displaying a list of the current week's appointments for pets at their vet clinic. There is some functionality that needs to be filled out and some refactoring opportunities throughout the code.

On the backend we are currently returning all of the appointments from the DB, we need to update this to only query for the relevant appointments.

On the frontend we are displaying a list of appointments and have a dropdown to filter by the name of the doctor. We want these appointments to be displayed in date/time order and to update the dropdown so that it only shows the selected doctor's appointments.

![Coding Test](https://user-images.githubusercontent.com/8868192/147288968-99123785-fe4c-460c-939c-5e679b33097c.png)

## Criteria

- Update the `get_appointments_by_date/1` function in `lib/go_fetch/application/appointment.ex` to return only the appointments within the given timeframe
- Update the dropdown in `assets/js/Home.js` to filter the displayed appointments by the name of the doctor selected.
- Update the appointments list in `assets/js/Home.js` to display by appointment date and time.
- Make any improvements/refactors to the code that you can.
- When finished, in the version control tab in replit create a new branch and commit your changes.

### Testing

- Run `mix test` to check against the unit test for `get_appointments_by_date/1` filtering.

### Relevant Files

Below is a list of relevant files in the project for reference when making improvements.

#### Backend

Most of the relevant backend files are under the `lib` folder.

- Under `lib/go_fetch/application.ex` we have a number of different models where we are returning some info.
- `lib/go_fetch_web/schema/application_types.ex` contains the GQL schema info for our queries and `lib/go_fetch_web/resolvers/application.ex` has the GQL resolver info.

#### Frontend

- `assets/js/Home.js` contains the main views and functionality for all the frontend code
- `assets/css/app.scss` contains the basic styling for the app.
