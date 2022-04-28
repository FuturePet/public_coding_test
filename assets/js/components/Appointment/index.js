import React from "react";

import './style.scss';

const INTL_OPTIONS = { day: 'numeric', month: 'numeric', year: 'numeric', hour: 'numeric', minute: 'numeric', hour12: false }

const formatter = Intl.DateTimeFormat('default', INTL_OPTIONS)

const humanizeDate = (dateString) => {
  const date = new Date(dateString);
  const result = formatter.format(date);

  return result;
}

const AppointmentCard = ({ appointment: appointment }) => {
  const { date: appointmentDate, doctor: doctor, pet: pet } = appointment
  const { lastName: doctorLastName } = doctor
  const { name: petName } = pet

  return (
    <div className="Appointment">
      <div>{humanizeDate(appointmentDate)}</div>
      <div>
        {petName} with Dr. {doctorLastName}
      </div>
    </div>
  );
};

export default AppointmentCard;
