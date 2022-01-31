import React from "react";

const DoctorItem = ({
  id,
  lastName
}) => (
    <option value={id}>
      Dr. {lastName}
    </option>
  )

export default DoctorItem;