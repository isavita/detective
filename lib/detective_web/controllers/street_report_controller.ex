defmodule DetectiveWeb.StreetReportController do
  use DetectiveWeb, :controller
  import DetectiveWeb.Plugs.Filters
  alias Detective.Reports
  alias Detective.Repo

  plug(:allowed_filters, ~w(crime_type) when action in [:index])

  def index(conn, params) do
    query = Reports.filtered_and_sort_query_street_reports(%{filters: conn.assigns.filters, sort: params["sort"] })
    page = Detective.Repo.paginate(query, params)

    render(conn, "index.html", street_reports: page.entries, page: page, sort: params["sort"])
  end
end
