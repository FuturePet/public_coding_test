import React, { useState } from "react";
import { useQuery, gql } from "@apollo/client";

import "../css/app.scss";

const LIST_APPOINTMENTS = gql`
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

const weekDays = [
  "Sunday",
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday"
];

const monthNames = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "Septmeber",
  "October",
  "November",
  "December"
]

/**
 * 1. Update appointments to be sorted by their date/time
 * 2. Update the select to filter appointments by doctor
 * 3. Make any improvements to the code you can
 */
const Home = () => {
  const doctorResult = useQuery(LIST_DOCTORS);
  const [doctorLastName, setDoctorLastName] = useState(doctorResult?.data?.doctors[0].lastName);
  const appointmentResult = useQuery(LIST_APPOINTMENTS, {
    variables: { startDate, endDate, doctorLastName: doctorLastName ?? doctorResult?.data?.doctors[0].lastName }
  });

  const handleChange = (event) => {
    setDoctorLastName(event.target.value);
  }

  const formatDateTime = (date) => {
    let newDate = new Date(date)
    return `${monthNames[newDate.getMonth()]} ${newDate.getDate() == 1 ? `${newDate.getDate()}st` : `${newDate.getDate()}th`}, ${weekDays[newDate.getDay()]} at ${newDate.getHours()}:${newDate.getMinutes()}`
  }

  return (
    <div className="app">
      <h1>This Week's Appointments</h1>
      <select className="doctor-select" onChange={handleChange}>
        {doctorResult?.data?.doctors?.map((doctor) => (
          <option value={doctor.lastName}>Dr. {doctor.lastName}</option>
        ))}
      </select>
      {appointmentResult?.data?.appointments?.map((appointment) => (
        <div className="appointment">
          <span className="appointment-date">{formatDateTime(appointment.date)}</span>
          <span>
            Patient {appointment.pet.name} with Dr. {appointment.doctor.lastName}{" "}
          </span>
        </div>
      ))}
    </div>
  );
};

export default Home;
