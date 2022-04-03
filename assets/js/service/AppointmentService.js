import { useQuery, gql } from "@apollo/client";
import AppointmentGql from "../gql/AppointmentGql"
import GqlAppointmentToAppointmentConverter 
  from "../conversion/GqlAppointmentToAppointmentConverter"

export default class AppointmentService {
  // ==========================================================================
	// Class Methods
	// ==========================================================================

  /**
  ** search appointments
  ** @param startDate - the start of the date range 
  ** @param endDate - the end of the date rane 
  ** @param doctorId - [optional] limit results to only appointments with the 
  **                   specified doctor
  ** @return hash {appointments: the appointment list,
  **               loading: true / false}
  **/
  static searchAppointments(startDate, endDate, doctorId = null) {
    const appointmentResults = useQuery(AppointmentGql.LIST, 
                                        {variables: {
                                          startDate,
                                          endDate,
                                          doctorId,
                                        }});
    return {
      appointments: (new GqlAppointmentToAppointmentConverter())
      .convertList(appointmentResults?.data?.appointments),
      loading: appointmentResults.loading
    }
  }
}