defmodule Detective.ReportsTest do
  use Detective.DataCase

  alias Detective.Reports
  alias Detective.Reports.StreetReport

  @valid_attrs %{context: "some context", crime_id: "some crime_id", crime_type: "a crime_type", falls_within: "some falls_within", last_outcome_category: "some last_outcome_category", latitude: 120.5, location: "some location", longitude: 120.5, lsoa_code: "some lsoa_code", lsoa_name: "some lsoa_name", month: "some month", reported_by: "some reported_by"}
  @invalid_attrs %{crime_id: nil, month: nil, crime_type: nil, reported_by: nil}

  def street_report_fixture(attrs \\ %{}) do
    {:ok, street_report} =
      attrs
      |> Enum.into(@valid_attrs)
      |> Reports.create_street_report()

    street_report
  end

  describe "list_street_reports/0" do
    test "Returns all street_reports" do
      street_report = street_report_fixture()
      assert Reports.list_street_reports() == [street_report]
    end
  end

  describe "filtered_and_sort_query_street_reports/1" do
    setup do
      {:ok, street_report: street_report_fixture()}
    end

    test "Returns StreetReport module" do
      assert Detective.Reports.StreetReport = Reports.filtered_and_sort_query_street_reports(%{})
    end

    test "Sorts desc with sort params", %{street_report: street_report} do
      another_street_report = street_report_fixture(%{crime_type: "b crime_type"})
      query = Reports.filtered_and_sort_query_street_reports(%{sort: "crime_type"})
      result_ids_query = from p in query, select: p.id

      assert %Ecto.Query{} = query
      assert Detective.Repo.all(result_ids_query) == [another_street_report.id, street_report.id]
    end

    test "Filters results with filters" do
      another_street_report = street_report_fixture(%{crime_id: "identifier007"})
      query = Reports.filtered_and_sort_query_street_reports(
        %{filters: %{"crime_id" => another_street_report.crime_id}}
      )

      assert Detective.Repo.all(query) == [another_street_report]
     end
  end

  describe "get_street_report!/1" do
    test "Returns the street_report with given id" do
      street_report = street_report_fixture()
      assert Reports.get_street_report!(street_report.id) == street_report
    end

    test "With not existing id returns error" do
      assert_raise Ecto.NoResultsError, fn ->
        Reports.get_street_report!(-1)
      end
    end
  end

  describe "create_street_report/1" do
    test "With valid data creates a street_report" do
      assert {:ok, %StreetReport{} = street_report} = Reports.create_street_report(@valid_attrs)
      assert street_report.context == "some context"
      assert street_report.crime_id == "some crime_id"
      assert street_report.crime_type == "a crime_type"
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

    test "With invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Reports.create_street_report(@invalid_attrs)
    end
  end

  test "change_street_report/1 returns a street_report changeset" do
    street_report = street_report_fixture()
    assert %Ecto.Changeset{} = Reports.change_street_report(street_report)
  end
end
