
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
}