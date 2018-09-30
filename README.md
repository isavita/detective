# Detective

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Mix task for importing police's reports

  * Run `mix detective.import_street_report priv/police-data/2018-01-essex-street.csv` (files are from 2018-01 to 2018-07)

## Mix test for running all tests
  
  * Run `mix test`
