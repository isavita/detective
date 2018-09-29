defmodule Detective.Reports.StreetReport do
  use Ecto.Schema
  use Rummage.Phoenix
  import Ecto.Changeset

  schema "street_reports" do
    field :context, :string
    field :crime_id, :string
    field :crime_type, :string
    field :falls_within, :string
    field :last_outcome_category, :string
    field :latitude, :float
    field :location, :string
    field :longitude, :float
    field :lsoa_code, :string
    field :lsoa_name, :string
    field :month, :string
    field :reported_by, :string

    timestamps()
  end

  @doc false
  def changeset(street_report, attrs) do
    street_report
    |> cast(attrs, [:crime_id, :month, :reported_by, :falls_within, :longitude, :latitude, :location, :lsoa_code, :lsoa_name, :crime_type, :last_outcome_category, :context])
    |> validate_required([:crime_id, :month, :reported_by, :crime_type])
  end
end
