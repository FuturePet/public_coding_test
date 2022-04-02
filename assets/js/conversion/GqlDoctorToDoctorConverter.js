import ConverterBase from "./ConverterBase"
import Doctor from "../model/Doctor"

export default class GlqDoctorToDoctorConverter extends ConverterBase {
  
  // ==========================================================================
	// Conversion
	// ==========================================================================

  /** convert GqlDoctor to Docotor 
  **  @param gqlDoc - the gql doctor to convert 
  **  @return - gqlDoc converted to Doctor model
  **/
  convert(gqlDoc) {
    return new Doctor(gqlDoc.id, gqlDoc.firstName, gqlDoc.lastName)
  }
}