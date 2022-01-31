import React from "react";

import "../../css/app.scss";

const AppointmentItem = ({
  id,
  date,
  doctor: {
    lastName
  },
  pet: {
    name
  }
}) => {
  const numDate = Date.parse(date);
  const formatDate = new Date(numDate);

  return(
    <div className="appointment">
      <span className="appointment-date">{formatDate.toString()}</span>
      <span>
        {name} with Dr. {lastName}{" "}
      </span>
    </div>
  );
}

export default AppointmentItem;
