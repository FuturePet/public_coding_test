
import { useQuery, gql } from "@apollo/client";
import DoctorGql from "../gql/DoctorGql"
import GqlDoctorToDoctorConverter from "../conversion/GqlDoctorToDoctorConverter"

export default class DoctorService {

  // ==========================================================================
	// Class Methods
	// ==========================================================================

  /** get all doctors in the system.
  **  @return hash {
  **     doctors: list of doctors 
  **     loading: true / false are doctors still loading}
  **/ 
  static getAllDoctors() {
    const doctorResults = useQuery(DoctorGql.LIST);
    
    return {
      doctors: (new GqlDoctorToDoctorConverter())
        .convertList(doctorResults.data?.doctors),
      loading: doctorResults.loading,
    }
  }
  
}