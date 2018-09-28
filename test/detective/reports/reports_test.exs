defmodule Detective.ReportsTest do
  use Detective.DataCase

  alias Detective.Reports

  describe "street_reports" do
    alias Detective.Reports.StreetReport

    @valid_attrs %{context: "some context", crime_id: "some crime_id", crime_type: "some crime_type", falls_within: "some falls_within", last_outcome_category: "some last_outcome_category", latitude: 120.5, location: "some location", longitude: 120.5, lsoa_code: "some lsoa_code", lsoa_name: "some lsoa_name", month: "some month", reported_by: "some reported_by"}
    @update_attrs %{context: "some updated context", crime_id: "some updated crime_id", crime_type: "some updated crime_type", falls_within: "some updated falls_within", last_outcome_category: "some updated last_outcome_category", latitude: 456.7, location: "some updated location", longitude: 456.7, lsoa_code: "some updated lsoa_code", lsoa_name: "some updated lsoa_name", month: "some updated month", reported_by: "some updated reported_by"}
    @invalid_attrs %{crime_id: nil, month: nil, crime_type: nil, reported_by: nil}

    def street_report_fixture(attrs \\ %{}) do
      {:ok, street_report} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Reports.create_street_report()

      street_report
    end

    test "list_street_reports/0 returns all street_reports" do
      street_report = street_report_fixture()
      assert Reports.list_street_reports() == [street_report]
    end

    test "get_street_report!/1 returns the street_report with given id" do
      street_report = street_report_fixture()
      assert Reports.get_street_report!(street_report.id) == street_report
    end

    test "create_street_report/1 with valid data creates a street_report" do
      assert {:ok, %StreetReport{} = street_report} = Reports.create_street_report(@valid_attrs)
      assert street_report.context == "some context"
      assert street_report.crime_id == "some crime_id"
      assert street_report.crime_type == "some crime_type"
      assert street_report.falls_within == "some falls_within"
      assert street_report.last_outcome_category == "some last_outcome_category"
      assert street_report.latitude == 120.5
      assert street_report.location == "some location"
      assert street_report.longitude == 120.5
      assert street_report.lsoa_code == "some lsoa_code"
      assert street_report.lsoa_name == "some lsoa_name"
      assert street_report.month == "some month"
      assert street_report.reported_by == "some reported_by"
    end

    test "create_street_report/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Reports.create_street_report(@invalid_attrs)
    end

    test "update_street_report/2 with valid data updates the street_report" do
      street_report = street_report_fixture()
      assert {:ok, street_report} = Reports.update_street_report(street_report, @update_attrs)
      assert %StreetReport{} = street_report
      assert street_report.context == "some updated context"
      assert street_report.crime_id == "some updated crime_id"
      assert street_report.crime_type == "some updated crime_type"
      assert street_report.falls_within == "some updated falls_within"
      assert street_report.last_outcome_category == "some updated last_outcome_category"
      assert street_report.latitude == 456.7
      assert street_report.location == "some updated location"
      assert street_report.longitude == 456.7
      assert street_report.lsoa_code == "some updated lsoa_code"
      assert street_report.lsoa_name == "some updated lsoa_name"
      assert street_report.month == "some updated month"
      assert street_report.reported_by == "some updated reported_by"
    end

    test "update_street_report/2 with invalid data returns error changeset" do
      street_report = street_report_fixture()
      assert {:error, %Ecto.Changeset{}} = Reports.update_street_report(street_report, @invalid_attrs)
      assert street_report == Reports.get_street_report!(street_report.id)
    end

    test "delete_street_report/1 deletes the street_report" do
      street_report = street_report_fixture()
      assert {:ok, %StreetReport{}} = Reports.delete_street_report(street_report)
      assert_raise Ecto.NoResultsError, fn -> Reports.get_street_report!(street_report.id) end
    end

    test "change_street_report/1 returns a street_report changeset" do
      street_report = street_report_fixture()
      assert %Ecto.Changeset{} = Reports.change_street_report(street_report)
    end
  end
end
