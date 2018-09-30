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
  Returns map of entries list of street_reports and page pagination data.

  ## Examples

      iex> paginated_list_street_reports(page_params)
      %{entries: [%StreetReport{}, ...], page_number: ..., page_size: ..., total_entries: ..., total_pages: ...}

  """
  def filtered_and_sort_query_street_reports(params) do
    StreetReport
    |> query_sort_by(params[:sort])
    |> query_filter_by(params[:filters])
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

  defp query_sort_by(query, sort) when is_nil(sort), do: query
  defp query_sort_by(query, sort) when is_binary(sort) do
    query |> order_by(desc: ^String.to_atom(sort))
  end

  defp query_filter_by(query, filters) when is_nil(filters), do: query
  defp query_filter_by(query, filters) do
    Enum.reduce(filters, query, fn({filter, value}, query) ->
      case String.downcase(filter) do
        "crime_type" ->
          from p in query,
          where: ilike(p.crime_type, ^("%#{value}%"))
        _ ->
          from p in query,
          where: field(p, ^String.to_atom(filter)) == ^value
      end
    end)
  end
end
