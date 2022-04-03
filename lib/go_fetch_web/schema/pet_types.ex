defmodule GoFetchWeb.Schema.PetTypes do
  @moduledoc """
  The Absinthe Schema Pet types.
  """
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  alias GoFetch.Controller

  #==========================================================================
  # Object Specification
  #==========================================================================

  object :pet do
    field :id, :id
    field :name, :string

    field :user, :user, resolve: dataloader(Appointments)
  end
end