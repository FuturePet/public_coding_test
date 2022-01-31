import React, { useState, useEffect } from "react";
import { useQuery } from "@apollo/client";
import { LIST_APPOINTMENTS } from '../graphQl/appointments';
import { startDate, endDate } from '../utils/utils'

import "../../css/app.scss";
import AppointmentItem from './AppointmentItem';


const AppointmentList = ({
  doctorSelected,
  onSelectDoctor
}) => {
  const [appointments, setAppointments] = useState([]);
  const dataAppoint = useQuery(LIST_APPOINTMENTS, {
    variables: { startDate, endDate },
  });

  useEffect(() => {
    if (dataAppoint ?.data ?.appointments ?.length > 0) {
      setAppointments(dataAppoint ?.data ?.appointments);
    }
  }, [ dataAppoint]);

  const dataAppointList = [...appointments];

  const sortAppointList = dataAppointList.sort((a, b) => {
    const aDate = Date.parse(a.date);
    const bDate = Date.parse(b.date);

    return aDate - bDate;
  });

  const renderAppointList = sortAppointList.map((appointment) => {
    if (appointment.doctor.id === doctorSelected) {
      return (
        <AppointmentItem
          key={appointment.id}
          {...appointment}
        />
      )
    }
  });
  
  return renderAppointList
};

export default AppointmentList;
