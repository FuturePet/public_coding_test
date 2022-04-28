defmodule GoFetch.Clinic.Pet do
  @moduledoc """
  The pet schema
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias GoFetch.Account.User

  schema "pets" do
    field :name, :string

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :user_id], empty_values: [])
    |> validate_required([:name, :user_id])
  end
end
