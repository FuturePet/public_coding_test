defmodule GoFetchWeb.Schema.ApplicationTypesTest do
  use GoFetchWeb.ConnCase, async: true

  import GoFetch.Factory

  @appointments_query """
  query ListAppointments($startDate: String!, $endDate: String!, $doctorLastName: String!) {
    appointments(startDate: $startDate, endDate: $endDate, doctorLastName: $doctorLastName) {
      id
      reason
      date

      doctor {
        id
        firstName
        lastName
      }

      user {
        id
        email
        name
      }

      pet {
        id
        name
      }
    }
  }
  """

  @doctors_query """
  query ListDoctors {
    doctors {
      id
      firstName
      lastName
    }
  }
  """

  setup %{conn: conn} do
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
       conn: conn,
       appointment: valid_appointment,
       start_search_today: start_search_today,
       end_search_in_two_days: end_search_in_two_days
     }}
  end

  test "query: ListAppointments", %{
    conn: conn,
    appointment: appointment,
    start_search_today: start_search_today,
    end_search_in_two_days: end_search_in_two_days
  } do
    conn =
      post(conn, "/api", %{
        "query" => @appointments_query,
        "variables" => %{
          startDate: DateTime.to_string(start_search_today),
          endDate: DateTime.to_string(end_search_in_two_days),
          doctorLastName: appointment.doctor.last_name
        }
      })

    assert %{"data" => data} = json_response(conn, 200)
    assert !is_nil(data["appointments"])
    assert Enum.any?(data["appointments"], &(&1["reason"] == appointment.reason))
  end

  test "query: ListDoctors", %{
    conn: conn,
    appointment: appointment
  } do
    conn =
      post(conn, "/api", %{
        "query" => @doctors_query
      })

    assert %{"data" => data} = json_response(conn, 200)
    assert !is_nil(data["doctors"])

    assert Enum.any?(
             data["doctors"],
             &(&1["firstName"] == appointment.doctor.first_name and
                 &1["lastName"] == appointment.doctor.last_name)
           )
  end
end
