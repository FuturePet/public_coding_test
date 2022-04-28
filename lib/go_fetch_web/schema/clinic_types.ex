defmodule GoFetchWeb.Schema.ClinicTypes do
  @moduledoc """
  The Absinthe Schema Clinic types.
  """
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  alias GoFetch.Controller
  alias GoFetchWeb.Resolvers.Clinic

  object :clinic_queries do
    field :doctors, list_of(:doctor) do
      resolve(&Clinic.list_doctors/3)
    end

    field :appointments, list_of(:appointment) do
      arg(:start_date, non_null(:string))
      arg(:end_date, non_null(:string))
      resolve(&Clinic.list_appointments_by_date/3)
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

  object :pet do
    field :id, :id
    field :name, :string

    field :user, :user, resolve: dataloader(Appointments)
  end

  object :doctor do
    field :id, :id
    field :first_name, :string
    field :last_name, :string
  end
end
