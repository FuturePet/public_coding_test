defmodule GoFetchWeb.Resolvers.Application do
  @moduledoc """
  GraphQL Resolvers
  """

  alias GoFetch.Repo
  alias GoFetch.Appointment
  alias GoFetch.Doctor

  def list_doctors(_, _, _) do
    {:ok, Doctor.get_doctors()}
  end

  def list_appointments_by_date(_, args, _) do
    {:ok, Repo.all(Appointment.get_appointments_by_date(args))}
  end
end
