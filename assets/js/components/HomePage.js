import React, {useState} from "react";
import { AppointmentList } from "./AppointmentList";
import { Dropdown } from "./Dropdown";
import DoctorService from "../service/DoctorService";
import DateUtil from "../util/DateUtil";

const startDate = DateUtil.getStartOfWeek(new Date());
const endDate = DateUtil.getEndOfWeek(new Date());

export const HomePage = () => {
  const {doctors, loading} = DoctorService.getAllDoctors();
  let [selectedDoctorId, setSelectedDoctorId] = useState(null);

  // set initial value once doc list loaded 
  if (!loading && !selectedDoctorId)
  {
    setSelectedDoctorId(doctors[0]?.id)
  }

  return (
    <div className="app home-page"> 
      <h2 className="text-center">This Week's Appointments</h2>

      <Dropdown value={selectedDoctorId}
                className="doc-select"
                options={doctors}
                onChange={(event) => setSelectedDoctorId(event.target.value)}>
      </Dropdown>

      { loading
          ? (<h3>Fetching Doctors...</h3>)
          : (
            <AppointmentList startDate={startDate}
                     endDate={endDate} 
                     doctorId={selectedDoctorId}
            />
          )}
    </div>
  );
} 