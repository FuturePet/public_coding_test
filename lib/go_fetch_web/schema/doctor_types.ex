defmodule GoFetchWeb.Schema.DoctorTypes do
  @moduledoc """
  The Absinthe Schema Doctor types.
  """
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  alias GoFetch.Controller

  #==========================================================================
  # Object Specification
  #==========================================================================

  object :doctor do
    field :id, :id
    field :first_name, :string
    field :last_name, :string
  end

  #==========================================================================
  # Query Specification
  #==========================================================================

  object :doctor_queries do 
    field :doctors, list_of(:doctor) do
      resolve(&GoFetchWeb.Resolvers.Doctor.list_doctors/3)
    end
  end
end