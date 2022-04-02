
import { useQuery, gql } from "@apollo/client";
import DoctorGql from "../gql/DoctorGql"
import GqlDoctorToDoctorConverter from "../conversion/GqlDoctorToDoctorConverter"

export default class DoctorService {

  // ==========================================================================
	// Class Methods
	// ==========================================================================

  /** get all doctors in the system.
  **  @return a list of all docotors in the system
  **/ 
  static getAllDoctors() {
    return (new GqlDoctorToDoctorConverter())
      .convertList(useQuery(DoctorGql.LIST)?.data?.doctors)
  }
  
}