import React from "react";
import { useQuery, gql } from "@apollo/client";
import AppointmentGql from "../gql/AppointmentGql";
import DoctorGql from "../gql/DoctorGql";
import DoctorService from "../service/DoctorService";
import AppointmentService from "../service/AppointmentService"
import DateUtil from "../util/DateUtil";

const startDate = DateUtil.getStartOfWeek(new Date());
const endDate = DateUtil.getEndOfWeek(new Date());

export const HomePage = () => {
  
  const appointments = AppointmentService.getAppointmentsInDateRange(startDate, endDate);
  const doctors = DoctorService.getAllDoctors();

  return (
    <div className="app"> 
      <h1>This Week's Appointments</h1>
      <select>
        {doctors?.map((doctor) => (
          <option value={doctor.id} key={doctor.id}>Dr. {doctor.lastName}</option>
        ))}
      </select>
      {appointments.map((appointment) => (
        <div className="appointment" key={appointment.id}>
          <span className="appointment-date">
            {appointment.date.format(DateUtil.momentFormatAppointmentDate)}
          </span>
          <span>
            For {appointment.pet.name} with Dr. {appointment.doctor.lastName}{" "}
          </span>
        </div>
      ))}
    </div>
  );
} 