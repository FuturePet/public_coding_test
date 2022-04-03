defmodule GoFetchWeb.Schema.AppointmentTypes do
  @moduledoc """
  The Absinthe Schema types.
  """
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  alias GoFetch.Controller

  object :appointment_queries do
    field :appointments, list_of(:appointment) do
      arg(:start_date, non_null(:string))
      arg(:end_date, non_null(:string))
      arg(:doctor_id, :string)
      resolve(&GoFetchWeb.Resolvers.Appointment.list_appointments_by_date/3)
    end
  end

  object :appointment do
    field :id, :id
    field :date, :datetime
    field :reason, :string

    field :user, :user, resolve: dataloader(Controller)
    field :pet, :pet, resolve: dataloader(Controller)
    field :doctor, :doctor, resolve: dataloader(Controller)
  end
end
