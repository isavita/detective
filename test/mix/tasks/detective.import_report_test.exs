defmodule Mix.Tasks.Detective.ImportStreetReportTest do
  use Detective.DataCase

  import ExUnit.CaptureLog

  alias Mix.Tasks.Detective.ImportStreetReport
  alias Detective.Reports

  setup do
    path = Path.expand("fixtures/street-report.csv", "test")
    {:ok, path: path}
  end

  test "creates a street report in the database for each valid row from the file", %{path: path} do
    ImportStreetReport.run(path)

    assert length(Reports.list_street_reports()) == 2
  end

  test "errors when the file does not exist" do
    assert_raise File.Error, ~r/unknown-file.csv/, fn ->
      ImportStreetReport.run('unknown-file.csv')
    end
  end

  @tag capture_log: false
  test "logs every invalid row from the file", %{path: path} do
    assert capture_log(fn ->
             ImportStreetReport.run(path)
           end) =~ "Row has length 11 - expected length 12 on line 3"
  end

  test "logs every error on creation of report record", %{path: path} do
    assert capture_log(fn ->
             ImportStreetReport.run(path)
           end) =~ "crime_id: can't be blank"
  end
end
