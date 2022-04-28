import React from "react";

import { useState } from "react";
import { useQuery, gql } from "@apollo/client";
import AppointmentCard from "../../components/Appointment";

import './style.scss';

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
  const [selectedDoctorId, setSelectedDoctorId] = useState('');
  const appointmentResult = useQuery(LIST_APPOINTMENTS, {
    variables: { startDate, endDate }
  });
  const doctorResult = useQuery(LIST_DOCTORS);

  const handleChangeDoctor = (doctorId) => {
    setSelectedDoctorId(doctorId)
  }

  if(doctorResult.loading || appointmentResult.loading) return (<p> Loading... </p>)

  return (
    <div className="Home">
      <h1>This Week's Appointments</h1>
      <select
        className="FormSelect"
        value={selectedDoctorId}
        onChange={e => handleChangeDoctor(e.target.value)}>
        <option value=''>(All)</option>
        {doctorResult?.data?.doctors?.map((doctor) => (
          <option key={doctor.id} value={doctor.id}>Dr. {doctor.lastName}</option>
        ))}
      </select>
      {appointmentResult?.data?.appointments?.filter((appointment) => {
        if (selectedDoctorId) return appointment.doctor.id == selectedDoctorId;
        return true;
      })
      .sort((a, b) => a.date > b.date ? 1 : -1)
      .map((appointment) => (
        <AppointmentCard key={appointment.id} appointment={appointment} />
      ))}
    </div>
  );
};

export default Home;
