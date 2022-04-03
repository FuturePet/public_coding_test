
export default class Doctor {
  // man I'm missing TypeScript already! I want these to be private soooo bad :(
  id = null;
  firstName = null;
  lastName = null;

  // ==========================================================================
	// Public Methods
	// ==========================================================================

  constructor(id, firstName, lastName)
  {
    this.id = id;
    this.firstName = firstName;
    this.lastName = lastName;
  }

  // ==========================================================================
	// Getters 
	// ==========================================================================

  // get label to use for this doctor.
  // This makes docotor conform to the {id, label} spec expected by Select
  // Man how I wish I had a TS interface right now.
  get label() {
    return `Dr. ${this.lastName}`;
  }
}