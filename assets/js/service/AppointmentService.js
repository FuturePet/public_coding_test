import { useQuery, gql } from "@apollo/client";
import AppointmentGql from "../gql/AppointmentGql"
import GqlAppointmentToAppointmentConverter 
  from "../conversion/GqlAppointmentToAppointmentConverter"

export default class AppointmentService {
  // ==========================================================================
	// Class Methods
	// ==========================================================================

  /**
  ** Get appointmetns in the given date range 
  ** @param startDate - the start of the date range 
  ** @param endDate - the end of the date rane 
  ** @return list of appointments within the date range 
  **/
  static getAppointmentsInDateRange(startDate, endDate) {
    const appointmentResults = useQuery(AppointmentGql.LIST, 
                                        {variables: { startDate, endDate }});
    return (new GqlAppointmentToAppointmentConverter())
      .convertList(appointmentResults?.data?.appointments)
  }
}