
export default class DateUtil {

  // ==========================================================================
	// Moment.js date format strings 
	// ==========================================================================
  static momentFormatAppointmentDate = "L [at] h:m a"

  // ==========================================================================
	// Class Methods
	// ==========================================================================
  
  static getStartOfWeek (date) {
    const start = date.setDate(date.getDate() - date.getDay());
    return new Date(start);
  };

  static getEndOfWeek (date) {
    const end = date.setDate(date.getDate() + (6 - date.getDay()));
    return new Date(end);
  };
}