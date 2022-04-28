defmodule GoFetch.Account.User do
  @moduledoc """
  The user schema
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias GoFetch.Clinic.Appointment
  alias GoFetch.Clinic.Pet

  schema "users" do
    field :email, :string
    field :name, :string

    has_many :pets, Pet
    has_many :appointments, Appointment

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :name], empty_values: [])
    |> validate_required([:email])
  end
end
