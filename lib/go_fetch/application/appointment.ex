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

  @doc """
  Update this function to return all appointments within the given range.
  """

  def get_appointments_by_date(%{start_date: start_date, end_date: end_date}) do
    queryAppointments = from ap in __MODULE__, 
                where: ap.date >= ^start_date and ap.date <= ^end_date

    Repo.all(queryAppointments)     
  end

  schema "appointments" do
    field :date, :utc_datetime
    field :reason, :string

    belongs_to :user, User
    belongs_to :pet, Pet
    belongs_to :doctor, Doctor

    timestamps()
  end

  @doc false
  def changeset(appointment, attrs) do
    appointment
    |> cast(attrs, [:date, :reason, :user_id, :pet_id], empty_values: [])
    |> validate_required([:date, :user_id, :pet_id])
  end
end
