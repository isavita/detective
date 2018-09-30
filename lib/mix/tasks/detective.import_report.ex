defmodule Mix.Tasks.Detective.ImportStreetReport do
  use Mix.Task

  require CSV
  require Logger

  alias Detective.Reports

  @shortdoc "Imports into the database police report file"
  def run(path) do
    run_app_start_task

    path
    |> Path.expand(File.cwd!)
    |> File.stream!([:read])
    |> CSV.decode(headers: true)
    |> Enum.map(&import_record/1)
  end

  defp run_app_start_task do
    Mix.Task.run "app.start"
  end

  defp import_record({:ok, record}) do
    with {:ok, _changeset} <- create_street_report(record) do
      :ok
    else
      {:error, changeset} ->
        changeset.errors
        |> Enum.map_join(", ", fn {field, {message, _}} -> "#{field}: #{message}" end)
        |> Logger.warn()
    end
  end

  defp import_record({:error, reason}), do: Logger.warn(reason)

  defp create_street_report(record) do
    Reports.create_street_report(%{
      context: record["context"],
      crime_id: record["crime_id"],
      crime_type: record["crime_type"],
      falls_within: record["falls_within"],
      last_outcome_category: record["last_outcome_category"],
      latitude: record["latitude"],
      location: record["location"],
      longitude: record["longitude"],
      lsoa_code: record["lsoa_code"],
      lsoa_name: record["lsoa_name"],
      month: record["month"],
      reported_by: record["reported_by"]
    })
  end
end
