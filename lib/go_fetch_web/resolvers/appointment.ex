defmodule GoFetchWeb.Resolvers.Appointment do
  @moduledoc """
  Appointment GraphQL Resolvers
  """

  alias GoFetch.Repo
  alias GoFetch.Appointment
  alias GoFetch.Doctor

  def list_appointments_by_date(_, args, _) do
    query = Appointment.get_appointments_by_date(args)
      |> Appointment.where_doctor(args[:doctor_id])

    {:ok, Repo.all(query)}
  end
end
