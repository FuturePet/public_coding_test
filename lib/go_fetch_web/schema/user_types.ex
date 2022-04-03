defmodule GoFetchWeb.Schema.UserTypes do
  @moduledoc """
  The Absinthe Schema User types.
  """
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  alias GoFetch.Controller

  #==========================================================================
  # Object Specification
  #==========================================================================

  object :user do
    field :id, :id
    field :name, :string
    field :email, :string

    field :pets, list_of(:pet) do
      resolve(dataloader(Controller, :pets))
    end
  end
end