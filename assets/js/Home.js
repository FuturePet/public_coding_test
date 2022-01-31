import React, { useState, useEffect } from "react";
import { useQuery } from "@apollo/client";
import { LIST_DOCTORS } from './graphQl/doctors';

import "../css/app.scss";
import AppointmmentList from './components/AppointmentList';
import DoctorItem from './components/DoctorItem';

/**
 * 1. Update appointments to be sorted by their date/time
 * 2. Update the select to filter appointments by doctor
 * 3. Make any improvements to the code you can
 */

const Home = () => {
  const dataDoctor = useQuery(LIST_DOCTORS);
  const [doctorSelected, setDoctorSelected] = useState(null);

  useEffect(() => {
    if (
      dataDoctor ?.data ?.doctors.length > 0
        && !doctorSelected 
    ) {
      setDoctorSelected(dataDoctor ?.data ?.doctors[0].id);
    }
  }, [dataDoctor]);

  const onSelectDoctor = (event) => {
    setDoctorSelected(event.target.value);
  }

  const renderDoctorList = dataDoctor ?.data ?.doctors ?.map((doctor) => (
    <DoctorItem
      key={doctor.id}
      {...doctor}
    />
  ))

  return (
    <div className="app">
      <h1>This Week's Appointments</h1>
      <select onChange={onSelectDoctor}>
        {renderDoctorList}
      </select>
      <AppointmmentList
        doctorSelected={doctorSelected}
        onSelectDoctor
      />
    </div>
  );
};

export default Home;
