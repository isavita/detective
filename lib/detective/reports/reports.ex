defmodule Detective.Reports do
  @moduledoc """
  The Reports context.
  """

  import Ecto.Query, warn: false
  alias Detective.Repo

  alias Detective.Reports.StreetReport

  @doc """
  Returns the list of street_reports.

  ## Examples

      iex> list_street_reports()
      [%StreetReport{}, ...]

  """
  def list_street_reports do
    Repo.all(StreetReport)
  end

  @doc """
  Gets a single street_report.

  Raises `Ecto.NoResultsError` if the Street report does not exist.

  ## Examples

      iex> get_street_report!(123)
      %StreetReport{}

      iex> get_street_report!(456)
      ** (Ecto.NoResultsError)

  """
  def get_street_report!(id), do: Repo.get!(StreetReport, id)

  @doc """
  Creates a street_report.

  ## Examples

      iex> create_street_report(%{field: value})
      {:ok, %StreetReport{}}

      iex> create_street_report(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_street_report(attrs \\ %{}) do
    %StreetReport{}
    |> StreetReport.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a street_report.

  ## Examples

      iex> update_street_report(street_report, %{field: new_value})
      {:ok, %StreetReport{}}

      iex> update_street_report(street_report, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_street_report(%StreetReport{} = street_report, attrs) do
    street_report
    |> StreetReport.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a StreetReport.

  ## Examples

      iex> delete_street_report(street_report)
      {:ok, %StreetReport{}}

      iex> delete_street_report(street_report)
      {:error, %Ecto.Changeset{}}

  """
  def delete_street_report(%StreetReport{} = street_report) do
    Repo.delete(street_report)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking street_report changes.

  ## Examples

      iex> change_street_report(street_report)
      %Ecto.Changeset{source: %StreetReport{}}

  """
  def change_street_report(%StreetReport{} = street_report) do
    StreetReport.changeset(street_report, %{})
  end
end
