defmodule DetectiveWeb.StreetReportController do
  use DetectiveWeb, :controller
  use Rummage.Phoenix.Controller
  alias Detective.Reports
  alias Detective.Repo

  def index(conn, params) do
    {query, rummage} = Reports.StreetReport |> Rummage.Ecto.rummage(params["rummage"])
    street_reports = Repo.all(query)

    render(conn, "index.html", street_reports: street_reports, rummage: rummage)
  end
end
