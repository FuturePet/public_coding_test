defmodule GoFetch.Clinic.Appointment do
  @moduledoc """
  The appointment schema
  """

  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias GoFetch.Account.User
  alias GoFetch.Clinic.{Doctor, Pet}
  alias GoFetch.Repo

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

  @doc """
  Update this function to return all appointments within the given range.
  Get all appointments by the given range of dates.
  """
  def get_appointments_by_date(%{start_date: start_date, end_date: end_date}) do
    from(q in __MODULE__)
    |> where([q], q.date >= ^start_date and q.date <= ^end_date)
    |> Repo.all()
  end
end
