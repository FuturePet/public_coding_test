import React from "react";

export const Dropdown = (props) => {

  if (!props.options || props.options.length === 0) {
    return (      
      <select className="dropdown">
      </select>)
  }
  else {
    return (      
      <select className="dropdown"
              value={props.value}
              onChange={(event) => props.onChange && props.onChange(event)}>
        {props.options?.map((item) => (
          <option value={item.id} key={item.id}>
            {item.label}
          </option>
        ))}
        </select>)
  }
}
