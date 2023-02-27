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

  @doc """
  Update this function to return all appointments within the given range.
  """
  def get_appointments_by_date(%{
        start_date: start_date,
        end_date: end_date,
        doctor_last_name: doctor_last_name
      }) do
    from(
      a in Appointment,
      where: a.date >= ^start_date and a.date < ^end_date,
      select: a,
      join: d in assoc(a, :doctor),
      on: d.last_name == ^doctor_last_name,
      order_by: [desc: a.date]
    )
    |> Repo.all()
    |> Repo.preload([:doctor, :pet, :user])
  end

  schema "appointments" do
    field(:date, :utc_datetime)
    field(:reason, :string)

    belongs_to(:user, User)
    belongs_to(:pet, Pet)
    belongs_to(:doctor, Doctor)

    timestamps()
  end

  @doc false
  def changeset(appointment, attrs) do
    appointment
    |> cast(attrs, [:date, :reason, :user_id, :pet_id, :doctor_id], empty_values: [])
    |> validate_required([:date, :user_id, :pet_id, :doctor_id])
  end
end
