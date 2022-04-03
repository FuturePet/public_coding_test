import React from "react";
import AppointmentService from "../service/AppointmentService"
import DateUtil from "../util/DateUtil";
 
export const AppointmentList = (props) => {
  const {appointments, loading} = AppointmentService
    .searchAppointments(props.startDate, props.endDate, props.doctorId);

  const processedAppointments = appointments
    .sort((appt1, appt2) => appt1.date.diff(appt2.date));

  if (loading)
  {
    return (<h3 className="text-center">Loading your appointments...</h3>);
  }
  else if (!loading && processedAppointments.length === 0)
    // if no appointments give shrug emoji lol
    return (<h3>¯\_( ⊙_ʖ⊙ )_/¯</h3>)
  else
  {
    return ( 
      <div className="appointment-list">
        {processedAppointments.map((appointment) => (
          <div className="appointment" key={appointment.id}>
            <span className="appointment-date">
              {appointment.date.format(DateUtil.momentFormatAppointmentDate)}
            </span>
            <span>
              for {appointment.pet.name} with Dr. {appointment.doctor.lastName}
            </span>
          </div>
        ))}
      </div>
    );
  }
}