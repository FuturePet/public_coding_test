defmodule GoFetch.Clinic do
  @moduledoc """
  The Clinic context.
  """

  alias GoFetch.Clinic.{Appointment, Doctor}

  defdelegate get_appointments_by_date(args), to: Appointment
  defdelegate get_all_doctors, to: Doctor
end
