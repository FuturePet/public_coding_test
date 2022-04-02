import moment from "moment"
import ConverterBase from "./ConverterBase"
import Appointment from "../model/Appointment"
import GqlDoctorToDoctorConverter from "./GqlDoctorToDoctorConverter"

export default class GqlAppointmentToAppointmentConverter extends ConverterBase {
  
  // ==========================================================================
	// Conversion
	// ==========================================================================

  /** convert GqlAppointment to Appointment 
  **  @param gqlAppointment - the gql appointment to convert 
  **  @return - gqlAppointment converted to Appointment model
  **/
  convert(gqlAppointment) {
    return new Appointment(
      gqlAppointment.id,
      gqlAppointment.reason,
      moment(gqlAppointment.date),
      (new GqlDoctorToDoctorConverter()).convert(gqlAppointment.doctor),
      gqlAppointment.user, // <= These should have models just like Doctor. Omitted for time.
      gqlAppointment.pet);
  }
}