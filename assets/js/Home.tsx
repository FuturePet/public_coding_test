import React from "react";
import { useQuery, gql } from "@apollo/client";

import "../css/app.scss";

const LIST_APPOINTMENTS = gql`
  query ListAppointments($startDate: String!, $endDate: String!) {
    appointments(startDate: $startDate, endDate: $endDate) {
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
`;

const LIST_DOCTORS = gql`
  query ListDoctors {
    doctors {
      id
      firstName
      lastName
    }
  }
`;

const getStartOfWeek = (date) => {
  const start = date.setDate(date.getDate() - date.getDay());
  return new Date(start);
};

const getEndOfWeek = (date) => {
  const end = date.setDate(date.getDate() + (6 - date.getDay()));
  return new Date(end);
};

const startDate = getStartOfWeek(new Date());
const endDate = getEndOfWeek(new Date());

/**
 * 1. Update appointments to be sorted by their date/time
 * 2. Update the select to filter appointments by doctor
 * 3. Make any improvements to the code you can
 */
const Home = () => {
  const appointmentResult = useQuery(LIST_APPOINTMENTS, {
    variables: { startDate, endDate },
  });
  const doctorResult = useQuery(LIST_DOCTORS);

  return (
    <div className="app">
      <h1>This Week's Appointments</h1>
      <select>
        {doctorResult?.data?.doctors?.map((doctor) => (
          <option value={doctor.id}>Dr. {doctor.lastName}</option>
        ))}
      </select>
      {appointmentResult?.data?.appointments?.map((appointment) => (
        <div className="appointment">
          <span className="appointment-date">{appointment.date}</span>
          <span>
            {appointment.pet.name} with Dr. {appointment.doctor.lastName}{" "}
          </span>
        </div>
      ))}
    </div>
  );
};

export default Home;
