defmodule GoFetch.Clinic.Doctor do
  @moduledoc """
  The doctor schema
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias GoFetch.Clinic.Appointment
  alias GoFetch.Repo

  schema "doctors" do
    field :first_name, :string
    field :last_name, :string

    has_many :appointments, Appointment

    timestamps()
  end

  @doc false
  def changeset(doctor, attrs) do
    doctor
    |> cast(attrs, [:first_name, :last_name], empty_values: [])
    |> validate_required([:first_name, :last_name])
  end

  @doc """
  Get all doctors
  """
  def get_all_doctors() do
    Repo.all(__MODULE__)
  end
end
