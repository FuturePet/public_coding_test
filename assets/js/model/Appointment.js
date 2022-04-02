
export default class Appointment {
  id = null;
  reason = null;
  date = null;

  // ==========================================================================
	// Associations
	// ==========================================================================

  doctor = null;
  // Just as I did for doctor I would define models & converts for the user and pet types.
  // I'm going to omit it for now just to save time.
  user = null;
  pet = null;

  // ==========================================================================
	// Public Methods
	// ==========================================================================

  /**
  ** Build a new appointment 
  ** @param id - appointment id 
  ** @param reason - appoitnment reason string 
  ** @param date - date of the appointment 
  ** @param doctor - the doctor to which the appointment is associated 
  ** @param user - the user to which the appointment is associated 
  ** @param pet - the pet to which the appointment is associated 
  **/
  constructor(id, reason, date, doctor = null, user = null, pet = null) {
    this.id = id;
    this.reason = reason;
    this.date = date;
    this.doctor = doctor;
    this.user = user;
    this.pet = pet;
  }
}