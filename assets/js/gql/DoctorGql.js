import { gql } from "@apollo/client";

export default class DoctorGql {
  
  // ==========================================================================
	// Queries
	// ==========================================================================
  
  static LIST = gql`
    query ListDoctors {
      doctors {
        id
        firstName
        lastName
      }
    }
  `;
}