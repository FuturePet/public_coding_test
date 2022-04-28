defmodule GoFetchWeb.Resolvers.Clinic do
  @moduledoc """
  GraphQL Clinic Resolvers
  """

  alias GoFetch.Clinic

  def list_doctors(_, _, _) do
    {:ok, Clinic.get_all_doctors()}
  end

  def list_appointments_by_date(_, args, _) do
    {:ok, Clinic.get_appointments_by_date(args)}
  end
end
