defmodule GoFetch.Appointment do
  @moduledoc """
   the appointment schema
  """

  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias GoFetch.Doctor
  alias GoFetch.User
  alias GoFetch.Pet
  alias GoFetch.Repo

  #==========================================================================
  # Schema & Associations
  #==========================================================================

  schema "appointments" do
    field :date, :utc_datetime
    field :reason, :string

    belongs_to :user, User
    belongs_to :pet, Pet
    belongs_to :doctor, Doctor

    timestamps()
  end

  #==========================================================================
  # Migrations? 
  #==========================================================================

  @doc false
  def changeset(appointment, attrs) do
    appointment
    |> cast(attrs, [:date, :reason, :user_id, :pet_id], empty_values: [])
    |> validate_required([:date, :user_id, :pet_id])
  end

  #==========================================================================
  # Filters / Scopes
  #==========================================================================

  @doc """
  Get appointments within the specified date range.
  @param date_range_tuple - tuple specifiying the start and end date. Filter results to only appointments between the two.
  @return query - a new query limiting appointments to only those in the specified range 
  """
  def get_appointments_by_date(%{start_date: start_date, end_date: end_date}) do
    get_appointments_by_date(from(a in GoFetch.Appointment), %{start_date: start_date, end_date: end_date})
  end 

  @doc """
  Get appointments within the specified date range.
  @param chain - query to chain with this one.
  @param date_range_tuple - tuple specifiying the start and end date. Filter results to only appointments between the two.
  @return query - a new query limiting appointments to only those in the specified range 
  """
  def get_appointments_by_date(chain, %{start_date: start_date, end_date: end_date}) do
    from appt in chain,
        where: appt.date >= ^start_date and appt.date <= ^end_date,
        select: appt
  end
end
