defmodule DetectiveWeb.StreetReportController do
  use DetectiveWeb, :controller
  alias Detective.Reports

  def index(conn, params) do
    street_reports = Reports.paginated_list_street_reports(params)

    render(conn, "index.html", street_reports: street_reports)
  end
end
