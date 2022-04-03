defmodule GoFetch.Appointment do
  @moduledoc """
   the appointment schema
  """

  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias GoFetch.Appointment
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
  # Migrations
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
  @param chain - query to chain with this one.
  @param date_range_tuple - tuple specifiying the start and end date.
                            Filter results to only appointments between the two.
  @return query - a new query limiting appointments to only those in the specified range 
  """
  def get_appointments_by_date(chain, %{start_date: start_date, end_date: end_date}) do
    if (start_date == nil || end_date == nil) do
      chain
    else 
      from appt in chain,
          where: appt.date >= ^start_date and appt.date <= ^end_date
    end
  end

  def get_appointments_by_date(%{start_date: start_date, end_date: end_date}) do
    get_appointments_by_date(from(appt in Appointment), %{start_date: start_date, end_date: end_date})
  end 

  @doc """
  Filter results to only those where doctor is doctor_id
  @param chain - query to chain with this one.
  @param doctor_id - the doctor_id to filter results by
  @return filtered query 
  """
  def where_doctor(chain, doctor_id) do 
    if (doctor_id == nil) do
      chain
    else 
      from appt in chain,
        join: doc in assoc(appt, :doctor),
        where: doc.id == ^doctor_id
    end
  end 

  def where_doctor(doctor_id) do 
    where_doctor(from(appt in Appointment), doctor_id);
  end 
end
