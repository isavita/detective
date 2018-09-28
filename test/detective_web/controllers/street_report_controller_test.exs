defmodule DetectiveWeb.StreetReportControllerTest do
  use DetectiveWeb.ConnCase

  test "GET /street_reports", %{conn: conn} do
    response = conn |> get(street_report_path(conn, :index)) |> html_response(200) 

    assert response =~ "Id"
    assert response =~ "Crime type"
    assert response =~ "Location"
    assert response =~ "Reported by"
    assert response =~ "Month"
  end
end
