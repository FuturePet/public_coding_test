import { gql } from "@apollo/client";

export const LIST_DOCTORS = gql`
  query ListDoctors {
    doctors {
      id
      firstName
      lastName
    }
  }
`;
