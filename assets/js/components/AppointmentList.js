

export const AppointmentList (props) => {

  const appointments = AppointmentService.getAppointmentsInDateRange(
    props.startDate, props.endDate);

  return (
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
  );
}