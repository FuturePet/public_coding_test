defmodule GoFetchWeb.Schema.AccountTypes do
  @moduledoc """
  The Absinthe Schema Account types.
  """
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  alias GoFetch.Controller

  object :user do
    field :id, :id
    field :name, :string
    field :email, :string

    field :pets, list_of(:pet) do
      resolve(dataloader(Controller, :pets))
    end
  end
end
