defmodule GoFetch.AppointmentTest do
  use ExUnit.Case, async: true
  alias GoFetch.Appointment

  import GoFetch.Factory

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(GoFetch.Repo)

    two_days_in_seconds = 172_800
    thirty_days_in_seconds = 2_592_000

    # Search start & end points
    start_search_today = DateTime.utc_now()
    end_search_in_two_days = DateTime.add(start_search_today, two_days_in_seconds)

    # Add appointments outside of search range
    _past_appointment = insert(:appointment, %{date: Faker.DateTime.backward(30)})
    future_appt_earliest = DateTime.add(end_search_in_two_days, 1, :second)
    future_appt_latest = DateTime.add(start_search_today, thirty_days_in_seconds, :second)

    _future_appointment =
      insert(:appointment, %{
        date: Faker.DateTime.between(future_appt_earliest, future_appt_latest)
      })

    # Add appointment within range
    valid_appointment =
      insert(:appointment, %{
        date: Faker.DateTime.between(start_search_today, end_search_in_two_days)
      })

    {:ok,
     %{
       valid_appointment: valid_appointment,
       start_search_today: start_search_today,
       end_search_in_two_days: end_search_in_two_days
     }}
  end

  describe "get_appointments_by_date/1" do
    test "only returns appointments from within the given timeframe", %{
      valid_appointment: valid_appointment,
      start_search_today: start_search_today,
      end_search_in_two_days: end_search_in_two_days
    } do
      appointments =
        Appointment.get_appointments_by_date(%{
          start_date: DateTime.to_string(start_search_today),
          end_date: DateTime.to_string(end_search_in_two_days),
          doctor_last_name: valid_appointment.doctor.last_name
        })

      assert length(appointments) == 1
      [appointment] = appointments
      assert appointment.date == valid_appointment.date
    end
  end

  describe "changesets" do
    test "changeset/2 with valid fields creates an appointment" do
      pet = insert(:pet)
      doctor = insert(:doctor)

      assert {:ok, %Appointment{}} =
               %Appointment{}
               |> Appointment.changeset(%{
                 date: DateTime.truncate(DateTime.utc_now(), :second),
                 reason: Faker.Lorem.sentence(),
                 user_id: pet.user.id,
                 pet_id: pet.id,
                 doctor_id: doctor.id
               })
               |> GoFetch.Repo.insert()
    end

    test "changeset/2 validate required fields of an appointment" do
      assert %Ecto.Changeset{
               action: _,
               changes: _,
               errors: [
                 user_id: {"can't be blank", [validation: :required]},
                 pet_id: {"can't be blank", [validation: :required]},
                 doctor_id: {"can't be blank", [validation: :required]}
               ],
               data: _,
               valid?: false
             } =
               %Appointment{}
               |> Appointment.changeset(%{
                 date: DateTime.truncate(DateTime.utc_now(), :second),
                 reason: Faker.Lorem.sentence()
               })
    end
  end
end
