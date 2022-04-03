defmodule GoFetchWeb.Resolvers.Doctor do
  @moduledoc """
  Doctor GraphQL Resolvers
  """

  alias GoFetch.Repo
  alias GoFetch.Doctor

  def list_doctors(_, _, _) do
    {:ok, Doctor.get_doctors()}
  end
end
