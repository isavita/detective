defmodule DetectiveWeb.StreetReportControllerTest do
  use DetectiveWeb.ConnCase
  alias Detective.Reports

  describe "index/2" do
    test "Responds with expected page", %{conn: conn} do
      response = conn |> get(street_report_path(conn, :index)) |> html_response(200)

      assert response =~ "Id"
      assert response =~ "Crime Type"
      assert response =~ "Location"
      assert response =~ "Outcome"
      assert response =~ "Month"
    end

    test "Sorts and paginates reports when sort and pagination provided", %{conn: conn} do
      {:ok, report_jan} = create_street_report(index: 1)
      {:ok, report_feb} = create_street_report(index: 2)
      {:ok, report_mar} = create_street_report(index: 3)

      response =
        conn |> get(street_report_path(conn, :index, sort: "month", page_size: 2)) |> html_response(200)

      refute response =~ Integer.to_string(report_jan.id)
      assert response =~ Integer.to_string(report_feb.id)
      assert response =~ Integer.to_string(report_mar.id)
    end

    test "Filters when filter allowed", %{conn: conn} do
      {:ok, report1} = create_street_report(index: 1)
      {:ok, report2} = create_street_report(index: 2)
      filters = %{"crime_type" => report1.crime_type}

      response =
        conn |> get(street_report_path(conn, :index, filters: filters)) |> html_response(200)

      assert response =~ Integer.to_string(report1.id)
      refute response =~ Integer.to_string(report2.id)
    end

    test "Ignores filter if not allowed", %{conn: conn} do
      {:ok, report1} = create_street_report(index: 1)
      {:ok, report2} = create_street_report(index: 2)
      filters = %{"crime_id" => report1.crime_id}

      response =
        conn |> get(street_report_path(conn, :index, filters: filters)) |> html_response(200)

      assert response =~ Integer.to_string(report1.id)
      assert response =~ Integer.to_string(report2.id)
    end
  end

  describe "show/2" do
    test "Responds with expected page", %{conn: conn} do
      {:ok, report} = create_street_report(index: 1)

      response = conn |> get(street_report_path(conn, :show, report.id)) |> html_response(200)

      assert response =~ Integer.to_string(report.id)
      assert response =~ report.crime_id
      assert response =~ report.crime_type
      assert response =~ report.reported_by
    end
  end

  defp create_street_report(opts) do
    attrs = %{
      crime_id: "identifier#{opts[:index]}",
      month: "2018-0#{opts[:index]}",
      reported_by: "police#{opts[:index]}",
      crime_type: "type#{opts[:index]}"
    }

    Reports.create_street_report(attrs)
  end
end
