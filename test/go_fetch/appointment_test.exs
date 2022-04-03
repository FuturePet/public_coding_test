defmodule GoFetch.AppointmentTest do
  use ExUnit.Case
  alias GoFetch.Appointment
  alias GoFetch.Repo

  import GoFetch.Factory

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(GoFetch.Repo)
  end

  describe "get_appointments_by_date/1" do
    test "only returns appointments from within the given timeframe" do

      # DEV commentary 
      # I'm not sure if this was intended or not. This unit test randomly fails.
      # At first I assumed I must have done some thing wrong 
      # after all I don't know the language or the libraries. 
      # But after investigation I found out the Faker.DateTime.forward was being 
      # miss used in this unit test. See: 
      # https://hexdocs.pm/faker/Faker.DateTime.html#forward/1
      # The doc clearly states "Returns a random date in the future up to N days, today not included".
      # This has two effects. 
      # 1. The valid appointment could some times end up outside of the search range.
      # 2. The future appointment could some times (very rare) end up inside the search range. 
      # I have corrected these problems.

      start_date = DateTime.utc_now()
      end_date = DateTime.add(start_date, 172_800) # + 2 days

      # setup future appointment stat / end dates
      future_appointment_offset = 172_810 # 2 days 
      future_appointment_end_offset = 2_592_000 # 30 days
      future_appointment_between_start = DateTime.add(start_date, future_appointment_offset, :second)
      future_appointment_between_end = DateTime.add(end_date, future_appointment_offset + future_appointment_end_offset, :second)

      # insert mock data
      past_appointment = insert(:appointment, %{date: Faker.DateTime.backward(30)})
      future_appointment = insert(:appointment, %{date: Faker.DateTime.between(future_appointment_between_start, future_appointment_between_end)})
      valid_appointment = insert(:appointment, %{date: Faker.DateTime.between(start_date, end_date)})

      appointments =
        Repo.all(
          Appointment.get_appointments_by_date(%{
            start_date: DateTime.to_string(start_date),
            end_date: DateTime.to_string(end_date)
          }))

      assert length(appointments) == 1
      [appointment] = appointments
      assert appointment.date == valid_appointment.date
    end
  end

  describe "where_doctor/1" do
    test "Only returns appointments assigned to the specified doctor" do
      fake_doc_1 = insert(:doctor, %{first_name: "fake1"})
      fake_doc_2 = insert(:doctor, %{first_name: "fake2"})

      insert(:appointment, %{doctor: fake_doc_1})
      insert(:appointment, %{doctor: fake_doc_1})
      insert(:appointment, %{doctor: fake_doc_2})

      # At my current job this is what we call testint the ORM. Generally we 
      # wouldn't write unit tests for simple ORM logic. I'm not sure 
      # what you would prefer so I added this little guy :) 
      appointments = Repo.all(Appointment.where_doctor(fake_doc_2.id))

      assert length(appointments) == 1
    end 

    test "Filter has no effect when doctor_id nil" do 
      fake_doc_1 = insert(:doctor, %{first_name: "fake1"})
      fake_doc_2 = insert(:doctor, %{first_name: "fake2"})

      insert(:appointment, %{doctor: fake_doc_1})
      insert(:appointment, %{doctor: fake_doc_1})
      insert(:appointment, %{doctor: fake_doc_2})

      appointments = Repo.all(Appointment.where_doctor(nil))

      assert length(appointments) == 3
    end 
  end 
end
