import { gql } from "@apollo/client";

export default class AppointmentGql {

  // ==========================================================================
	// Queries
	// ==========================================================================
  
  static LIST = gql`
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
}